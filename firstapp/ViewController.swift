//
//  ViewController.swift
//  firstapp
//
//  Created by Bojin Yao on 12/22/18.
//  Copyright © 2018 Bojin Yao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count+1)/2
        }
        // or just return (cardButtons.count+1)/2
    }
    
    private(set) var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        
        if let cardNumber = cardButtons.index(of: sender) {
//            print("cardID = \(game.cards[cardNumber].identifier)")
//            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            if !game.cards[cardNumber].isMatched {
                flipCount += 1
            }
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card not in cardButtons")
        }
        
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    @IBAction private func restartButton(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2 )
        updateViewFromModel()
        emojiChoices = ViewController.allEmojis
        emoji = [Card:String]()
        flipCount = 0
    }
    
    private static var allEmojis = ["👻", "🍭", "🎃", "😈", "💩", "😁"]
    private var emojiChoices = allEmojis
    
    private var emoji = [Card:String]() // Dictionary<Card, String>() same
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil {
            if emojiChoices.count > 0 {
                emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            }
        }
        
        if emoji[card] != nil {
            return emoji[card]!
        }
        return "?"
        // or return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(-self)))
        } else {
            return 0
        }
    }
}
