//
//  NoteRow.swift
//  Notes_Calci
//
//  Created by Jahnavi Vemuri on 17/06/24.
//

import SwiftUI

struct NoteRow: View {
    var note: Note
    var isSelectionMode: Bool
    var isSelected: Bool
    var onSelect: () -> Void
    var onTap: () -> Void
    var onDelete: () -> Void
    var onContextMenuSelect: () -> Void

    var body: some View {
        HStack {
            if isSelectionMode {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.orange)
                    .onTapGesture(perform: onSelect)
            }
            Text(note.note)
                .lineLimit(1)
                .onTapGesture(perform: onTap)
                .swipeActions {
                    Button("Delete", role: .destructive, action: onDelete)
                }
                .contextMenu {
                    Button(action: onContextMenuSelect) {
                        Label("Select", systemImage: "checkmark.circle")
                    }
                    Button(role: .destructive, action: onDelete) {
                        Label("Delete", systemImage: "trash")
                    }
                }
        }
    }
}
