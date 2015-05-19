//
//  Tentacle.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 5/12/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit


class Tentacle: SKSpriteNode {
    
    //var isArmed = false
    
    //create wave at point with size
    class func tentacleAtPosition(position: CGPoint) -> Tentacle{
        let tentacle = Tentacle(imageNamed: "Tentacle_1")
        //tentacle.anchorPoint = CGPointMake(0.5, 0)
        tentacle.position = position
        tentacle.name = "tentacle"
        tentacle.size = CGSizeMake(80, 80)
        //animate all textures
        var textures: [SKTexture] = []
        for (var i = 1; i < 8; i+=1){
            textures.append(SKTexture(imageNamed: "Tentacle_Swing_\(i)"))
        }
        
        let animateAction = SKAction.animateWithTextures(textures, timePerFrame: 0.3)
        let repeatAction = SKAction.repeatAction(animateAction, count: 1)
        let codeBlock0 = SKAction.runBlock({//tentacle.isArmed = true
        tentacle.setupPhysicsBody()})
        let rotateAction = SKAction.rotateByAngle(2 * pi, duration: 0.3)
        let repRotateAction = SKAction.repeatAction(rotateAction, count: 200)
        let codeBlock = SKAction.runBlock({tentacle.removeFromParent()})
        let sequence = SKAction.sequence([repeatAction, codeBlock0, repRotateAction, codeBlock])
        //tentacle.setupPhysicsBody()
        tentacle.runAction(sequence)
        return tentacle
        
    }
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width * 0.80, self.frame.height * 0.80))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryWave.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
}
