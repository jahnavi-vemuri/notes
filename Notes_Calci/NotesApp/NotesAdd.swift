//
//  AddNoteButton.swift
//  Notes_Calci
//
//  Created by Jahnavi Vemuri on 17/06/24.
//

import SwiftUI

struct AddNoteButton: View {
    var action: () -> Void
    @State private var showReminderAlert = false
    
    var body: some View {
        HStack {
            Button(action:{
                showReminderAlert = true
            }){
                HStack {
                         Text("Set Reminder")
                         Image(systemName: "clock")
                        }
                        .padding(5)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
            }
            .alert(isPresented: $showReminderAlert){
                Alert(  
                    title: Text("Allow Notifications"),
                    message: Text("Do you want to all notifications?"),
                    primaryButton: .default(Text("Allow")){
                        
                    },
                    secondaryButton : .cancel(Text("Don't Allow"))
                )
                
            }
            Spacer()
            Button(action: action) {
                Image(systemName: "plus")
                    .resizable()
                    .padding(20)
                    .frame(width: 65, height: 65)
                    .background(Color.orange)
                    .clipShape(Circle())
                    .foregroundColor(.white)
                    .padding(10)
            }
        }
    }
}
