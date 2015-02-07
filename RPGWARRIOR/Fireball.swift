//
//  Fireball.swift
//  TestRpgGame
//
//  Created by Drew Zoellner on 1/29/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit


class Fireball: SKSpriteNode {
    let fireballSpeed = 300
    
    class func fireballAtPosition(position: CGPoint) -> Fireball{
        
        let projectile = Fireball(imageNamed: "projectile_1")
        projectile.position = position
        projectile.name = "Fireball"
        
        
        projectile.setupAnimation()
        projectile.setupPhysicsBody()
        return projectile
        
    }
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryProjectile.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
    func setupAnimation() {
        let textures = [SKTexture(imageNamed: "projectile_1"),
            SKTexture(imageNamed: "projectile_2"),
            SKTexture(imageNamed: "projectile_3")]
        let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatActionForever(animation)
        self.runAction(repeatAction)
    }
    
    func moveTowardsPosition(position: CGPoint){
        //println("Click position at (\(position.x), \(position.y))")
        let slope = (position.y - self.position.y) / (position.x - self.position.x)
        var offScreenX = CGFloat(0)
        let ourScene = self.parent as SKScene
        if (position.x <= self.position.x){
            offScreenX = -10
        }
        else{
            offScreenX = ourScene.frame.width + 10
        }
        let offScreenY = position.y + slope * offScreenX - slope * position.x
        
        let pointOffScreen = CGPointMake(offScreenX, offScreenY)
        //println("Offscreen Position is at (\(pointOffScreen.x), \(pointOffScreen.y))")
        let xDistance = self.position.x - offScreenX
        
        let yDistance = self.position.y - offScreenY
        
        let distance = sqrt(pow(xDistance, 2) + pow(yDistance, 2))
        
        let time = NSTimeInterval(distance / CGFloat(fireballSpeed))
        
        let moveProjectile = SKAction.moveTo(pointOffScreen, duration: time)
        
        self.runAction(moveProjectile)
        
    }
}