//
//  WhaleBoss.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 4/2/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit


class WhaleBoss: SKSpriteNode {
    //var currentAngle: CGFloat?
    var isDead = false
    var attackSpeed = 3
    var life: CGFloat = 1
    
    class func makeWhale(position: CGPoint) -> WhaleBoss{
        let whale = WhaleBoss(imageNamed: "Whale_Boss_1")
        whale.position = position
        whale.anchorPoint = CGPointMake(0.5, 0.5)
        whale.name = "whale"
        whale.setScale(0.13)
        whale.zPosition = 1
        //whale.currentAngle = 3 * pi / 2.0
        var textures: [SKTexture] = []
        //for var i = 1; i <= 24; i=i+1{
        //    textures.append(SKTexture(imageNamed:"wizard\(i)"))
        //}
        textures.append(SKTexture(imageNamed: "Whale_Boss_2"))
        textures.append(SKTexture(imageNamed: "Whale_Boss_3"))
        textures.append(SKTexture(imageNamed: "Whale_Boss_2"))
        textures.append(SKTexture(imageNamed: "Whale_Boss_1"))
        let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        //let repeatAction = SKAction.repeatActionForever(animation)
        let repeatAction = SKAction.repeatAction(animation, count: 1)
        let waitAction = SKAction.waitForDuration(2)
        let sequence = SKAction.sequence([repeatAction, waitAction])
        let realRepeatAction = SKAction.repeatActionForever(sequence)
        whale.runAction(realRepeatAction)
        whale.setupPhysicsBody()
        return whale
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.dynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryWizard.rawValue
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
        let lengthOfTop = self.parent!.frame.maxY - gapPosition.y + 25
        let lengthOfBot = gapPosition.y - 25
        var theSpeed = 150
        if (self.parent as? World1Level30 != nil) {
            //let extraSpeed = (self.parent as! World1Level30).phase * 2
            theSpeed = 65
        }
        self.parent!.addChild(WaveNode.waveAtPosition(CGPointMake(gapPosition.x, gapPosition.y + (lengthOfTop)/2), length: lengthOfTop, distance: self.parent!.frame.maxX + 50, speed: theSpeed))
        self.parent!.addChild(WaveNode.waveAtPosition(CGPointMake(gapPosition.x, lengthOfBot/2), length: lengthOfBot, distance: self.parent!.frame.maxX + 50, speed: theSpeed))
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
        //shoot the krill
        
        if ((self.parent as? World1Level30) != nil) {
            let krill = Krill.krillAtPosition(CGPointMake(self.parent!.frame.midX, self.parent!.frame.maxY + 20))
            self.parent!.addChild(krill)
            krill.moveTowardsPosition()
            
            let krill2 = Krill.krillAtPosition(CGPointMake(self.parent!.frame.midX + 100, self.parent!.frame.maxY + 20))
            self.parent!.addChild(krill2)
            krill2.moveTowardsPosition()
            
            let krill3 = Krill.krillAtPosition(CGPointMake(self.parent!.frame.midX - 100, self.parent!.frame.maxY + 20))
            self.parent!.addChild(krill3)
            krill3.moveTowardsPosition()
        }
        else{
        let krill = Krill.krillAtPosition(CGPointMake(self.position.x, self.position.y + 45))
        self.parent!.addChild(krill)
        krill.moveTowardsPosition()
        
        let krill2 = Krill.krillAtPosition(CGPointMake(self.position.x - 50, self.position.y + 45))
        self.parent!.addChild(krill2)
        krill2.moveTowardsPosition()
        
        let krill3 = Krill.krillAtPosition(CGPointMake(self.position.x + 50, self.position.y + 45))
        self.parent!.addChild(krill3)
        krill3.moveTowardsPosition()
        
        let krill4 = Krill.krillAtPosition(CGPointMake(self.position.x - 120, self.position.y + 60))
        self.parent!.addChild(krill4)
        krill4.moveTowardsPosition()
        
        let krill5 = Krill.krillAtPosition(CGPointMake(self.position.x + 120, self.position.y + 60))
        self.parent!.addChild(krill5)
        krill5.moveTowardsPosition()
        }
    }

    
    func takeDamage(howMuch: CGFloat){
        if soundOn {
            (self.parent as! SKScene).runAction(poofSound)
            let waitDuration = SKAction.waitForDuration(1)
            let runBlock = SKAction.runBlock({beachMusic.play()})
            let sequence = SKAction.sequence([waitDuration, runBlock])
            (self.parent as! SKScene).runAction(sequence)
            levelMusic.stop()
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
                self.texture = SKTexture(imageNamed: "Whale_Boss_Dead_1")
                inkAttack?.removeFromParent()})
            let sequence = SKAction.sequence([explodeCode, waitAction, removeBlock])
            self.runAction(sequence)
        }
    }
}