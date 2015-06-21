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
        kraken.setScale(0.12)
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
        node.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width * 2.96, self.frame.height * 0.6))
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryWave.rawValue
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
        let animateWave = SKAction.animateWithTextures(textures, timePerFrame: 0.3)
        let repeatAction = SKAction.repeatActionForever(animateWave)
        oilWave.runAction(repeatAction)
        //oilWave.size = self.parent!.frame.size
        oilWave.size = CGSizeMake(self.parent!.frame.maxX, self.parent!.frame.maxY + 70)
        oilWave.anchorPoint = CGPointMake(0.5, 0)
        oilWave.zPosition = 1
        oilWave.position = CGPointMake(self.parent!.frame.midX, self.parent!.frame.maxY + 30)
        let moveDownAction = SKAction.moveTo(CGPointMake(self.parent!.frame.midX, self.parent!.frame.minY - 70), duration: 2)
        let moveUpAction = SKAction.fadeOutWithDuration(1)
        let remBlock = SKAction.runBlock({oilWave.removeFromParent()})
        var waitToWave = SKAction.waitForDuration(1.75)
        if let aLevel = self.parent as? World1Level30 {
            waitToWave = SKAction.waitForDuration(3)
        }
        let sequence = SKAction.sequence([waitToWave, moveDownAction, moveUpAction, remBlock])
        oilWave.runAction(sequence)
        self.parent?.addChild(oilWave)
    }
    
    func getSafePosition() -> CGPoint {
        let xPos = randomWithMin(25, Int(self.parent!.frame.width) - 25)
        let yPos = randomWithMin(115, Int(self.parent!.frame.height) - 185)
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
        let tentacle = Tentacle.tentacleAtPosition(getTentaclePoint())
        tentacle.zPosition = 3
        self.parent!.addChild(tentacle)
        //self.parent!.addChild(Tentacle.tentacleAtPosition(getTentaclePoint()))
    }
    
    func getTentaclePoint() -> CGPoint {
        let heroPosition = self.parent!.childNodeWithName("hero")!.position
        
        return heroPosition
    }
    
    
    func takeDamage(howMuch: CGFloat){
        if soundOn {
            (self.parent as! SKScene).runAction(poofSound)
            let waitDuration = SKAction.waitForDuration(1)
            let runBlock = SKAction.runBlock({beachMusic.play()})
            let sequence = SKAction.sequence([waitDuration, runBlock])
            (self.parent as! SKScene).runAction(sequence)
        }
        self.life -= howMuch
        if (self.life <= 0) && !self.isDead{
            self.isDead = true
            self.removeAllActions()
            var inkAttack: SKEmitterNode?
            let explodeCode = SKAction.runBlock({let litePath = NSBundle.mainBundle().pathForResource("SmokeParticle", ofType: "sks")
                inkAttack = (NSKeyedUnarchiver.unarchiveObjectWithFile(litePath!) as! SKEmitterNode)
                inkAttack!.position = CGPointMake(self.position.x, self.position.y - 10)
                inkAttack!.zPosition = 4
                inkAttack!.name = "inkAttack"
                inkAttack!.setScale(1.2)
                self.parent!.addChild(inkAttack!)
            })
            let waitAction = SKAction.waitForDuration(1)
            let removeBlock = SKAction.runBlock({
                self.texture = SKTexture(imageNamed: "Kraken_Boss_Dead_1")
                inkAttack?.removeFromParent()})
            let sequence = SKAction.sequence([explodeCode, waitAction, removeBlock])
            self.runAction(sequence)
        }
    }
}
