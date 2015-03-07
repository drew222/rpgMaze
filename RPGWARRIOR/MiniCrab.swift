//
//  MiniCrab.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 3/7/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit


class MiniCrab: SKSpriteNode {
    
    var startPosition: CGPoint?
    var endPosition: CGPoint?
    let crabSpeed = 150
    class func crabAtPosition(startPos: CGPoint, endPosition: CGPoint) -> MiniCrab{
        let crab = MiniCrab(imageNamed: "Seashell_1")
        crab.position = startPos
        crab.startPosition = startPos
        crab.name = "crab"
        crab.endPosition = endPosition
        //rotate
        crab.runAction(SKAction.rotateToAngle(angleFromPoints(startPos, endPosition) - pi, duration: 0))
        //animate all textures
        let textures: [SKTexture] = [SKTexture(imageNamed: "Seashell_3"), SKTexture(imageNamed: "Seashell_2"), SKTexture(imageNamed: "Seashell_1"), SKTexture(imageNamed: "Seashell_2")]
        let animateAction = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatActionForever(animateAction)
        crab.runAction(repeatAction)
        //move the crab
        let crabAction = crab.getCrabMoveAction()
        crab.runAction(crabAction)
        return crab
        
    }
    
    func getCrabMoveAction() -> SKAction{
        let xDistance = self.endPosition!.x - self.startPosition!.x
        let yDistance = self.endPosition!.y - self.startPosition!.y
        var distance = sqrt(pow(xDistance, 2) + pow(yDistance, 2))
        let time = NSTimeInterval(distance / CGFloat(crabSpeed))
        let moveToAction = SKAction.moveTo(self.endPosition!, duration: time)
        let moveFromAction = SKAction.moveTo(self.startPosition!, duration: time)
        let sequence = SKAction.sequence([moveToAction, moveFromAction])
        let repeatAction = SKAction.repeatActionForever(sequence)
        return repeatAction
    }
    
    func getRotationRadians() -> CGFloat{
        
        return 0
    }
}