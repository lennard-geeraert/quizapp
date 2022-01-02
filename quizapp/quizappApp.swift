//
//  quizappApp.swift
//  quizapp
//
//  Created by Lennard Geeraert on 24/12/2021.
//

import SwiftUI

@main
struct quizappApp: App {
    // here you van use let because class is a pointer and so doesn't really changes, but the class does
    let game = quizappViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
