import SwiftUI
import SwiftData

struct NotesView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Query(sort: \Note.note, order: .forward, animation: .smooth) var notes: [Note]
    
    @State private var searchNote: String = ""
    @State private var isSheetPresented: Bool = false
    @State private var bottomSheetText: String = ""
    @State private var selectedNote: Note?
    @State private var showingAlert = false
    @State private var isSelectionMode: Bool = false
    @State private var selectedNotes: Set<Note> = []

    private var filteredNotes: [Note] {
        if searchNote.isEmpty {
            return notes
        } else {
            return notes.filter { $0.note.localizedCaseInsensitiveContains(searchNote) }
        }
    }
    
    private var areAllNotesSelected: Bool {
        return selectedNotes.count == notes.count
    }

    var body: some View {
        ZStack {
            VStack {
                if isSelectionMode {
                    NotesTopBar(
                        isSelectionMode: $isSelectionMode,
                        selectedNotes: $selectedNotes,
                        areAllNotesSelected: .constant(areAllNotesSelected),
                        toggleSelectAllNotes: toggleSelectAllNotes
                    )
                }
                SearchBar(text: $searchNote)
                List(filteredNotes) { note in
                    NoteRow(
                        note: note,
                        isSelectionMode: isSelectionMode,
                        isSelected: selectedNotes.contains(note),
                        onSelect: { NotesSelection.toggleSelection(for: note, selectedNotes: &selectedNotes, in: modelContext) },
                        onTap: {
                            if isSelectionMode {
                                NotesSelection.toggleSelection(for: note, selectedNotes: &selectedNotes, in: modelContext)
                            } else {
                                selectedNote = note
                                bottomSheetText = note.note
                                isSheetPresented = true
                            }
                        },
                        onDelete: { NotesSelection.delete(note: note, from: &selectedNotes, in: modelContext) },
                        onContextMenuSelect: {
                            NotesSelection.startSelectionMode(
                                for: note,
                                isSelectionMode: &isSelectionMode,
                                selectedNotes: &selectedNotes,
                                in: modelContext
                            )
                        }
                    )
                }
                Spacer()
                if isSelectionMode {
                    DeleteButton(showingAlert: $showingAlert)
                        .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("Delete Selected Notes"),
                                message: Text("Are you sure you want to delete selected notes?"),
                                primaryButton: .destructive(Text("Delete")) {
                                    NotesSelection.deleteSelectedNotes(
                                        selectedNotes: &selectedNotes,
                                        modelContext: modelContext,
                                        isSelectionMode: &isSelectionMode
                                    )
                                },
                                secondaryButton: .cancel(Text("Cancel"))
                            )
                        }
                } else {
                    AddNoteButton {
                        selectedNote = nil
                        bottomSheetText = ""
                        isSheetPresented = true
                    }
                }
            }
            if isSheetPresented {
                CustomBottomSheet(isPresented: $isSheetPresented) {
                    BottomSheetView(text: $bottomSheetText, onSave: saveNote, isSheetPresented: $isSheetPresented)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func toggleSelectAllNotes() {
        NotesSelection.toggleSelectAllNotes(notes: notes, selectedNotes: &selectedNotes, in: modelContext)
    }
    
    private func saveNote() {
        NotesSelection.saveNote(
            selectedNote: &selectedNote,
            bottomSheetText: bottomSheetText,
            modelContext: modelContext,
            selectedNotes: &selectedNotes
        )
        isSheetPresented = false
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
