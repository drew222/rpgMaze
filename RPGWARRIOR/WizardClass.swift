//
//  WizardClass.swift
//  TestRpgGame
//
//  Created by Drew Zoellner on 1/29/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit


class WizardClass: SKSpriteNode {
    var currentAngle: CGFloat?
    var life: CGFloat = 1
    var isDead = false
    
    class func makeWizard(position: CGPoint) -> WizardClass{
        let wizard = WizardClass(imageNamed: "Clam_Boss_1.png")
        wizard.position = position
        wizard.setScale(0.2)
        wizard.anchorPoint = CGPointMake(0.5, 0.5)
        wizard.name = "wizard"
        wizard.currentAngle = 3 * pi / 2.0
        //if canAttack{
        var textures: [SKTexture] = []
        for i in 1...3 {
            textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_\(i)"))
        }
        textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_2"))
        textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_1"))
        textures.append(SKTexture(imageNamed:"Clam_Boss_1"))
        textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_4"))
        textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_5"))
        textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_6"))
        textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_5"))
        textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_4"))
        textures.append(SKTexture(imageNamed:"Clam_Boss_1"))
        textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_1"))
        textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_2"))
        textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_1"))
        textures.append(SKTexture(imageNamed:"Clam_Boss_1"))
        textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_4"))
        textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_1"))
        textures.append(SKTexture(imageNamed:"Clam_Boss_1"))
        let animation = SKAction.animate(with: textures, timePerFrame: 0.1)
        let sequenceRepeat = SKAction.sequence([animation, SKAction.wait(forDuration: 1.5)])
        let repeatAction = SKAction.repeatForever(sequenceRepeat)
        wizard.run(repeatAction, withKey: "repeatAction")
        wizard.setupPhysicsBody()
        return wizard
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryWizard.rawValue
        self.physicsBody?.collisionBitMask = 0 //CollisionBitMasks.collisionCategoryHero.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
    func shootFireball(aPosition: CGPoint){
        if self.isDead{
            return
        }
        //display shooting animation
        //go back to rocking
        //self.runAction(repeatAction0, withKey: "repeatAction")
        let codeBlock0 = SKAction.run({
            var textures: [SKTexture] = []
            for i in 1...4 {
                textures.append(SKTexture(imageNamed:"Clam_Boss_\(i)"))
            }
            let animation = SKAction.animate(with: textures, timePerFrame: 0.1)
            let repeatAction0 = SKAction.repeatForever(animation)
            self.run(repeatAction0, withKey: "repeatAction")
        })
        let codeBlock = SKAction.run({
            var textures: [SKTexture] = []
            for var i in 1...3 {
                i += 1
                textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_\(i)"))
            }
            textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_2"))
            textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_1"))
            textures.append(SKTexture(imageNamed:"Clam_Boss_1"))
            textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_4"))
            textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_5"))
            textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_6"))
            textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_5"))
            textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_4"))
            textures.append(SKTexture(imageNamed:"Clam_Boss_1"))
            textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_1"))
            textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_2"))
            textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_1"))
            textures.append(SKTexture(imageNamed:"Clam_Boss_1"))
            textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_4"))
            textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_1"))
            textures.append(SKTexture(imageNamed:"Clam_Boss_1"))
            let animation2 = SKAction.animate(with: textures, timePerFrame: 0.1)
            let sequenceRepeat = SKAction.sequence([animation2, SKAction.wait(forDuration: 1.5)])
            let repeatAction = SKAction.repeatForever(sequenceRepeat)
            self.run(repeatAction , withKey: "repeatAction")
        })
        let sequence = SKAction.sequence([codeBlock0, SKAction.wait(forDuration: 0.4), codeBlock])
        self.run(sequence)
        //calculate where to shoot the fireball
        //let hero = self.parent!.childNodeWithName("hero") as! HeroClass
        let shootAtPoint = aPosition
        //shoot the fireball
        let fireball = Fireball.fireballAtPosition(position: CGPointMake(self.position.x, self.position.y - 10))
        self.parent!.addChild(fireball)
        fireball.moveTowardsPosition(position: shootAtPoint)
    }
    
    func takeDamage(howMuch: CGFloat){
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
                inkAttack!.setScale(0.7)
                self.parent!.addChild(inkAttack!)
            })
            let waitAction = SKAction.wait(forDuration: 1)
            let removeBlock = SKAction.run({
                self.yScale -= 0.09
                self.xScale -= 0.04
                self.position = CGPointMake(self.position.x, self.position.y - 8)
                self.texture = SKTexture(imageNamed: "Clam_Boss_Dead_1")
                inkAttack?.removeFromParent()})
            let sequence = SKAction.sequence([explodeCode, waitAction, removeBlock])
            self.run(sequence)
            
        }
    }
    func getBlizzLocation(heroPosition: CGPoint)->CGPoint{
            //generate random x and y within a range of the hero
            let xRange = abs(self.position.x - heroPosition.x)
            let yRange = abs(self.position.y - heroPosition.y)
            let lowerXDiff = round(xRange * 0.45)
            let lowerYDiff = round(yRange * 0.45)
            let upperXDiff = round(xRange * 1)
            let upperYDiff = round(yRange * 1)
        let xDiff = CGFloat(randomWithMin(min: Int(lowerXDiff), max: Int(upperXDiff)))
        let yDiff = CGFloat(randomWithMin(min: Int(lowerYDiff), max: Int(upperYDiff)))
            var xPosition: CGFloat?
            var yPosition: CGFloat?
            if self.position.x > heroPosition.x{
                xPosition = CGFloat(self.position.x - xDiff)
            }else{
                xPosition = CGFloat(self.position.x + xDiff)
            }
            if self.position.y > heroPosition.y{
                yPosition = CGFloat(self.position.y - yDiff)
            }else{
                yPosition = CGFloat(self.position.y + yDiff)
            }
            return CGPointMake(xPosition!, yPosition!)
        }
    func createBlizz(position: CGPoint){
        
        var blizzNode: BlizzNode?
        var blizzAttack: SKEmitterNode?
        
        let blizzCode = SKAction.run({
            blizzNode = BlizzNode.createBlizz(position: position)
            self.parent!.addChild(blizzNode!)
            blizzAttack = blizzNode!.blizzAttack!
            //blizzAttack!.setScale(0.5)
            self.parent!.addChild(blizzAttack!)
            //self.removeActionForKey("blizz")
            //self.texture = nil
        })
        
        let removeBlock = SKAction.run({blizzAttack!.removeFromParent()
            blizzNode!.removeFromParent()})
        let sequence = SKAction.sequence([blizzCode, SKAction.wait(forDuration: 5.0), removeBlock])
        self.run(sequence)
        
    }
}


