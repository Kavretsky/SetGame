//
//  SetGameApp.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 01.02.2023.
//

import SwiftUI

@main
struct SetGameApp: App {
    private let setGame = GameViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(game: setGame)
        }
    }
}
