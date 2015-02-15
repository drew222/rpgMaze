//
//  BlizzNode.swift
//  RPGWARRIOR
//
//  Created by Tyler Mullins on 2/15/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit

class BlizzNode: SKEmitterNode {
    
    class func blizzAtPos(position: CGPoint) -> SKEmitterNode {
        let blizzPath = NSBundle.mainBundle().pathForResource("BlizzParticle", ofType: "sks")
        let blizz = NSKeyedUnarchiver.unarchiveObjectWithFile(blizzPath!) as SKEmitterNode
        blizz.position = position
        blizz.zPosition = 10
        blizz.name = "Blizzard"
        return blizz
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryBomb.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
}
