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
    
    var fireballSpeed = 300
    
    class func fireballAtPosition(position: CGPoint) -> Fireball{
        
        let projectile = Fireball(imageNamed: "Pearl_Projectile_1")
        projectile.position = position
        projectile.name = "Fireball"
        
        
        projectile.setupAnimation()
        projectile.setupPhysicsBody()
        projectile.setScale(0.3)
        return projectile
        
    }
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryProjectile.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
    func setupAnimation() {
        let textures = [SKTexture(imageNamed: "Pearl_Projectile_2"),
            SKTexture(imageNamed: "Pearl_Projectile_1")]
        let animation = SKAction.animate(with: textures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatForever(animation)
        self.run(repeatAction)
    }
    
    func moveTowardsPosition(position: CGPoint){
        if let _ = (self.parent as? World1Level14){
            fireballSpeed = 50
        }
        //println("Click position at (\(position.x), \(position.y))")
        let slope = (position.y - self.position.y) / (position.x - self.position.x)
        var offScreenX = CGFloat(0)
        let ourScene = self.parent as! SKScene
        if (position.x <= self.position.x){
            offScreenX = -10
        }
        else{
            offScreenX = ourScene.frame.width + 10
        }
        let offScreenY = position.y + slope * offScreenX - slope * position.x
        
        var pointOffScreen = CGPointMake(offScreenX, offScreenY)
        if (position.x - self.position.x == 0){
            pointOffScreen = CGPointMake(position.x, -20)
        }
        //println("Offscreen Position is at (\(pointOffScreen.x), \(pointOffScreen.y))")
        let xDistance = self.position.x - pointOffScreen.x
        
        let yDistance = self.position.y - pointOffScreen.y
        
        let distance = sqrt(pow(xDistance, 2) + pow(yDistance, 2))
        
        
        let time = TimeInterval(distance / CGFloat(fireballSpeed))

        let moveProjectile = SKAction.move(to: pointOffScreen, duration: time)
        
        self.run(moveProjectile)
    }
}
