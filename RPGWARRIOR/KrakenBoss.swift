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
    var attackSpeed = 1
    var life: CGFloat = 1
    
    class func makeKraken(position: CGPoint) -> KrakenBoss{
        let kraken = KrakenBoss(imageNamed: "Kraken_Boss_1")
        kraken.position = position
        kraken.zPosition = 2
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
        textures.append(SKTexture(imageNamed: "Kraken_Boss_2"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_1"))
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
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryWizard.rawValue
        self.physicsBody?.collisionBitMask = 0 //CollisionBitMasks.collisionCategoryHero.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
    func setupWavePhysicsBody(node: SKSpriteNode) {
        node.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width * 0.96, self.frame.height * 0.8))
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategorySpike.rawValue
        node.physicsBody?.collisionBitMask = 0
        node.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
    func createSafeAndWave() {
        let safeSpotNode = SKSpriteNode(imageNamed: "Safety_Pillar_1")
        safeSpotNode.name = "safeSpot1"
        safeSpotNode.zPosition = 2
        let position = getSafePosition()
        safeSpotNode.position = position
        safeSpotNode.size = CGSizeMake(50, 50)
        let rotateAction = SKAction.rotateByAngle(2 * pi, duration: 2)
        let repeatRotate = SKAction.repeatActionForever(rotateAction)
        let waitAction = SKAction.waitForDuration(6)
        let sandNode = SKSpriteNode(imageNamed: "Safety_Pillar_3")
        sandNode.position = position
        sandNode.name = "safeSpot2"
        sandNode.size = CGSizeMake(48, 48)
        let removeBlock = SKAction.runBlock({safeSpotNode.removeFromParent()
            sandNode.removeFromParent()})
        self.parent?.addChild(safeSpotNode)
        self.parent?.addChild(sandNode)
        safeSpotNode.runAction(SKAction.sequence([repeatRotate, waitAction, removeBlock]))
        sandNode.zPosition = 2
        
        
        
        let oilWave = SKSpriteNode(imageNamed: "Ink_Flood_1")
        oilWave.name = "wave"
        setupWavePhysicsBody(oilWave)
        let textures = [SKTexture(imageNamed: "Ink_Flood_2"),SKTexture(imageNamed: "Ink_Flood_3"), SKTexture(imageNamed: "Ink_Flood_1")]
        let animateWave = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatActionForever(animateWave)
        oilWave.runAction(repeatAction)
        oilWave.size = self.parent!.frame.size
        oilWave.anchorPoint = CGPointMake(0.5, 0)
        oilWave.zPosition = 1
        oilWave.position = CGPointMake(self.parent!.frame.midX, self.parent!.frame.maxY + 30)
        let moveDownAction = SKAction.moveTo(CGPointMake(self.parent!.frame.midX, self.parent!.frame.minY), duration: 2)
        let moveUpAction = SKAction.fadeOutWithDuration(2)
        let remBlock = SKAction.runBlock({oilWave.removeFromParent()})
        let waitToWave = SKAction.waitForDuration(5)
        let sequence = SKAction.sequence([waitToWave, moveDownAction, moveUpAction, remBlock])
        oilWave.runAction(sequence)
        self.parent?.addChild(oilWave)
    }
    
    func getSafePosition() -> CGPoint {
        let xPos = randomWithMin(25, Int(self.parent!.frame.width) - 25)
        let yPos = randomWithMin(100, Int(self.parent!.frame.height) - 140)
        return CGPointMake(CGFloat(xPos), CGFloat(yPos))
    }
    
    //throw a wave with gap at this position
    func throwTentacle(){
        //run tail animation
        var textures: [SKTexture] = []
        textures.append(SKTexture(imageNamed: "Kraken_Boss_2"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_3"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_4"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_5"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_6"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_7"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_8"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_9"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_10"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_11"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_12"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_13"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_12"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_11"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_10"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_9"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_8"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_7"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_6"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_5"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_4"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_3"))
        textures.append(SKTexture(imageNamed: "Kraken_Boss_2"))
        
        let waveAttackAnimation = SKAction.animateWithTextures(textures, timePerFrame: 0.05)
        var textures2: [SKTexture] = []
        textures2.append(SKTexture(imageNamed: "Kraken_Boss_1"))
        textures2.append(SKTexture(imageNamed: "Kraken_Boss_2"))
        textures2.append(SKTexture(imageNamed: "Kraken_Boss_3"))
        textures2.append(SKTexture(imageNamed: "Kraken_Boss_2"))
        let idleAnimation = SKAction.animateWithTextures(textures2, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatAction(idleAnimation, count: 1)
        let waitAction = SKAction.waitForDuration(2)
        let sequence = SKAction.sequence([repeatAction, waitAction])
        let realRepeatAction = SKAction.repeatActionForever(sequence)
        let finalSequence = SKAction.sequence([waveAttackAnimation, realRepeatAction])
        self.runAction(finalSequence)
        
        //create tentacle
        self.parent!.addChild(Tentacle.tentacleAtPosition(getTentaclePoint()))
        self.parent!.addChild(Tentacle.tentacleAtPosition(getTentaclePoint()))
    }
    
    func getTentaclePoint() -> CGPoint {
        let heroPosition = self.parent!.childNodeWithName("hero")!.position
        let xPos = CGFloat(heroPosition.x)
        let yPos = CGFloat(heroPosition.y)
        var realX = CGFloat(randomWithMin(Int(xPos - 150), Int(xPos + 150)))
        var realY = CGFloat(randomWithMin(Int(yPos - 150), Int(yPos + 150)))
        let distanceFromHero = CGFloat(30)
        if abs(xPos - realX) < 50 && abs(yPos - realY) < 50 {
            if ((xPos - realX) < distanceFromHero && (xPos - realX) > 0){
                realX = distanceFromHero
            }else if ((xPos - realX) > -distanceFromHero && (xPos - realX) < 0){
                realX = -distanceFromHero
            }
            if ((yPos - realY) < distanceFromHero && (yPos - realY) > 0){
                realY = distanceFromHero
            }else if((yPos - realY) > -distanceFromHero && (yPos - realY) < 0){
                realY = -distanceFromHero
            }
        }
        return CGPointMake(realX, realY)
    }
    
    func shootKrill(){
        if self.isDead{
            return
        }
        //display shooting animation
        //go back to rocking
        //self.runAction(repeatAction0, withKey: "repeatAction")
        let codeBlock0 = SKAction.runBlock({
            var textures: [SKTexture] = []
            textures.append(SKTexture(imageNamed:"Whale_Boss_1"))
            
            let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
            let repeatAction0 = SKAction.repeatActionForever(animation)
            self.runAction(repeatAction0, withKey: "repeatAction")
        })
        let codeBlock = SKAction.runBlock({
            var textures: [SKTexture] = []
            for var i = 1; i <= 3; i=i+1{
                textures.append(SKTexture(imageNamed:"Whale_Boss_\(i)"))
            }
            textures.append(SKTexture(imageNamed:"Whale_Boss_5"))
            textures.append(SKTexture(imageNamed:"Whale_Boss_4"))
            textures.append(SKTexture(imageNamed:"Whale_Boss_6"))
            textures.append(SKTexture(imageNamed:"Whale_Boss_4"))
            textures.append(SKTexture(imageNamed:"Whale_Boss_5"))
            textures.append(SKTexture(imageNamed:"Whale_Boss_7"))
            textures.append(SKTexture(imageNamed:"Whale_Boss_8"))
            textures.append(SKTexture(imageNamed:"Whale_Boss_9"))
            textures.append(SKTexture(imageNamed:"Whale_Boss_8"))
            textures.append(SKTexture(imageNamed:"Whale_Boss_7"))
            
            
            let animation2 = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
            let sequenceRepeat = SKAction.sequence([animation2, SKAction.waitForDuration(1.5)])
            let repeatAction = SKAction.repeatActionForever(sequenceRepeat)
            self.runAction(repeatAction , withKey: "repeatAction")
        })
        let sequence = SKAction.sequence([codeBlock0, SKAction.waitForDuration(0.4), codeBlock])
        self.runAction(sequence)
        //calculate where to shoot the krill
        let hero = self.parent!.childNodeWithName("hero") as! HeroClass
        let shootAtPoint = hero.position
        //shoot the krill
        let krill = Krill.krillAtPosition(CGPointMake(self.position.x, self.position.y - 45))
        self.parent!.addChild(krill)
        krill.moveTowardsPosition()
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
