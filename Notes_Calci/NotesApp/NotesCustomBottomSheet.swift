//
//  NotesCustomBottomSheet.swift
//  Notes_Calci
//
//  Created by Jahnavi Vemuri on 20/05/24.
//

import SwiftUI

struct CustomBottomSheet<Content: View>: View {
    @Binding var isPresented: Bool
    let content: Content

    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            if isPresented {
                VStack {
                    Spacer()
                    VStack {
                        content
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height / 3)
                    .background(Color.gray)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .transition(.move(edge: .bottom))
                    .animation(.spring())
                }
                .background(Color.black.opacity(0.4)
                                .edgesIgnoringSafeArea(.all)
                                .onTapGesture {
                                    isPresented = false
                                })
            }
        }
    }
}

struct BottomSheetView: View {
    @Binding var text: String
    var onSave: () -> Void
    @Binding var isSheetPresented: Bool

    var body: some View {
        VStack {
            TextField("Title", text: $text, axis: .vertical)
                .lineLimit(5...10)
                .foregroundColor(.white)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(8)
            
            HStack {
                Spacer()
                Button(action: {
                    if !text.isEmpty {
                        onSave()
                        isSheetPresented = false
                    }
                }) {
                    Text("Done")
                        .foregroundColor(text.isEmpty ? .black : .orange)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
                .padding()
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
    }
}
