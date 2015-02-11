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
    
    let mineSpeed = CGFloat(300.0)
    
    class func mineAtPos(position: CGPoint) -> MineNode {
        let mine = MineNode(imageNamed: "projectile_1.png")
        mine.position = position
        mine.name = "Mine"
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
    func throwMineToPos(position: CGPoint) {
        
        let frameX: UInt32 = UInt32(self.frame.width)
        let frameY: UInt32 = UInt32(self.frame.height)
        let randomPositionX = CGFloat(arc4random_uniform(frameX))
        let randomPositionY = CGFloat(arc4random_uniform(frameY))
        let randomPos = CGPointMake(randomPositionX, randomPositionY)
        var distanceA = Float(randomPositionY - self.position.y)
        var distanceB = Float(randomPositionX - self.position.x)
        var distanceC = CGFloat((sqrt(powf(distanceA, 2))) + (sqrt(powf(distanceB, 2))))
        let time = distanceC / mineSpeed
        
        let throw = SKAction.moveTo(position, duration: NSTimeInterval(time))
        self.runAction(throw)
        
    }
}

