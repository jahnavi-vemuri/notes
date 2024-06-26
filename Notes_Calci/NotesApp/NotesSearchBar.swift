//
//  NotesSearchBar.swift
//  Notes_Calci
//
//  Created by Jahnavi Vemuri on 20/05/24.
//

import Foundation
import SwiftUI

struct SearchBar: View{
    @Binding var text: String
    var body: some View{
        HStack{
            TextField("Search for tasks", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 15)
        }
        .padding(.top, 8)
    }
}
