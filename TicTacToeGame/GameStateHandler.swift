//
//  GameStateHandler.swift
//  TicTacToeGame
//
//  Created by Arvid Rydh on 2022-11-29.
//

import Foundation

class GameStateHandler {
    
    var activePlayer = "X"
    
    func endTurn() {
        switch activePlayer {
        case "X":
            activePlayer = "O"
        case "O":
            activePlayer = "X"
        default:
            activePlayer = "X"
        }
    }
}
