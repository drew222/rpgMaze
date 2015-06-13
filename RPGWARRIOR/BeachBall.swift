//
//  BeachBall.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 6/13/15.
//  Copyright (c) 2015 Drew and Zach. All rights reserved.
//

import Foundation
import SpriteKit

class BeachBall: SKSpriteNode {
    let fireballSpeed = 300
    
    class func bombAtPosition(position: CGPoint) -> BeachBall{
        
        let bomb = BeachBall(imageNamed: "Bomb_Ball_4")
        bomb.position = position
        bomb.name = "beachball"
        
        
        bomb.setupAnimation()
        bomb.setupPhysicsBody()
        bomb.setScale(0.15)
        return bomb
        
    }
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryBeachBall.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
    func setupAnimation() {
        let textures = [SKTexture(imageNamed: "Bomb_Ball_4"),
            SKTexture(imageNamed: "Bomb_Ball_2"),
            SKTexture(imageNamed: "Bomb_Ball_3"),
            SKTexture(imageNamed: "Bomb_Ball_5"),
            SKTexture(imageNamed: "Bomb_Ball_1")]
        let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.08)
        let repeatAction = SKAction.repeatAction(animation, count: 1)
        self.runAction(repeatAction, withKey: "fire")
    }
    
    
    func explode(position: CGPoint){
        let waitAction = SKAction.waitForDuration(NSTimeInterval(0.8))
        var liteAttack: SKEmitterNode?
        let explodeCode = SKAction.runBlock({let litePath = NSBundle.mainBundle().pathForResource("LightParticle", ofType: "sks")
            liteAttack = (NSKeyedUnarchiver.unarchiveObjectWithFile(litePath!) as! SKEmitterNode)
            liteAttack!.position = position
            liteAttack!.name = "ballfrags"
            liteAttack!.setScale(0.5)
            self.parent!.addChild(liteAttack!)
            self.removeActionForKey("fire")
            self.texture = nil})
        
        let removeBlock = SKAction.runBlock({liteAttack!.removeFromParent()
            self.removeFromParent()})
        let damageBlock = SKAction.runBlock({
            let distanceFromBomb = distanceBetween(self.parent!.childNodeWithName("hero")!.position, self.position)
            if distanceFromBomb < 55{
                let theHero = self.parent!.childNodeWithName("hero")! as! HeroClass
                println("distance from bomb = \(distanceFromBomb)")
                if (theHero.parent as? World1Level22 != nil){
                    theHero.takeDamage(3.0)
                }else if let gauntletLevel = theHero.parent as? World1Level30 {
                    var damage = CGFloat(2)
                    if gauntletLevel.phase > 10 {
                        damage = 4
                    }else if gauntletLevel.phase > 20{
                        damage = 8
                    }else if gauntletLevel.phase > 30{
                        damage = 16
                    }else if gauntletLevel.phase > 40{
                        damage = 32
                    }
                    theHero.takeDamage(damage)
                }else{
                    theHero.takeDamage(3.0)
                }
            }})
        let sequence = SKAction.sequence([waitAction, explodeCode, damageBlock, SKAction.waitForDuration(0.5), removeBlock])
        self.runAction(sequence)
        
    }
}
