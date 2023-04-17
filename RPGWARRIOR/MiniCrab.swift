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
    var crabSpeed = 150
    
    
    class func crabAtPosition(startPos: CGPoint, endPosition: CGPoint) -> MiniCrab{
        let crab = MiniCrab(imageNamed: "Beach_Crab_1")
        crab.position = startPos
        crab.startPosition = startPos
        crab.name = "crab"
        crab.endPosition = endPosition
        crab.setScale(0.07)
        //rotate
        var angle = angleFromPoints(point1: startPos, point2: endPosition)
        //println(angle)
        //if angle > pi + pi / 2{
          //  angle += pi
        //}
        if angle != -1 {
            //angle = angle - pi
            if angle < 3.14 {
                angle = angle + pi
            }
            if angle > pi + pi / 2{
                angle += pi
            }
            crab.run(SKAction.rotate(toAngle: angle - pi, duration: 0))
        }
        //animate all textures
        let textures: [SKTexture] = [SKTexture(imageNamed: "Beach_Crab_1"), SKTexture(imageNamed: "Beach_Crab_2"), SKTexture(imageNamed: "Beach_Crab_3"), SKTexture(imageNamed: "Beach_Crab_2")]
        let animateAction = SKAction.animate(with: textures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatForever(animateAction)
        crab.run(repeatAction)
        //move the crab
        let crabAction = crab.getCrabMoveAction()
        crab.setupPhysicsBody()
        crab.run(crabAction)
        return crab
        
    }
    
    //crab runs to location then gets removed
    class func crabDash(startPos: CGPoint, endPosition: CGPoint) -> MiniCrab{
        let crab = MiniCrab(imageNamed: "Beach_Crab_1")
        crab.position = startPos
        crab.startPosition = startPos
        crab.name = "crab"
        crab.endPosition = endPosition
        crab.setScale(0.07)
        //rotate
        var angle = angleFromPoints(point1: startPos, point2: endPosition)
        //println(angle)
        //if angle > pi + pi / 2{
        //  angle += pi
        //}
        if angle != -1 {
            //angle = angle - pi
            if angle < 3.14 {
                angle = angle + pi
            }
            if angle > pi + pi / 2{
                angle += pi
            }
            crab.run(SKAction.rotate(toAngle: angle - pi, duration: 0))
        }
        //animate all textures
        let textures: [SKTexture] = [SKTexture(imageNamed: "Beach_Crab_1"), SKTexture(imageNamed: "Beach_Crab_2"), SKTexture(imageNamed: "Beach_Crab_3"), SKTexture(imageNamed: "Beach_Crab_2")]
        let animateAction = SKAction.animate(with: textures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatForever(animateAction)
        crab.run(repeatAction)
        //move the crab
        let crabAction = crab.getCrabDashAction()
        crab.setupPhysicsBody()
        crab.run(crabAction)
        return crab
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryMiniCrab.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
    func explode(position: CGPoint){
        //var liteAttack: SKEmitterNode?
        let explodeCode = SKAction.run({//let litePath = NSBundle.mainBundle().pathForResource("LightParticle", ofType: "sks")
            //liteAttack = (NSKeyedUnarchiver.unarchiveObjectWithFile(litePath!) as SKEmitterNode)
            //liteAttack!.position = position
            //liteAttack!.setScale(0.5)
            //if (self.parent! as? SKScene != nil){
            //self.parent!.addChild(liteAttack!)
            //}
            //let textures: [SKTexture] = [SKTexture(imageNamed:"Seashell_3"), SKTexture(imageNamed:"Seashell_2"), SKTexture(imageNamed:"Seashell_1")]
            //let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
            //let repeat = SKAction.repeatAction(animation, count: 1)
            //self.runAction(repeat)
            //self.removeActionForKey("fire")
            //self.texture = nil
        })
        
        let removeBlock = SKAction.run({//liteAttack!.removeFromParent()
            self.removeFromParent()})
        let damageBlock = SKAction.run({
            _ = distanceBetween(point1: self.parent!.childNode(withName: "hero")!.position, point2: self.position)
            //if distanceFromMine < 25{
            let theHero = self.parent!.childNode(withName: "hero")! as! HeroClass
            //println("distance from bomb = \(distanceFromMine)")
            theHero.takeDamage(damage: 1.0)
            //}
        })
        let sequence = SKAction.sequence([explodeCode, damageBlock, SKAction.wait(forDuration: 0.3), removeBlock])
        self.run(sequence)}
    
    func getCrabMoveAction() -> SKAction{
        let xDistance = self.endPosition!.x - self.startPosition!.x
        let yDistance = self.endPosition!.y - self.startPosition!.y
        let distance = sqrt(pow(xDistance, 2) + pow(yDistance, 2))
        let time = TimeInterval(distance / CGFloat(crabSpeed))
        let moveToAction = SKAction.move(to: self.endPosition!, duration: time)
        let moveFromAction = SKAction.move(to: self.startPosition!, duration: time)
        let sequence = SKAction.sequence([moveToAction, moveFromAction])
        let repeatAction = SKAction.repeatForever(sequence)
        return repeatAction
    }
    //crab runs to location then gets removed
    func getCrabDashAction() -> SKAction{
        let xDistance = self.endPosition!.x - self.startPosition!.x
        let yDistance = self.endPosition!.y - self.startPosition!.y
        let distance = sqrt(pow(xDistance, 2) + pow(yDistance, 2))
        let time = TimeInterval(distance / CGFloat(crabSpeed))
        let moveToAction = SKAction.move(to: self.endPosition!, duration: time)
        let removeAction = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveToAction, removeAction])
        return sequence
    }
    
}
