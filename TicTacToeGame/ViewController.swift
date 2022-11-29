//
//  ViewController.swift
//  TicTacToeGame
//
//  Created by Arvid Rydh on 2022-11-29.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var activePlayerLabel: UILabel!
    
    let gameStateHandler = GameStateHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setActivePlayerLabel()
    }


    @IBAction func tileTapped(_ sender: UITapGestureRecognizer) {
                
        if let imageView = sender.view as? UIImageView {
            
            if imageView.image == nil {
                let activePlayer = gameStateHandler.activePlayer
                
                let image = UIImage(named: activePlayer)
                
                imageView.image = image
                
                
                gameStateHandler.endTurn()
                setActivePlayerLabel()
            }
        }
    }
    
    func setActivePlayerLabel() {
        activePlayerLabel.text = "Player \(gameStateHandler.activePlayer)"
    }
}

