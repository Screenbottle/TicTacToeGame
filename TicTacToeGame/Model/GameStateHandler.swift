//
//  GameStateHandler.swift
//  TicTacToeGame
//
//  Created by Arvid Rydh on 2022-11-29.
//

import Foundation

class GameStateHandler {
    
    var activePlayer : TileStatus
    var activePlayerName: String
    var gameOver: Bool
    var gameType: GameType
    var player1Name: String
    var player2Name: String
    
    private var boardGrid = [[TileStatus]]()
    private var availableTileIDs = [Int]()
    
    init(sentGameType: GameType = .singlePlayer, player1Name: String = "Player 1", player2Name: String = "Player 2") {
        
        self.gameOver = false
        self.activePlayer = .X
        self.gameType = sentGameType
        self.player1Name = player1Name
        
        if self.gameType == .singlePlayer {
            self.player2Name = "Computer"
        }
        else {
            self.player2Name = player2Name
        }
        self.activePlayerName = player1Name
        
        makeBoard()
        
    }
    
    // resets the game
    func newGame() {
        gameOver = false
        activePlayer = .X
        activePlayerName = player1Name
        makeBoard()
    }
    
    // generates a new empty board
    func makeBoard() {
        boardGrid.removeAll()
        for _ in 1...3 {
            var boardRow = [TileStatus]()
            for _ in 1...3 {
                boardRow.append(TileStatus.empty)
            }
            boardGrid.append(boardRow)
        }
        
        availableTileIDs = (0...8).map{$0}
    }
    
    // changes who the current player is
    func endTurn() {
        switch activePlayer {
        case .X:
            activePlayer = .O
            activePlayerName = player2Name
        case .O:
            activePlayer = .X
            activePlayerName = player1Name
        default:
            activePlayer = .X
        }
    }
    
    func placeAt(viewID: Int) {
        // the viewID is an int with a value from 0 to 8, converts it to x and y coordinates so it can be placed in the array
        let yCord = viewID / 3
        let xCord = viewID % 3

        boardGrid[yCord][xCord] = activePlayer
        
        // removes the tile from the list of available tiles, used in singleplayer
        if let index = availableTileIDs.firstIndex(of: viewID) {
            availableTileIDs.remove(at: index)
        }
    }
    
    func checkForWin() -> String {
        
        // checks rows and columns
        for i in 0...2 {
            if (boardGrid[i][0] == boardGrid[i][1] && boardGrid[i][0] == boardGrid[i][2] && boardGrid[i][0] != .empty) || (boardGrid[0][i] == boardGrid[1][i] && boardGrid[0][i] == boardGrid[2][i] && boardGrid[0][i] != .empty) {
                gameOver = true
                return "win"
            }
        }
        // checks diagonals
        if (boardGrid[0][0] == boardGrid[1][1] && boardGrid[0][0] == boardGrid[2][2] && boardGrid[0][0] != .empty) || (boardGrid[0][2] == boardGrid[1][1] && boardGrid[0][2] == boardGrid[2][0] && boardGrid[0][2] != .empty) {
            gameOver = true
            return "win"
        }
        
        // if the entire array is filled, it's a tie
        if !boardGrid[0].contains(.empty) && !boardGrid[1].contains(.empty) && !boardGrid[2].contains(.empty) {
            return "tie"
        }
        
        return "false"
    }
    
    // computer picks a tile at random
    func computerTurn() -> Int {
        let random = Int.random(in: 0..<availableTileIDs.count)
        let chosenTile = availableTileIDs[random]
        
        placeAt(viewID: chosenTile)
        
        return chosenTile
    }

    
}

enum TileStatus: String {
    case empty
    case X
    case O
}

enum GameType: String {
    case singlePlayer
    case multiPlayer
}
