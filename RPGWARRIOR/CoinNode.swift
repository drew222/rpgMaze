//
//  CoinNode.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 6/10/15.
//  Copyright (c) 2015 Drew and Zach. All rights reserved.
//

import Foundation
import SpriteKit

class CoinNode: SKSpriteNode {
    
    class func coinAtPos(position: CGPoint) -> CoinNode{
        var coin = CoinNode(imageNamed: "Booty_1")
        coin.position = position
        coin.name = "coin"
        coin.size = CGSizeMake(30, 30)
        coin.setupPhysicsBody()
        return coin
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width * 0.90, self.frame.height * 0.90))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryCoin.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
}
