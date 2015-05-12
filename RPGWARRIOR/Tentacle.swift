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
        tentacle.size = CGSizeMake(60, 30)
        //animate all textures
        var textures: [SKTexture] = []
        let sizeAction1 = SKAction.runBlock({tentacle.size = CGSizeMake(60, 90)})
        var textures2: [SKTexture] = []
        let sizeAction2 = SKAction.runBlock({
            tentacle.position = CGPointMake(tentacle.position.x - 15, tentacle.position.y)
            tentacle.size = CGSizeMake(90, 60)})
        var textures3: [SKTexture] = []
        let sizeAction3 = SKAction.runBlock({
            tentacle.position = CGPointMake(tentacle.position.x + 30, tentacle.position.y)
            tentacle.size = CGSizeMake(90, 60)
            tentacle.position = CGPointMake(tentacle.position.x - 15, tentacle.position.y)})
        var textures4: [SKTexture] = []
        let sizeAction4 = SKAction.runBlock({tentacle.size = CGSizeMake(60, 90)})
        var textures5: [SKTexture] = []
        textures.append(SKTexture(imageNamed: "Cracked_Ground_1"))
        textures.append(SKTexture(imageNamed: "Cracked_Ground_2"))
        for (var i = 33; i > 29; i-=1){
            textures2.append(SKTexture(imageNamed: "Tentacle_\(i)"))
        }
        for (var i = 28; i > 23; i-=1){
            textures2.append(SKTexture(imageNamed: "Tentacle_\(i)"))
        }
        textures3.append(SKTexture(imageNamed: "Tentacle_34"))
        textures3.append(SKTexture(imageNamed: "Tentacle_19"))
        for (var i = 20; i < 24; i+=1){
            textures3.append(SKTexture(imageNamed: "Tentacle_\(i)"))
        }
        for (var i = 22; i > 18; i-=1){
            textures3.append(SKTexture(imageNamed: "Tentacle_\(i)"))
        }
        textures3.append(SKTexture(imageNamed: "Tentacle_19"))
        textures3.append(SKTexture(imageNamed: "Tentacle_34"))
        textures4.append(SKTexture(imageNamed: "Tentacle_24"))
        textures4.append(SKTexture(imageNamed: "Tentacle_35"))
        textures4.append(SKTexture(imageNamed: "Tentacle_14"))
        textures4.append(SKTexture(imageNamed: "Tentacle_15"))
        textures4.append(SKTexture(imageNamed: "Tentacle_16"))
        textures4.append(SKTexture(imageNamed: "Tentacle_17"))
        textures4.append(SKTexture(imageNamed: "Tentacle_18"))
        textures4.append(SKTexture(imageNamed: "Tentacle_17"))
        textures4.append(SKTexture(imageNamed: "Tentacle_16"))
        textures4.append(SKTexture(imageNamed: "Tentacle_15"))
        textures4.append(SKTexture(imageNamed: "Tentacle_14"))
        textures4.append(SKTexture(imageNamed: "Tentacle_35"))
        textures5.append(SKTexture(imageNamed: "Tentacle_24"))
        textures5.append(SKTexture(imageNamed: "Tentacle_25"))
        textures5.append(SKTexture(imageNamed: "Tentacle_26"))
        textures5.append(SKTexture(imageNamed: "Tentacle_27"))
        textures5.append(SKTexture(imageNamed: "Tentacle_28"))
        textures5.append(SKTexture(imageNamed: "Tentacle_30"))
        textures5.append(SKTexture(imageNamed: "Tentacle_31"))
        textures5.append(SKTexture(imageNamed: "Tentacle_32"))
        textures5.append(SKTexture(imageNamed: "Tentacle_33"))
        
        
        let animateAction = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let animateAction2 = SKAction.animateWithTextures(textures2, timePerFrame: 0.1)
        let animateAction3 = SKAction.animateWithTextures(textures3, timePerFrame: 0.1)
        let animateAction4 = SKAction.animateWithTextures(textures4, timePerFrame: 0.1)
        let animateAction5 = SKAction.animateWithTextures(textures5, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatAction(animateAction, count: 1)
        let codeBlock = SKAction.runBlock({tentacle.removeFromParent()})
        let sequence = SKAction.sequence([repeatAction, sizeAction1, animateAction2, sizeAction2, animateAction3, sizeAction3, animateAction4, sizeAction4, animateAction5, codeBlock])
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
