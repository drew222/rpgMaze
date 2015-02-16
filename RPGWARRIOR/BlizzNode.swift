//
//  BlizzNode.swift
//  RPGWARRIOR
//
//  Created by Tyler Mullins on 2/15/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit

class BlizzNode: SKSpriteNode{
    
    var blizzAttack: SKEmitterNode?
    
    class func createBlizz(position: CGPoint) -> BlizzNode {
        

        let blizzContactNode = BlizzNode(color: SKColor.blackColor(), size: CGSizeMake(60, 60))
        blizzContactNode.zPosition = -2.0
        blizzContactNode.position = position
        
        let blizzPath = NSBundle.mainBundle().pathForResource("BlizzParticle", ofType: "sks")
        blizzContactNode.blizzAttack = (NSKeyedUnarchiver.unarchiveObjectWithFile(blizzPath!) as SKEmitterNode)
        blizzContactNode.blizzAttack!.position = position
        
        blizzContactNode.setupPhysicsBody()
        
        //blizzAttack!.setScale(0.5)

        /*let damageBlock = SKAction.runBlock({
            let distanceFromBlizz = distanceBetween(self.parent!.childNodeWithName("hero")!.position, blizzAttack!.position)
            if distanceFromBlizz <= 60{
                let theHero = self.parent!.childNodeWithName("hero")! as HeroClass
                println("distance from bomb = \(distanceFromBlizz)")
                
            }else {
                
            }
        })*/
     return blizzContactNode
        
    }
    func slow() {
        heroSpeed -= 75
    }
    func unSlow() {
        heroSpeed += 75
    }
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryBlizzard.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
}
    /*class func blizzAtPos(position: CGPoint) -> SKEmitterNode {
        let blizzPath = NSBundle.mainBundle().pathForResource("BlizzParticle", ofType: "sks")
        let blizz = NSKeyedUnarchiver.unarchiveObjectWithFile(blizzPath!) as SKEmitterNode
        blizz.position = position
        blizz.zPosition = 10
        blizz.name = "Blizzard"
        return blizz
    }*/
    
    /*class func blizzContactNode(position: CGPoint, scene: SKScene) -> SKSpriteNode {
        let blizzPath = NSBundle.mainBundle().pathForResource("BlizzParticle", ofType: "sks")
        let blizz = NSKeyedUnarchiver.unarchiveObjectWithFile(blizzPath!) as SKEmitterNode
        let blizzContactNode = SKSpriteNode(color: SKColor.blackColor(), size: CGSizeMake(100, 100))
        blizzContactNode.zPosition = -2.0
        blizzContactNode.position = position
        
        
        return blizzContactNode
        
    }*/
