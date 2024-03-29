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
    let krillSpeed = 350
    
    class func krillAtPosition(position: CGPoint) -> Krill{
        
        let krill = Krill(imageNamed: "Krill_1")
        krill.zRotation = pi / 4
        krill.position = position
        krill.name = "krill"
        
        
        krill.setupAnimation()
        krill.setupPhysicsBody()
        krill.setScale(0.1)
        return krill
        
    }
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryKrill.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
    func setupAnimation() {
        let textures = [SKTexture(imageNamed: "Krill_2"),
            SKTexture(imageNamed: "Krill_1")]
        let animation = SKAction.animate(with: textures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatForever(animation)
        self.run(repeatAction)
    }
    
    func moveTowardsPosition(){
        let distanceToMove = CGFloat(50.0)
        let numberOfMoves = Int(CGFloat(self.parent!.frame.maxY) / CGFloat(distanceToMove))
        var moveAction: SKAction
        var turnAction: SKAction
        var xValue = self.position.x
        var yValue = self.position.y
        var lastWasLeft = true
        var actionArray: [SKAction] = []
        var isFirst = true
        for _ in 0..<numberOfMoves {
            let leftOrRight = randomWithMin(min: 0, max: 100)
            if isFirst && leftOrRight > 49 {
                isFirst = false
                self.zRotation = -pi / 4
            }
            if leftOrRight < 50 {
                moveAction = SKAction.move(to: CGPointMake(xValue + distanceToMove, yValue - distanceToMove), duration: 1)
                turnAction = SKAction.rotate(toAngle: pi / 4, duration: 0)
                if lastWasLeft {
                    actionArray.append(turnAction)
                }
                actionArray.append(moveAction)
                lastWasLeft = false
                xValue = xValue + distanceToMove
                yValue = yValue - distanceToMove
            }else{
                moveAction = SKAction.move(to: CGPointMake(xValue - distanceToMove, yValue - distanceToMove), duration: 1)
                turnAction = SKAction.rotate(toAngle: -pi / 4, duration: 0)
                if !lastWasLeft{
                    actionArray.append(turnAction)
                }
                actionArray.append(moveAction)
                lastWasLeft = true
                xValue = xValue - distanceToMove
                yValue = yValue - distanceToMove
            }
        }
        actionArray.append(SKAction.removeFromParent())
        self.run(SKAction.sequence(actionArray))
    }
}
