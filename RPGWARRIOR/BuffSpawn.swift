//
//  BuffSpawn.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 5/29/15.
//  Copyright (c) 2015 Drew and Zach. All rights reserved.
//

import Foundation
import SpriteKit

class BuffSpawn: SKSpriteNode {
    var buffType: Int?
    
    class func buffAtPos(position: CGPoint, type: Int) -> BuffSpawn{
        var buffer: BuffSpawn?
        if type == 1{
            buffer = BuffSpawn(imageNamed: "Life_Symbol_1")
        }else if type == 2{
            buffer = BuffSpawn(imageNamed: "Speed_Symbol_1")
        }else{
            buffer = BuffSpawn(imageNamed: "World_1_Gauntlet_Level_Text_1")
        }
        buffer!.buffType = type
        buffer!.position = position
        buffer!.name = "buff"
        buffer!.size = CGSizeMake(30, 30)
        buffer!.setupPhysicsBody()
        return buffer!
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width * 0.90, self.frame.height * 0.90))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryBuff.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }

}
