//
//  WhiteShell.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 6/13/15.
//  Copyright (c) 2015 Drew and Zach. All rights reserved.
//

import Foundation

import Foundation
import SpriteKit

class WhiteShell: SKSpriteNode {
    
    let mineSpeed = CGFloat(300.0)
    var isArmed = true
    
    class func mineAtPos(position: CGPoint) -> WhiteShell {
        let mine = WhiteShell(imageNamed: "Whiteshell_1")
        mine.position = position
        mine.name = "whiteshell"
        mine.setupAnimation()
        mine.setupPhysicsBody()
        mine.setScale(0.5)
        return mine
    }
    
    func setupAnimation() {
        let textures = [SKTexture(imageNamed: "Whiteshell_2"),
            SKTexture(imageNamed: "Whiteshell_3"),
            SKTexture(imageNamed: "Whiteshell_2"),
            SKTexture(imageNamed: "Whiteshell_1")]
        let animation = SKAction.animate(with: textures, timePerFrame: 0.2)
        let randomWait = SKAction.wait(forDuration: 0.5, withRange: 2)
        let sequence = SKAction.sequence([randomWait, animation])
        let repeatAction = SKAction.repeatForever(sequence)
        self.run(repeatAction)
    }
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSizeMake(self.frame.width * 0.80, self.frame.height * 0.80))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryWhiteShell.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    func explode(position: CGPoint){
        //var liteAttack: SKEmitterNode?
        let explodeCode = SKAction.run({
            let textures: [SKTexture] = [SKTexture(imageNamed:"Whiteshell_4")]
            let animation = SKAction.animate(with: textures, timePerFrame: 3.0)
            self.run(animation)
            //self.removeActionForKey("fire")
            //self.texture = nil
        })
        
        let removeBlock = SKAction.run({
            self.removeFromParent()})
        let damageBlock = SKAction.run({
            _ = distanceBetween(point1: self.parent!.childNode(withName: "hero")!.position, point2: self.position)
            //if distanceFromMine < 25{
            _ = self.parent!.childNode(withName: "hero")! as! HeroClass
            self.isArmed = false
            //}
        })
        let sequence = SKAction.sequence([explodeCode, damageBlock, SKAction.wait(forDuration: 1.0), SKAction.fadeOut(withDuration: 1.0), removeBlock])
        self.run(sequence)
        self.physicsBody = nil
        
    }
    func throwMineToPos(position: CGPoint) {
        
        let frameX: UInt32 = UInt32(self.frame.width)
        let frameY: UInt32 = UInt32(self.frame.height)
        let randomPositionX = CGFloat(arc4random_uniform(frameX))
        let randomPositionY = CGFloat(arc4random_uniform(frameY))
        _ = CGPointMake(randomPositionX, randomPositionY)
        let distanceA = Float(randomPositionY - self.position.y)
        let distanceB = Float(randomPositionX - self.position.x)
        let distanceC = CGFloat((sqrt(powf(distanceA, 2))) + (sqrt(powf(distanceB, 2))))
        let time = distanceC / mineSpeed
        
        let throw1 = SKAction.move(to: position, duration: TimeInterval(time))
        let armMine = SKAction.run({self.isArmed = true})
        let sequence = SKAction.sequence([throw1, armMine])
        self.run(sequence)
        
    }
}
