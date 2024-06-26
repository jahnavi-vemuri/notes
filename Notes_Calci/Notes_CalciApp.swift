//
//  Notes_CalciApp.swift
//  Notes_Calci
//
//  Created by Jahnavi Vemuri on 15/05/24.
//

import SwiftUI
import SwiftData

@main
struct Notes_CalciApp: App {
    var body: some Scene {
        WindowGroup {
            BaseView()
                .modelContainer(for: [Note.self])
        }
    }
}
