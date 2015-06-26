//
//  BlizzNode.swift
//  RPGWARRIOR
//
//  Created by Tyler Mullins on 2/15/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit

class BlizzNode: SKSpriteNode{
    
    var blizzAttack: SKEmitterNode?
    
    class func createBlizz(position: CGPoint) -> BlizzNode {
        

        let blizzContactNode = BlizzNode(color: SKColor.blackColor(), size: CGSizeMake(130, 130))
        blizzContactNode.zPosition = -2.0
        blizzContactNode.position = position
        blizzContactNode.name = "blizz"
        
        let blizzPath = NSBundle.mainBundle().pathForResource("BlizzParticle", ofType: "sks")
        blizzContactNode.blizzAttack = (NSKeyedUnarchiver.unarchiveObjectWithFile(blizzPath!) as! SKEmitterNode)
        blizzContactNode.blizzAttack!.position = CGPointMake(position.x + 15, position.y + 60)
        //blizzContactNode.blizzAttack!.zPosition = 2
        
        //blizzContactNode.setupPhysicsBody()
        
        return blizzContactNode
        
    }

    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width * 0.9, self.frame.height * 0.8))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryBlizzard.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
}
