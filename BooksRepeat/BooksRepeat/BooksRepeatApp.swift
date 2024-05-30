//
//  BooksRepeatApp.swift
//  BooksRepeat
//
//  Created by Isabel Romero on 7/5/24.
//

import SwiftUI
import SwiftData

@main
struct BooksApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(Color.blue)
        }
        .modelContainer(for: Book.self)
    }
}
