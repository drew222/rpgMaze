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
        tentacle.anchorPoint = CGPointMake(0.5, 0)
        tentacle.position = position
        tentacle.name = "tentacle"
        tentacle.size = CGSizeMake(50, 20)
        //animate all textures
        var textures: [SKTexture] = []
        let sizeAction1 = SKAction.runBlock({tentacle.runAction(SKAction.scaleXBy(1, y: 5, duration: 0.5))})
        var textures2: [SKTexture] = []
        let sizeAction2 = SKAction.runBlock({tentacle.runAction(SKAction.scaleXBy(2.5, y: 0.7, duration: 0.5))})
        var textures3: [SKTexture] = []
        let sizeAction3 = SKAction.runBlock({tentacle.runAction(SKAction.scaleXBy(0.4, y: 1.2, duration: 0.5))})
        var textures4: [SKTexture] = []
        let sizeAction4 = SKAction.runBlock({tentacle.runAction(SKAction.scaleXBy(2.5, y: 0.7, duration: 0.5))})
        var textures5: [SKTexture] = []
        let sizeAction5 = SKAction.runBlock({tentacle.runAction(SKAction.scaleXBy(0.4, y: 1.2, duration: 0.5))})
        var textures6: [SKTexture] = []
        let sizeAction6 = SKAction.runBlock({tentacle.runAction(SKAction.scaleXBy(0.2, y: 0.2, duration: 0.5))})
        var textures7: [SKTexture] = []
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
        textures5.append(SKTexture(imageNamed: "Tentacle_18"))
        textures5.append(SKTexture(imageNamed: "Tentacle_17"))
        textures5.append(SKTexture(imageNamed: "Tentacle_16"))
        textures5.append(SKTexture(imageNamed: "Tentacle_15"))
        textures5.append(SKTexture(imageNamed: "Tentacle_14"))
        textures5.append(SKTexture(imageNamed: "Tentacle_35"))
        textures6.append(SKTexture(imageNamed: "Tentacle_24"))
        textures6.append(SKTexture(imageNamed: "Tentacle_25"))
        textures6.append(SKTexture(imageNamed: "Tentacle_26"))
        textures6.append(SKTexture(imageNamed: "Tentacle_27"))
        textures6.append(SKTexture(imageNamed: "Tentacle_28"))
        textures7.append(SKTexture(imageNamed: "Tentacle_30"))
        textures7.append(SKTexture(imageNamed: "Tentacle_31"))
        textures7.append(SKTexture(imageNamed: "Tentacle_32"))
        textures7.append(SKTexture(imageNamed: "Tentacle_33"))
        
        
        let animateAction = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let animateAction2 = SKAction.animateWithTextures(textures2, timePerFrame: 0.1)
        let animateAction3 = SKAction.animateWithTextures(textures3, timePerFrame: 0.1)
        let animateAction4 = SKAction.animateWithTextures(textures4, timePerFrame: 0.1)
        let animateAction5 = SKAction.animateWithTextures(textures5, timePerFrame: 0.1)
        let animateAction6 = SKAction.animateWithTextures(textures6, timePerFrame: 0.1)
        let animateAction7 = SKAction.animateWithTextures(textures7, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatAction(animateAction, count: 1)
        let codeBlock = SKAction.runBlock({tentacle.removeFromParent()})
        let sequence = SKAction.sequence([repeatAction, sizeAction1, animateAction2, sizeAction2, animateAction3, sizeAction3, animateAction4, sizeAction4, animateAction5, sizeAction5, animateAction6, sizeAction6, animateAction7, codeBlock])
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
