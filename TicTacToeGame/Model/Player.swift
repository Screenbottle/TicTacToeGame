//
//  Player.swift
//  TicTacToeGame
//
//  Created by Arvid Rydh on 2022-12-08.
//

import Foundation

class Player {
    
    var name: String
    var wins: Int
    
    init(name: String) {
        self.name = name
        self.wins = 0
    }
    
    func playerWins() {
        wins += 1
    }
    
}
