//
//  TreasureChest.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/5/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit

class TreasureChest: SKSpriteNode {
    var currentAngle: CGFloat?
    var life: CGFloat = 1
    var isDead = false
    
    class func chestAtPosition(position: CGPoint) ->TreasureChest {
        let chest = TreasureChest(imageNamed:"Treasure_Chest_1.png")
        chest.position = position
        chest.name = "chest"
        chest.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        chest.setScale(0.1)
        chest.setupPhysicsBody()
        chest.currentAngle = 3 * pi / 2.0
        return chest
        
    }
    
    class func openChest(position: CGPoint) ->TreasureChest {
        let aChest = TreasureChest(imageNamed:"Treasure_Chest_6.png")
        aChest.position = position
        aChest.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        aChest.setScale(0.1)
        
        let textures = [SKTexture (imageNamed: "Treasure_Chest_2.png"), SKTexture (imageNamed: "Treasure_Chest_3.png"), SKTexture (imageNamed: "Treasure_Chest_4.png"), SKTexture (imageNamed: "Treasure_Chest_5.png") ]
        let chestAnimation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        aChest.runAction(chestAnimation)
        aChest.setupPhysicsBody()
        
        return aChest
        
    }

    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.dynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryChest.rawValue
        self.physicsBody?.collisionBitMask = 0 //CollisionBitMasks.collisionCategoryHero.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    func takeDamage(howMuch: CGFloat){
        self.life -= howMuch
        if (self.life <= 0){
            self.isDead = true
            self.removeAllActions()
            self.texture = nil
        }
        
    }
}