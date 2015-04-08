//
//  Krill.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/7/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit


class Krill: SKSpriteNode {
    let krillSpeed = 250
    
    class func krillAtPosition(position: CGPoint) -> Krill{
        
        let krill = Krill(imageNamed: "Krill_1")
        krill.position = position
        krill.name = "krill"
        
        
        krill.setupAnimation()
        krill.setupPhysicsBody()
        krill.setScale(0.1)
        return krill
        
    }
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryKrill.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
    func setupAnimation() {
        let textures = [SKTexture(imageNamed: "Krill_2"),
            SKTexture(imageNamed: "Krill_1")]
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
        
        let time = NSTimeInterval(distance / CGFloat(krillSpeed))
        
        let moveProjectile = SKAction.moveTo(pointOffScreen, duration: time)
        
        self.runAction(moveProjectile)
        
    }
}
