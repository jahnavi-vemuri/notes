//
//  ContentView.swift
//  Notes_Calci
//
//  Created by Jahnavi Vemuri on 15/05/24.
//

import SwiftUI

struct BaseView: View {
    var body: some View {
        NavigationView{
            HStack {
                NavigationLink(destination: NotesView()){
                    Image("notes")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(.trailing, 20)
                }
                NavigationLink(destination: CalciView()){
                    Image("calci")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding()
                }
            }
            .padding()
        }
    }
}

#Preview {
    BaseView()
}
