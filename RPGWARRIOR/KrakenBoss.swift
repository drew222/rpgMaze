//
//  KrakenBoss.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/6/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit


class KrakenBoss: SKSpriteNode {
    //var currentAngle: CGFloat?
    var isDead = false
    var attackSpeed = 3
    var life: CGFloat = 1
    
    class func makeKraken(position: CGPoint) -> KrakenBoss{
        let kraken = KrakenBoss(imageNamed: "Kraken_Boss_1")
        kraken.position = position
        kraken.anchorPoint = CGPointMake(0.5, 0.5)
        kraken.name = "kraken"
        kraken.setScale(0.15)
        //whale.currentAngle = 3 * pi / 2.0
        var textures: [SKTexture] = []
        //for var i = 1; i <= 24; i=i+1{
        //    textures.append(SKTexture(imageNamed:"wizard\(i)"))
        //}
        textures.append(SKTexture(imageNamed: "Kraken_Boss_2"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_3"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_4"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_5"))
        let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        //let repeatAction = SKAction.repeatActionForever(animation)
        let repeatAction = SKAction.repeatAction(animation, count: 1)
        let waitAction = SKAction.waitForDuration(2)
        let sequence = SKAction.sequence([repeatAction, waitAction])
        let realRepeatAction = SKAction.repeatActionForever(sequence)
        kraken.runAction(realRepeatAction)
        kraken.setupPhysicsBody()
        return kraken
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.dynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryKraken.rawValue
        self.physicsBody?.collisionBitMask = 0 //CollisionBitMasks.collisionCategoryHero.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
    //throw a wave with gap at this position
    func throwWave(gapPosition: CGPoint){
        //run tail animation
        var textures: [SKTexture] = []
        textures.append(SKTexture(imageNamed: "Whale_Boss_10"))
        textures.append(SKTexture(imageNamed: "Whale_Boss_11"))
        textures.append(SKTexture(imageNamed: "Whale_Boss_12"))
        textures.append(SKTexture(imageNamed: "Whale_Boss_13"))
        textures.append(SKTexture(imageNamed: "Whale_Boss_14"))
        textures.append(SKTexture(imageNamed: "Whale_Boss_15"))
        textures.append(SKTexture(imageNamed: "Whale_Boss_16"))
        textures.append(SKTexture(imageNamed: "Whale_Boss_15"))
        textures.append(SKTexture(imageNamed: "Whale_Boss_14"))
        textures.append(SKTexture(imageNamed: "Whale_Boss_13"))
        textures.append(SKTexture(imageNamed: "Whale_Boss_12"))
        textures.append(SKTexture(imageNamed: "Whale_Boss_11"))
        textures.append(SKTexture(imageNamed: "Whale_Boss_10"))
        let waveAttackAnimation = SKAction.animateWithTextures(textures, timePerFrame: 0.05)
        var textures2: [SKTexture] = []
        textures2.append(SKTexture(imageNamed: "Whale_Boss_1"))
        textures2.append(SKTexture(imageNamed: "Whale_Boss_2"))
        textures2.append(SKTexture(imageNamed: "Whale_Boss_3"))
        textures2.append(SKTexture(imageNamed: "Whale_Boss_2"))
        let idleAnimation = SKAction.animateWithTextures(textures2, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatAction(idleAnimation, count: 1)
        let waitAction = SKAction.waitForDuration(2)
        let sequence = SKAction.sequence([repeatAction, waitAction])
        let realRepeatAction = SKAction.repeatActionForever(sequence)
        let finalSequence = SKAction.sequence([waveAttackAnimation, realRepeatAction])
        self.runAction(finalSequence)
        var lengthOfTop = self.parent!.frame.maxY - gapPosition.y + 25
        var lengthOfBot = gapPosition.y - 25
        self.parent!.addChild(WaveNode.waveAtPosition(CGPointMake(gapPosition.x, gapPosition.y + (lengthOfTop)/2), length: lengthOfTop, distance: self.parent!.frame.maxX + 50))
        self.parent!.addChild(WaveNode.waveAtPosition(CGPointMake(gapPosition.x, lengthOfBot/2), length: lengthOfBot, distance: self.parent!.frame.maxX + 50))
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
