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
        let animation = SKAction.animate(with: textures, timePerFrame: 0.1)
        //let repeatAction = SKAction.repeatActionForever(animation)
        let repeatAction = SKAction.repeat(animation, count: 1)
        let waitAction = SKAction.wait(forDuration: 2)
        let sequence = SKAction.sequence([repeatAction, waitAction])
        let realRepeatAction = SKAction.repeatForever(sequence)
        kraken.run(realRepeatAction)
        kraken.setupPhysicsBody()
        return kraken
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryWizard.rawValue
        self.physicsBody?.collisionBitMask = 0 //CollisionBitMasks.collisionCategoryHero.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
    func setupWavePhysicsBody(node: SKSpriteNode) {
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSizeMake(self.frame.width * 2.96, self.frame.height * 0.6))
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
        let rotateAction = SKAction.rotate(byAngle: 2 * pi, duration: 2)
        let repeatRotate = SKAction.repeatForever(rotateAction)
        let waitAction = SKAction.wait(forDuration: 6)
        let sandNode = SKSpriteNode(imageNamed: "Safety_Pillar_3")
        sandNode.position = position
        sandNode.name = "safeSpot2"
        sandNode.size = CGSizeMake(48, 48)
        let removeBlock = SKAction.run({safeSpotNode.removeFromParent()
            sandNode.removeFromParent()})
        self.parent?.addChild(safeSpotNode)
        self.parent?.addChild(sandNode)
        safeSpotNode.run(SKAction.sequence([repeatRotate, waitAction, removeBlock]))
        sandNode.zPosition = 2
        
        
        
        let oilWave = SKSpriteNode(imageNamed: "Ink_Flood_1")
        oilWave.name = "wave"
        setupWavePhysicsBody(node: oilWave)
        let textures = [SKTexture(imageNamed: "Ink_Flood_2"),SKTexture(imageNamed: "Ink_Flood_3"), SKTexture(imageNamed: "Ink_Flood_1")]
        let animateWave = SKAction.animate(with: textures, timePerFrame: 0.3)
        let repeatAction = SKAction.repeatForever(animateWave)
        oilWave.run(repeatAction)
        //oilWave.size = self.parent!.frame.size
        oilWave.size = CGSizeMake(self.parent!.frame.maxX, self.parent!.frame.maxY + 70)
        oilWave.anchorPoint = CGPointMake(0.5, 0)
        oilWave.zPosition = 1
        oilWave.position = CGPointMake(self.parent!.frame.midX, self.parent!.frame.maxY + 30)
        let moveDownAction = SKAction.move(to: CGPointMake(self.parent!.frame.midX, self.parent!.frame.minY - 70), duration: 2)
        let moveUpAction = SKAction.fadeOut(withDuration: 1)
        let remBlock = SKAction.run({oilWave.removeFromParent()})
        var waitToWave = SKAction.wait(forDuration: 1.75)
        if let _ = self.parent as? World1Level30 {
            waitToWave = SKAction.wait(forDuration: 3)
        }
        let sequence = SKAction.sequence([waitToWave, moveDownAction, moveUpAction, remBlock])
        oilWave.run(sequence)
        self.parent?.addChild(oilWave)
    }
    
    func getSafePosition() -> CGPoint {
        let xPos = randomWithMin(min: 25, max: Int(self.parent!.frame.width) - 25)
        let yPos = randomWithMin(min: 115, max: Int(self.parent!.frame.height) - 185)
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
        
        let waveAttackAnimation = SKAction.animate(with: textures, timePerFrame: 0.05)
        var textures2: [SKTexture] = []
        textures2.append(SKTexture(imageNamed: "Kraken_Boss_1"))
        textures2.append(SKTexture(imageNamed: "Kraken_Boss_2"))
        textures2.append(SKTexture(imageNamed: "Kraken_Boss_3"))
        textures2.append(SKTexture(imageNamed: "Kraken_Boss_2"))
        let idleAnimation = SKAction.animate(with: textures2, timePerFrame: 0.1)
        let repeatAction = SKAction.repeat(idleAnimation, count: 1)
        let waitAction = SKAction.wait(forDuration: 2)
        let sequence = SKAction.sequence([repeatAction, waitAction])
        let realRepeatAction = SKAction.repeatForever(sequence)
        let finalSequence = SKAction.sequence([waveAttackAnimation, realRepeatAction])
        self.run(finalSequence)
        
        //create tentacle
        let tentacle = Tentacle.tentacleAtPosition(position: getTentaclePoint())
        tentacle.zPosition = 3
        self.parent!.addChild(tentacle)
        //self.parent!.addChild(Tentacle.tentacleAtPosition(getTentaclePoint()))
    }
    
    func getTentaclePoint() -> CGPoint {
        let heroPosition = self.parent!.childNode(withName: "hero")!.position
        
        return heroPosition
    }
    
    
    func takeDamage(howMuch: CGFloat){
        if soundOn {
            (self.parent as! SKScene).run(poofSound)
            let waitDuration = SKAction.wait(forDuration: 1)
            let runBlock = SKAction.run({beachMusic!.play()})
            let sequence = SKAction.sequence([waitDuration, runBlock])
            (self.parent as! SKScene).run(sequence)
            levelMusic!.stop()
        }
        self.life -= howMuch
        if (self.life <= 0) && !self.isDead{
            self.isDead = true
            self.removeAllActions()
            var inkAttack: SKEmitterNode?
            let explodeCode = SKAction.run({let litePath = Bundle.main.path(forResource: "SmokeParticle", ofType: "sks")
                inkAttack = (NSKeyedUnarchiver.unarchiveObject(withFile: litePath!) as! SKEmitterNode)
                inkAttack!.position = CGPointMake(self.position.x, self.position.y - 10)
                inkAttack!.zPosition = 4
                inkAttack!.name = "inkAttack"
                inkAttack!.setScale(1.2)
                self.parent!.addChild(inkAttack!)
            })
            let waitAction = SKAction.wait(forDuration: 1)
            let removeBlock = SKAction.run({
                self.texture = SKTexture(imageNamed: "Kraken_Boss_Dead_1")
                inkAttack?.removeFromParent()})
            let sequence = SKAction.sequence([explodeCode, waitAction, removeBlock])
            self.run(sequence)
        }
    }
}
