//
//  HeroClass.swift
//  TestRpgGame
//
//  Created by Drew Zoellner on 1/26/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit


class HeroClass: SKSpriteNode {
    var currentAngle: CGFloat?
    var life: Double?
    var isAttacking = false
    let nodeSpeed = 125
    
    class func makeHero(position: CGPoint) -> HeroClass{
        let hero = HeroClass(imageNamed: "walkman4.png")
        hero.position = position
        hero.anchorPoint = CGPointMake(0.5, 0.5)
        hero.name = "hero"
        hero.currentAngle = pi / 2.0
        hero.setupPhysicsBody()
        hero.life = 3.0
        hero.zPosition = 1
        return hero
    }
    
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.dynamic = true
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
        self.physicsBody?.collisionBitMask = 0 //CollisionBitMasks.collisionCategoryWizard.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryProjectile.rawValue
    }
    
    func moveHelper(position: CGPoint) -> Void{
        if let aWizard = self.parent!.childNodeWithName("wizard") as? WizardClass{
        var myPos = position
        //clicked on wizard node, move infront of instead of to the position
            //check if any point generated is in the wizard
            let manyPoints = generatePointsOnLine(self.position, position)
            for onePoint in manyPoints{
                if (aWizard.containsPoint(onePoint) && !aWizard.containsPoint(position)){
                    self.runAction(getAroundMove(self, position, aWizard), withKey: "runAction")
                    return
                }
            }
            if (aWizard.containsPoint(position)){
                moveTo(self, self.position, infrontOf(aWizard, self.position))
                self.runAction(getAttackMove(self, aWizard, self.isAttacking), withKey: "runAction")
                return
            }
        //self.moveTo(position, clickedEnemy: false, goingAround: false)
        self.runAction(getSimpleMove(self, position), withKey: "runAction")
        return
        }else if let aBomber = self.parent!.childNodeWithName("bomber") as? BomberClass{
            var myPos = position
            //clicked on wizard node, move infront of instead of to the position
            //check if any point generated is in the wizard
            let manyPoints = generatePointsOnLine(self.position, position)
            for onePoint in manyPoints{
                if (aBomber.containsPoint(onePoint) && !aBomber.containsPoint(position)){
                    self.runAction(getAroundMove(self, position, aBomber), withKey: "runAction")
                    return
                }
            }
            if (aBomber.containsPoint(position)){
                moveTo(self, self.position, infrontOf(aBomber, self.position))
                self.runAction(getAttackMove(self, aBomber, self.isAttacking), withKey: "runAction")
                return
            }
            //self.moveTo(position, clickedEnemy: false, goingAround: false)
            self.runAction(getSimpleMove(self, position), withKey: "runAction")
            return
        }
    }
    
    
    //push point out from a node, based on heros shoulder
    func pushPointOut(theNode: SKSpriteNode, corner: CGPoint) -> CGPoint{
        let pushDistance = self.frame.maxX - self.frame.midX - 8
        //check Right
        if (corner.x > theNode.position.x){
            //checkTop
            if(corner.y > theNode.position.y){
                return CGPointMake(corner.x + pushDistance, corner.y + pushDistance)
            }else{
                return CGPointMake(corner.x + pushDistance, corner.y - pushDistance)
            }
        //is left then
        }else{
            if(corner.y > theNode.position.y){
                return CGPointMake(corner.x - pushDistance, corner.y + pushDistance)
            }else{
                return CGPointMake(corner.x - pushDistance, corner.y - pushDistance)
            }
        }
    }
    
    func getStillTextures()-> SKTexture{
        return SKTexture(imageNamed: "walkman4.png")
    }
    
    
    func getMoveTextures()-> [SKTexture]{
        return [SKTexture(imageNamed: "walkman2.png"),
            SKTexture(imageNamed: "walkman3.png"),
            SKTexture(imageNamed: "walkman4.png"),
            SKTexture(imageNamed: "walkman5.png"),
            SKTexture(imageNamed: "walkman6.png"),
            SKTexture(imageNamed: "walkman1.png")]
    }
    /*
    func moveTo(position: CGPoint, clickedEnemy: Bool, goingAround: Bool) -> Bool{
        let aWizard = self.parent!.childNodeWithName("wizard") as WizardClass
        //if clicked on the wizard, change position to infront of him
        //create the running animation, called repeatAction
        let textures = [SKTexture(imageNamed: "walkman2.png"),
        SKTexture(imageNamed: "walkman3.png"),
        SKTexture(imageNamed: "walkman4.png"),
        SKTexture(imageNamed: "walkman5.png"),
        SKTexture(imageNamed: "walkman6.png"),
        SKTexture(imageNamed: "walkman1.png")]
        let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatActionForever(animation)
        //create moveTo action
        let xDistance = position.x - self.position.x
        let yDistance = position.y - self.position.y
        var distance = sqrt(pow(xDistance, 2) + pow(yDistance, 2))
        //if distanceBetween(position, self.position) < 5{
        //    return false
        //}
        if distance < 5 && !aWizard.containsPoint(position){
            return false
        }
        let time = NSTimeInterval(distance / CGFloat(nodeSpeed))
        let moveHero = SKAction.moveTo(position, duration: time)
        //create rotate action
        var angle: CGFloat
        if aWizard.containsPoint(position){
            angle = angleFromPoints(self.position, aWizard.position)
        }else{
            angle = angleFromPoints(self.position, position)
        }
        var amountToTurn = CGFloat(angle) - currentAngle!
        if (amountToTurn > pi){
            amountToTurn = amountToTurn - (2 * pi)
        }else if(amountToTurn * -1 > pi){
            amountToTurn = amountToTurn + (2 * pi)
        }
        self.currentAngle = CGFloat(angle)
        let rotateAction = SKAction.rotateByAngle(CGFloat(amountToTurn), duration: 0.2)
        //start new running animation if not already running
        if (self.hasActions() == false){
            self.runAction(repeatAction, withKey: "repeatAction")
        }
        if (angle > -1){
            self.runAction(rotateAction)
        }
        //after finished running, stop running animation and goto standstill
        var completionBlock: SKAction?
        var clickedWiz = false
        if (clickedEnemy){
            clickedWiz = true
            completionBlock = SKAction.runBlock(
                {self.removeActionForKey("repeatAction")
                    self.texture = SKTexture(imageNamed: "walkman4.png")
                    self.attack()
                    self.isAttacking = true
            })
            
        }else{
            self.isAttacking = false
            completionBlock = SKAction.runBlock(
                {self.removeActionForKey("repeatAction")
                self.texture = SKTexture(imageNamed: "walkman4.png")
            })
        }
        //if still attacking, dont moveHero, just run completion block to stand still (attacking animation in future)
        var sequence: SKAction?
        if(clickedEnemy && self.isAttacking){
            sequence = SKAction.sequence([completionBlock!])
        }else{
            sequence = SKAction.sequence([moveHero, completionBlock!])
        }
        self.runAction(sequence!, withKey: "runAction")
        return true
    }
*/
    
    
    
    func takeDamage(damage: Double) -> Bool{
        self.life! -= damage
        if (self.life! <= 0){
            println("THE HERO HAS DIED!")
            return true
        }else{
            return false
        }
    }
    
    func attack(){
        
        if let theWizard = self.parent!.childNodeWithName("wizard") as? WizardClass{
            theWizard.isDead = true
            println("THE WIZARD HAS DIED!")
        }else if let theBomber = self.parent!.childNodeWithName("bomber") as? BomberClass{
            theBomber.isDead = true
            println("THE BOMBER HAS DIED!")
        }
    }
}