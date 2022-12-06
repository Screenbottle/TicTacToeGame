//
//  ViewController.swift
//  TicTacToeGame
//
//  Created by Arvid Rydh on 2022-11-29.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var resetTapRecognizer: UITapGestureRecognizer!
    
    
    @IBOutlet weak var board: UIView!
    
    
    @IBOutlet weak var activePlayerLabel: UILabel!
    
    var gameStateHandler = GameStateHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setActivePlayerLabel()
    }


    @IBAction func tileTapped(_ sender: UITapGestureRecognizer) {
        if gameStateHandler.gameOver {
            return
        }
        else {
            // gets the view from the sender and casts it as an imageview
            if let imageView = sender.view as? UIImageView {
                
                // only places an image in an imageview if it is empty
                if imageView.image == nil {
                    
                    // gets the image for the current player and puts it in the view
                    let activePlayer = gameStateHandler.activePlayer.rawValue
                    let activePlayerName = gameStateHandler.activePlayerName
                    let image = UIImage(named: activePlayer)
                    
                    imageView.image = image
                    
                    gameStateHandler.placeAt(viewID: imageView.tag)
                    
                    endTurn(activePlayerName: activePlayerName) {
                        
                        gameStateHandler.endTurn()
                        setActivePlayerLabel()
                        
                        if gameStateHandler.gameType == .singlePlayer {
                            computerTurn()
                        }
                    }
                }
            }
        }
    }
    
    func computerTurn() {
        // chooses a tile and marks it
        let chosenTile = gameStateHandler.computerTurn()
        
        for tile in board.subviews {
            if tile.tag == chosenTile {
                if let imageView = tile as? UIImageView {
                    
                    let activePlayer = gameStateHandler.activePlayer.rawValue
                    let activePlayerName = gameStateHandler.activePlayerName
                    let image = UIImage(named: activePlayer)
                    
                    imageView.image = image
                    
                    endTurn(activePlayerName: activePlayerName) {
                        gameStateHandler.endTurn()
                        setActivePlayerLabel()
                    }
                }
            }
        }
    }
    
    func endTurn(activePlayerName: String, changeTurn: () -> Void) {
        let winCheck = gameStateHandler.checkForWin()
        
        if winCheck == "win" {
            setGameOverLabel(result: "\(activePlayerName) wins!")
            resetTapRecognizer.isEnabled = true
        }
        else if winCheck == "tie" {
            setGameOverLabel(result: "It's a tie!")
            resetTapRecognizer.isEnabled = true
        }
        else {
            changeTurn()
        }
    }
    
    
    @IBAction func resetBoard(_ sender: UITapGestureRecognizer) {
        gameStateHandler.newGame()
        setActivePlayerLabel()
        
        for tile in board.subviews {
            if let imageView = tile as? UIImageView {
                imageView.image = nil
            }
        }
        
        resetTapRecognizer.isEnabled = false
    }
    
    func setGameOverLabel(result: String) {
        // displays the result when the game is over
        activePlayerLabel.text = result
    }
    
    
    func setActivePlayerLabel() {
        // changes the label to match the player who's turn it is
        activePlayerLabel.text = gameStateHandler.activePlayerName
    }
}

