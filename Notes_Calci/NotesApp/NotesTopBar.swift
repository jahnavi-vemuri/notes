//
//  NotesTopBar.swift
//  Notes_Calci
//
//  Created by Jahnavi Vemuri on 17/06/24.
//

import SwiftUI

struct NotesTopBar: View {
    @Binding var isSelectionMode: Bool
    @Binding var selectedNotes: Set<Note>
    @Binding var areAllNotesSelected: Bool
    var toggleSelectAllNotes: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    isSelectionMode = false
                    selectedNotes.removeAll()
                }
            }) {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.orange)
                    .padding()
            }
            Spacer()
            Text("\(selectedNotes.count) Selected")
                .font(.headline)
            Spacer()
            Button(action: toggleSelectAllNotes) {
                Image(systemName: areAllNotesSelected ? "checklist.checked" : "checklist.unchecked")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.orange)
                    .padding()
            }
        }
        .padding(.horizontal)
    }
}
