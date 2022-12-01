//
//  GameStateHandler.swift
//  TicTacToeGame
//
//  Created by Arvid Rydh on 2022-11-29.
//

import Foundation

class GameStateHandler {
    
    var activePlayer = TileStatus.X
    var gameOver = false
    
    var boardGrid = [[TileStatus]]()
    
    init() {
        newGame()
    }
    
    func newGame() {
        gameOver = false
        activePlayer = TileStatus.X
        makeBoard()
    }
    
    func makeBoard() {
        boardGrid.removeAll()
        for _ in 1...3 {
            var boardRow = [TileStatus]()
            for _ in 1...3 {
                boardRow.append(TileStatus.empty)
            }
            boardGrid.append(boardRow)
        }
    }
    
    func endTurn() {
        switch activePlayer {
        case .X:
            activePlayer = .O
        case .O:
            activePlayer = .X
        default:
            activePlayer = .X
        }
    }
    
    func placeAt(viewID: Int) {
        
        let yCord = viewID / 3
        let xCord = viewID % 3

        boardGrid[yCord][xCord] = activePlayer
        
        print(boardGrid)
    }
    
    func checkForWin() -> String {
        
        for i in 0...2 {
            if (boardGrid[i][0] == boardGrid[i][1] && boardGrid[i][0] == boardGrid[i][2] && boardGrid[i][0] != .empty) || (boardGrid[0][i] == boardGrid[1][i] && boardGrid[0][i] == boardGrid[2][i] && boardGrid[0][i] != .empty) {
                gameOver = true
                return "win"
            }
        }
        
        if (boardGrid[0][0] == boardGrid[1][1] && boardGrid[0][0] == boardGrid[2][2] && boardGrid[0][0] != .empty) || (boardGrid[0][2] == boardGrid[1][1] && boardGrid[0][2] == boardGrid[2][2] && boardGrid[0][2] != .empty) {
            gameOver = true
            return "win"
        }
        
        if !boardGrid[0].contains(.empty) && !boardGrid[1].contains(.empty) && !boardGrid[2].contains(.empty) {
            return "tie"
        }
        
        return "false"
    }

    
}

enum TileStatus: String {
    case empty
    case X
    case O
}
