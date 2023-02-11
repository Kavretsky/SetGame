//
//  SetGameApp.swift
//  SetGame
//
//  Created by Nikolay Kavretsky on 01.02.2023.
//

import SwiftUI

@main
struct SetGameApp: App {
    let game = GameViewModel()
    var body: some Scene {
        WindowGroup {
            GameView(game: game)
        }
    }
}
