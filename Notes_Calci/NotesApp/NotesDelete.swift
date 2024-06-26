//
//  DeleteButton.swift
//  Notes_Calci
//
//  Created by Jahnavi Vemuri on 17/06/24.
//

import SwiftUI

struct DeleteButton: View {
    @Binding var showingAlert: Bool

    var body: some View {
        Button(action: {
            showingAlert = true
        }) {
            Image(systemName: "trash")
                .resizable()
                .frame(width: 24, height: 24)
                .padding()
                .background(Color.orange)
                .clipShape(Circle())
                .foregroundColor(.white)
        }
    }
}
