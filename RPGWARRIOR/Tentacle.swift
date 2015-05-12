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
    
    //create wave at point with size
    class func tentacleAtPosition(position: CGPoint) -> Tentacle{
        let tentacle = Tentacle(imageNamed: "Tentacle_1")
        tentacle.position = position
        tentacle.name = "tentacle"
        tentacle.size = CGSizeMake(50, 50)
        //animate all textures
        var textures: [SKTexture] = []
        textures.append(SKTexture(imageNamed: "Cracked_Ground_1"))
        textures.append(SKTexture(imageNamed: "Cracked_Ground_2"))
        for (var i = 33; i > 29; i-=1){
            textures.append(SKTexture(imageNamed: "Tentacle_\(i)"))
        }
        for (var i = 28; i > 23; i-=1){
            textures.append(SKTexture(imageNamed: "Tentacle_\(i)"))
        }
        textures.append(SKTexture(imageNamed: "Tentacle_34"))
        textures.append(SKTexture(imageNamed: "Tentacle_19"))
        for (var i = 20; i < 24; i+=1){
            textures.append(SKTexture(imageNamed: "Tentacle_\(i)"))
        }
        for (var i = 22; i > 18; i-=1){
            textures.append(SKTexture(imageNamed: "Tentacle_\(i)"))
        }
        textures.append(SKTexture(imageNamed: "Tentacle_19"))
        textures.append(SKTexture(imageNamed: "Tentacle_34"))
        textures.append(SKTexture(imageNamed: "Tentacle_24"))
        textures.append(SKTexture(imageNamed: "Tentacle_35"))
        textures.append(SKTexture(imageNamed: "Tentacle_14"))
        textures.append(SKTexture(imageNamed: "Tentacle_15"))
        textures.append(SKTexture(imageNamed: "Tentacle_16"))
        textures.append(SKTexture(imageNamed: "Tentacle_17"))
        textures.append(SKTexture(imageNamed: "Tentacle_18"))
        textures.append(SKTexture(imageNamed: "Tentacle_17"))
        textures.append(SKTexture(imageNamed: "Tentacle_16"))
        textures.append(SKTexture(imageNamed: "Tentacle_15"))
        textures.append(SKTexture(imageNamed: "Tentacle_14"))
        textures.append(SKTexture(imageNamed: "Tentacle_35"))
        textures.append(SKTexture(imageNamed: "Tentacle_24"))
        textures.append(SKTexture(imageNamed: "Tentacle_25"))
        textures.append(SKTexture(imageNamed: "Tentacle_26"))
        textures.append(SKTexture(imageNamed: "Tentacle_27"))
        textures.append(SKTexture(imageNamed: "Tentacle_28"))
        textures.append(SKTexture(imageNamed: "Tentacle_30"))
        textures.append(SKTexture(imageNamed: "Tentacle_31"))
        textures.append(SKTexture(imageNamed: "Tentacle_32"))
        textures.append(SKTexture(imageNamed: "Tentacle_33"))
        textures.append(SKTexture(imageNamed: "Cracked_Ground_2"))
        textures.append(SKTexture(imageNamed: "Cracked_Ground_1"))
        
        
        let animateAction = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatActionForever(animateAction)
        let codeBlock = SKAction.runBlock({tentacle.removeFromParent()})
        let sequence = SKAction.sequence([repeatAction, codeBlock])
        tentacle.setupPhysicsBody()
        tentacle.runAction(sequence)
        return tentacle
        
    }
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width * 0.90, self.frame.height * 0.90))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryWave.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
}
