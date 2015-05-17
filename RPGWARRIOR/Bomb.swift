//
//  Bomb.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 2/8/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit

class Bomb: SKSpriteNode {
    let fireballSpeed = 300
    
    class func bombAtPosition(position: CGPoint) -> Bomb{
        
        let bomb = Bomb(imageNamed: "Beach_Ball_4")
        bomb.position = position
        bomb.name = "bomb"
        
        
        bomb.setupAnimation()
        bomb.setupPhysicsBody()
        bomb.setScale(0.15)
        return bomb
        
    }
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryBomb.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
    func setupAnimation() {
        let textures = [SKTexture(imageNamed: "Beach_Ball_4"),
            SKTexture(imageNamed: "Beach_Ball_2"),
            SKTexture(imageNamed: "Beach_Ball_3"),
            SKTexture(imageNamed: "Beach_Ball_5"),
            SKTexture(imageNamed: "Beach_Ball_1")]
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
                theHero.takeDamage(3.0)
            }})
        let sequence = SKAction.sequence([waitAction, explodeCode, damageBlock, SKAction.waitForDuration(0.5), removeBlock])
        self.runAction(sequence)
        
    }
}