//
//  MenuViewController.swift
//  TicTacToeGame
//
//  Created by Arvid Rydh on 2022-12-06.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    @IBOutlet weak var gameTypeLabel: UITextField!
    
    
    @IBOutlet weak var player1NameTextField: UITextField!
    
    
    @IBOutlet weak var player2NameTextField: UITextField!
    
    
    @IBOutlet weak var gameTypeSwitch: UISwitch!
    
    let startGameSegueID = "startGameSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func toggleGameType(_ sender: UISwitch) {
        
        if sender.isOn {
            gameTypeLabel.text = "Single Player"
            player2NameTextField.isHidden = true
        }
        else {
            gameTypeLabel.text = "Multi Player"
            player2NameTextField.isHidden = false
            
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        var gameType: GameType
        var player1Name = player1NameTextField.text ?? "Player 1"
        var player2Name = player2NameTextField.text ?? "Player 2"
        
        
        if gameTypeSwitch.isOn {
            gameType = .singlePlayer
            player2Name = "Computer"
        }
        else {
            gameType = .multiPlayer
            
        }
        
        if player1Name.isEmpty {
            player1Name = "Player 1"
        }
        if player2Name.isEmpty {
            player2Name = "Player 2"
        }
        
        
        if segue.identifier == startGameSegueID {
            let destinationVC = segue.destination as? GameViewController
            destinationVC?.gameStateHandler = GameStateHandler(sentGameType: gameType, player1Name: player1Name , player2Name: player2Name)
        }
        
    }
    
    

    
}
