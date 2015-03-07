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
        wizard.anchorPoint = CGPointMake(0.5, 0.5)
        wizard.name = "wizard"
        wizard.currentAngle = 3 * pi / 2.0
        //if canAttack{
        var textures: [SKTexture] = []
        for var i = 1; i <= 4; i=i+1{
            textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_\(i)"))
        }
        let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatActionForever(animation)
        wizard.runAction(repeatAction, withKey: "repeatAction")
        wizard.setupPhysicsBody()
        return wizard
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.dynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryWizard.rawValue
        self.physicsBody?.collisionBitMask = 0 //CollisionBitMasks.collisionCategoryHero.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
    func shootFireball(){
        if self.isDead{
            return
        }
        //display shooting animation
        //go back to rocking
        //self.runAction(repeatAction0, withKey: "repeatAction")
        let codeBlock0 = SKAction.runBlock({
            var textures: [SKTexture] = []
            for var i = 1; i <= 4; i=i+1{
                textures.append(SKTexture(imageNamed:"Clam_Boss_\(i)"))
            }
            let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
            let repeatAction0 = SKAction.repeatActionForever(animation)
            self.runAction(repeatAction0, withKey: "repeatAction")
        })
        let codeBlock = SKAction.runBlock({
            var textures: [SKTexture] = []
            for var i = 1; i <= 6; i=i+1{
                textures.append(SKTexture(imageNamed:"Clam_Boss_Rocking_\(i)"))
            }
            let animation2 = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
            let repeatAction = SKAction.repeatActionForever(animation2)
            self.runAction(repeatAction , withKey: "repeatAction")
        })
        let sequence = SKAction.sequence([codeBlock0, SKAction.waitForDuration(0.4), codeBlock])
        self.runAction(sequence)
        //calculate where to shoot the fireball
        let hero = self.parent!.childNodeWithName("hero") as HeroClass
        let shootAtPoint = hero.position
        //shoot the fireball
        let fireball = Fireball.fireballAtPosition(CGPointMake(self.position.x, self.position.y - 10))
        self.parent!.addChild(fireball)
        fireball.moveTowardsPosition(shootAtPoint)
    }
    
    func takeDamage(howMuch: CGFloat){
        self.life -= howMuch
        if (self.life <= 0){
            self.isDead = true
            self.removeAllActions()
            self.texture = nil
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
            let xDiff = CGFloat(randomWithMin(Int(lowerXDiff), Int(upperXDiff)))
            let yDiff = CGFloat(randomWithMin(Int(lowerYDiff), Int(upperYDiff)))
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
        
        let blizzCode = SKAction.runBlock({
            blizzNode = BlizzNode.createBlizz(position)
            self.parent!.addChild(blizzNode!)
            blizzAttack = blizzNode!.blizzAttack!
            //blizzAttack!.setScale(0.5)
            self.parent!.addChild(blizzAttack!)
            //self.removeActionForKey("blizz")
            //self.texture = nil
        })
        
        let removeBlock = SKAction.runBlock({blizzAttack!.removeFromParent()
            blizzNode!.removeFromParent()})
        let sequence = SKAction.sequence([blizzCode, SKAction.waitForDuration(5.0), removeBlock])
        self.runAction(sequence)
        
    }
}


