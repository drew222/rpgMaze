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
        krill.zRotation = pi / 4
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
    
    func moveTowardsPosition(){
        let distanceToMove = CGFloat(50.0)
        let numberOfMoves = Int(CGFloat(self.parent!.frame.maxY) / CGFloat(distanceToMove))
        var moveAction: SKAction
        var turnAction: SKAction
        var xValue = self.position.x
        var yValue = self.position.y
        var lastWasLeft = true
        var actionArray: [SKAction] = []
        for (var i = 0; i < numberOfMoves; i++){
            let leftOrRight = randomWithMin(0, 100)
            if leftOrRight < 50 {
                moveAction = SKAction.moveTo(CGPointMake(xValue + distanceToMove, yValue - distanceToMove), duration: 1)
                turnAction = SKAction.rotateToAngle(pi / 4, duration: 0)
                if lastWasLeft {
                    actionArray.append(turnAction)
                }
                actionArray.append(moveAction)
                lastWasLeft = false
                xValue = xValue + distanceToMove
                yValue = yValue - distanceToMove
            }else{
                moveAction = SKAction.moveTo(CGPointMake(xValue - distanceToMove, yValue - distanceToMove), duration: 1)
                turnAction = SKAction.rotateToAngle(-pi / 4, duration: 0)
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
        self.runAction(SKAction.sequence(actionArray))
    }
}
