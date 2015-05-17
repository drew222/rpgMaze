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
    var isArmed = false
    
    class func mineAtPos(position: CGPoint) -> MineNode {
        let mine = MineNode(imageNamed: "Seashell_3")
        mine.position = position
        mine.name = "Mine"
        mine.setupAnimation()
        mine.setupPhysicsBody()
        mine.setScale(0.5)
        return mine
    }
    
    func setupAnimation() {
        let textures = [SKTexture(imageNamed: "Seashell_3"),
            SKTexture(imageNamed: "Seashell_2"),
            SKTexture(imageNamed: "Seashell_1"),
            SKTexture(imageNamed: "Seashell_2")]
        let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatActionForever(animation)
        self.runAction(repeatAction)
    }
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width * 0.80, self.frame.height * 0.80))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategorySeashell.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    func explode(position: CGPoint){
        //var liteAttack: SKEmitterNode?
        let explodeCode = SKAction.runBlock({//let litePath = NSBundle.mainBundle().pathForResource("LightParticle", ofType: "sks")
            //liteAttack = (NSKeyedUnarchiver.unarchiveObjectWithFile(litePath!) as SKEmitterNode)
            //liteAttack!.position = position
            //liteAttack!.setScale(0.5)
            //if (self.parent! as? SKScene != nil){
                //self.parent!.addChild(liteAttack!)
            //}
            let textures: [SKTexture] = [SKTexture(imageNamed:"Seashell_1")]
            let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
            let repeat = SKAction.repeatAction(animation, count: 1)
            self.runAction(repeat)
            //self.removeActionForKey("fire")
            //self.texture = nil
        })
        
        let removeBlock = SKAction.runBlock({//liteAttack!.removeFromParent()
            self.removeFromParent()})
        let damageBlock = SKAction.runBlock({
            let distanceFromMine = distanceBetween(self.parent!.childNodeWithName("hero")!.position, self.position)
            //if distanceFromMine < 25{
            let theHero = self.parent!.childNodeWithName("hero")! as! HeroClass
            println("distance from bomb = \(distanceFromMine)")
            theHero.takeDamage(3.0)
            //}
        })
        let sequence = SKAction.sequence([explodeCode, damageBlock, SKAction.waitForDuration(0.3), removeBlock])
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
        let armMine = SKAction.runBlock({self.isArmed = true})
        let sequence = SKAction.sequence([throw, armMine])
        self.runAction(sequence)
        
    }
}

