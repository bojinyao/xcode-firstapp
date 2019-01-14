//
//  Card.swift
//  firstapp
//
//  Created by Bojin Yao on 1/10/19.
//  Copyright © 2019 Bojin Yao. All rights reserved.
//

import Foundation

struct Card : Hashable
{
    var hashValue: Int {
        return identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return Card.identifierFactory
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
