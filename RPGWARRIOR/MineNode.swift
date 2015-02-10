//
//  MineNode.swift
//  ThrowMine
//
//  Created by Tyler Mullins on 2/2/15.
//  Copyright (c) 2015 Tyler Mullins. All rights reserved.
//

import Foundation
import SpriteKit

class MineNode: SKSpriteNode {
    
    class func mineAtPos(position: CGPoint) -> MineNode {
        let mine = MineNode(imageNamed: "projectile_1.png")
        mine.position = position
        mine.setupAnimation()
        mine.setupPhysicsBody()
        return mine
    }
    
    func setupAnimation() {
        let textures = [SKTexture(imageNamed: "projectile_1"),
            SKTexture(imageNamed: "projectile_2"),
            SKTexture(imageNamed: "projectile_3")]
        let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatActionForever(animation)
        self.runAction(repeatAction)
    }
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryProjectile.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    func explode(position: CGPoint){
        let waitAction = SKAction.waitForDuration(NSTimeInterval(1))
        var liteAttack: SKEmitterNode?
        let explodeCode = SKAction.runBlock({let litePath = NSBundle.mainBundle().pathForResource("LightParticle", ofType: "sks")
            liteAttack = (NSKeyedUnarchiver.unarchiveObjectWithFile(litePath!) as SKEmitterNode)
            liteAttack!.position = position
            liteAttack!.setScale(0.5)
            self.parent!.addChild(liteAttack!)
            self.removeActionForKey("fire")
            self.texture = nil})
        
        let removeBlock = SKAction.runBlock({liteAttack!.removeFromParent()
            self.removeFromParent()})
        let damageBlock = SKAction.runBlock({
            let distanceFromMine = distanceBetween(self.parent!.childNodeWithName("hero")!.position, self.position)
            if distanceFromMine < 5{
                let theHero = self.parent!.childNodeWithName("hero")! as HeroClass
                println("distance from bomb = \(distanceFromMine)")
                theHero.takeDamage(3.0)
            }})
        let sequence = SKAction.sequence([waitAction, explodeCode, damageBlock, SKAction.waitForDuration(0.5), removeBlock])
        self.runAction(sequence)
        
    }

    
}

