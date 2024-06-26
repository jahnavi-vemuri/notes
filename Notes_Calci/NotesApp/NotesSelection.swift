import SwiftUI
import SwiftData

struct NotesSelection {
    static func toggleSelection(for note: Note, selectedNotes: inout Set<Note>, in modelContext: ModelContext) {
        if selectedNotes.contains(note) {
            selectedNotes.remove(note)
        } else {
            selectedNotes.insert(note)
        }
        saveContext(modelContext: modelContext)
    }

    static func startSelectionMode(for note: Note, isSelectionMode: inout Bool, selectedNotes: inout Set<Note>, in modelContext: ModelContext) {
        withAnimation {
            isSelectionMode = true
            selectedNotes.insert(note)
        }
    }

    static func toggleSelectAllNotes(notes: [Note], selectedNotes: inout Set<Note>, in modelContext: ModelContext) {
        if selectedNotes.count == notes.count {
            selectedNotes.removeAll()
        } else {
            selectedNotes = Set(notes)
        }
        saveContext(modelContext: modelContext)
    }

    static func saveNote(selectedNote: inout Note?, bottomSheetText: String, modelContext: ModelContext, selectedNotes: inout Set<Note>) {
        if let note = selectedNote {
            note.note = bottomSheetText
        } else {
            let newNote = Note(
                id: UUID(),
                note: bottomSheetText
            )
            modelContext.insert(newNote)
        }
        saveContext(modelContext: modelContext)
        selectedNote = nil
    }

    static func delete(note: Note, from selectedNotes: inout Set<Note>, in modelContext: ModelContext) {
        modelContext.delete(note)
        selectedNotes.remove(note)
        saveContext(modelContext: modelContext)
    }

    static func deleteSelectedNotes(selectedNotes: inout Set<Note>, modelContext: ModelContext, isSelectionMode: inout Bool) {
        for note in selectedNotes {
            modelContext.delete(note)
        }
        saveContext(modelContext: modelContext)
        isSelectionMode = false
        selectedNotes.removeAll()
    }

    static func deleteAllNotes(notes: [Note], modelContext: ModelContext) {
        for note in notes {
            modelContext.delete(note)
        }
        saveContext(modelContext: modelContext)
    }

    static func saveContext(modelContext: ModelContext) {
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
