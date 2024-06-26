//
//  NotesData.swift
//  Notes_Calci
//
//  Created by Jahnavi Vemuri on 21/05/24.
//

import Foundation
import SwiftData

@Model
class Note {
    var id: UUID
    var note: String
    
    init(id: UUID=UUID(), note: String, creationDate: Date=Date()) {
        self.id = id
        self.note = note
    }
}
