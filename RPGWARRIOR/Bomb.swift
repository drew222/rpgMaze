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
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
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
        let animation = SKAction.animate(with: textures, timePerFrame: 0.08)
        let repeatAction = SKAction.repeat(animation, count: 1)
        self.run(repeatAction, withKey: "fire")
    }
    
    
    func explode(position: CGPoint){
        let waitAction = SKAction.wait(forDuration: TimeInterval(0.8))
        var liteAttack: SKEmitterNode?
        let explodeCode = SKAction.run({let litePath = Bundle.main.path(forResource: "LightParticle", ofType: "sks")
            liteAttack = (NSKeyedUnarchiver.unarchiveObject(withFile: litePath!) as! SKEmitterNode)
            liteAttack!.position = position
            liteAttack!.name = "ballfrags"
            liteAttack!.setScale(0.5)
            self.parent!.addChild(liteAttack!)
            self.removeAction(forKey: "fire")
            self.texture = nil})
        
        let removeBlock = SKAction.run({liteAttack!.removeFromParent()
                                             self.removeFromParent()})
        let damageBlock = SKAction.run({
            let distanceFromBomb = distanceBetween(point1: self.parent!.childNode(withName: "hero")!.position, point2: self.position)
            if distanceFromBomb < 55{
                let theHero = self.parent!.childNode(withName: "hero")! as! HeroClass
                print("distance from bomb = \(distanceFromBomb)")
                if (theHero.parent as? World1Level22 != nil){
                    theHero.takeDamage(damage: 3.0)
                }else if let gauntletLevel = theHero.parent as? World1Level30 {
                    var damage = CGFloat(2)
                    if gauntletLevel.phase > 10 {
                        damage = 4
                    }else if gauntletLevel.phase > 20{
                        damage = 8
                    }else if gauntletLevel.phase > 30{
                        damage = 16
                    }else if gauntletLevel.phase > 40{
                        damage = 32
                    }
                    theHero.takeDamage(damage: damage)
                }else{
                    theHero.takeDamage(damage: 1.0)
                }
            }})
        let sequence = SKAction.sequence([waitAction, explodeCode, damageBlock, SKAction.wait(forDuration: 0.5), removeBlock])
        self.run(sequence)
        
    }
}
