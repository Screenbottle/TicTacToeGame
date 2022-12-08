//
//  ViewController.swift
//  TicTacToeGame
//
//  Created by Arvid Rydh on 2022-11-29.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    @IBOutlet weak var player1WinsLabel: UILabel!
    
    
    @IBOutlet weak var player2WinsLabel: UILabel!
    
    
    @IBOutlet var resetTapRecognizer: UITapGestureRecognizer!
    
    
    @IBOutlet weak var board: UIView!
    
    
    @IBOutlet weak var activePlayerLabel: UILabel!
    
    var gameStateHandler = GameStateHandler()
    
    let soundName = "chessSFX"
    let soundExtension = "wav"
    var soundURL: URL?
    var SFXPlayer: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setActivePlayerLabel()
        updateWinLabels()
        
        // sets up a sound player object
        if let soundPath = Bundle.main.path(forResource: soundName, ofType: soundExtension) {
            soundURL = URL(fileURLWithPath: soundPath)
            if let soundURL = soundURL {
                SFXPlayer = AVPlayer(url: soundURL)
            }
        }
    }


    @IBAction func tileTapped(_ sender: UITapGestureRecognizer) {
        if gameStateHandler.gameOver {
            startNewGame()
        }
        else {
            // gets the view from the sender and casts it as an imageview
            if let imageView = sender.view as? UIImageView {
                
                // only places an image in an imageview if it is empty
                if imageView.image == nil {
                    
                    // gets the image for the current player and puts it in the view
                    let activePlayer = gameStateHandler.turnKeeper.rawValue
                    let activePlayerName = gameStateHandler.activePlayer.name
                    let image = UIImage(named: activePlayer)
                    
                    playSound()
                    
                    imageView.image = image
                    
                    // takes advantage of the tags given to the image views, they are ints from 0 to 8
                    gameStateHandler.placeAt(viewID: imageView.tag)
                    
                    endTurn(activePlayerName: activePlayerName) {
                        
                        gameStateHandler.endTurn()
                        setActivePlayerLabel()
                        
                        // the computer takes it's turn if playing solo
                        if gameStateHandler.gameType == .singlePlayer {
                            computerTurn()
                        }
                    }
                }
            }
        }
    }
    
    func playSound() {
        // thank you openAI
        
        if let soundURL = soundURL {
            SFXPlayer?.replaceCurrentItem(with: AVPlayerItem(url: soundURL))
            SFXPlayer?.play()
        }
    }
    
    func computerTurn() {
        // chooses a tile and marks it
        let chosenTile = gameStateHandler.computerTurn()
        
        for tile in board.subviews {
            if tile.tag == chosenTile {
                if let imageView = tile as? UIImageView {
                    
                    let activePlayer = gameStateHandler.turnKeeper.rawValue
                    let activePlayerName = gameStateHandler.activePlayer.name
                    let image = UIImage(named: activePlayer)
                    
                    //playSound()
                    imageView.image = image
                    
                    endTurn(activePlayerName: activePlayerName) {
                        gameStateHandler.endTurn()
                        setActivePlayerLabel()
                    }
                }
            }
        }
    }
    
    // checks if a player has won, if it's a tie, or if the game continues
    func endTurn(activePlayerName: String, changeTurn: () -> Void) {
        let winCheck = gameStateHandler.checkForWin()
        
        if winCheck == .win {
            setGameOverLabel(result: "\(activePlayerName) wins!")
            resetTapRecognizer.isEnabled = true
            gameStateHandler.activePlayer.playerWins()
            updateWinLabels()
        }
        else if winCheck == .tie {
            setGameOverLabel(result: "It's a tie!")
            resetTapRecognizer.isEnabled = true
        }
        else {
            changeTurn()
        }
    }
    
    // when the game is over, tapping anywhere starts a new round
    @IBAction func resetBoard(_ sender: UITapGestureRecognizer) {
        startNewGame()
    }
    
    // clear the board when a new game begins
    func startNewGame() {
        gameStateHandler.newGame()
        setActivePlayerLabel()
        
        for tile in board.subviews {
            if let imageView = tile as? UIImageView {
                imageView.image = nil
            }
        }
        
        resetTapRecognizer.isEnabled = false
    }
    
    // keeps track of how many times each player has won
    func updateWinLabels() {
        
        let player1 = gameStateHandler.player1
        let player2 = gameStateHandler.player2
        player1WinsLabel.text = "\(player1.name) has won \(player1.wins) times"
        
        player2WinsLabel.text = "\(player2.name) has won \(player2.wins) times"
    }
    
    func setGameOverLabel(result: String) {
        // displays the result when the game is over
        activePlayerLabel.text = result
    }
    
    
    func setActivePlayerLabel() {
        // changes the label to match the player who's turn it is
        activePlayerLabel.text = gameStateHandler.activePlayer.name
    }
}

