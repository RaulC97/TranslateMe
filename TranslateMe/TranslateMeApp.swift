//
//  TranslateMeApp.swift
//  TranslateMe
//
//  Created by Raul Chavez on 11/6/24.
//

import SwiftUI
import FirebaseCore // <-- Import Firebase

@main
struct FireChatApp: App {

    init() { // <-- Add an init
        FirebaseApp.configure() // <-- Configure Firebase app
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
