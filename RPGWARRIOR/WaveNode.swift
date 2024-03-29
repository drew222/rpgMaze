//
//  WaveNode.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 4/2/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit


class WaveNode: SKSpriteNode {
    
    //create wave at point with size
    class func waveAtPosition(position: CGPoint, length: CGFloat, distance: CGFloat, speed: Int) -> WaveNode{
        let wave = WaveNode(imageNamed: "Wave_1")
        wave.position = position
        wave.name = "wave"
        wave.size = CGSizeMake(length - 50, 30)
        //rotate
        var angle = -pi / 2
        var left = false
        if position.x < 0 {
            left = true
            angle = -angle
        }
        wave.run(SKAction.rotate(toAngle: angle, duration: 0))
        //animate all textures
        let textures: [SKTexture] = [SKTexture(imageNamed: "Wave_2"), SKTexture(imageNamed: "Wave_3"), SKTexture(imageNamed: "Wave_2"), SKTexture(imageNamed: "Wave_1")]
        let animateAction = SKAction.animate(with: textures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatForever(animateAction)
        wave.run(repeatAction)
        //move the wave
        var xPosition = position.x + distance
        if !left {
            xPosition = position.x - distance
        }
        //WAVESPEED IS 120***
        let time = TimeInterval(distance / CGFloat(speed))
        let moveToAction = SKAction.move(to: CGPointMake(xPosition, position.y), duration: time)
        let codeBlock = SKAction.run({wave.removeFromParent()})
        let sequence = SKAction.sequence([moveToAction, codeBlock])
        wave.setupPhysicsBody()
        wave.run(sequence)
        return wave
        
    }
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSizeMake(self.frame.width * 0.90, self.frame.height * 0.90))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryWave.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
}
