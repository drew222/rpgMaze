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
    var life: CGFloat?
    var isAttacking = false
    var damage: CGFloat?
    let baseDamage = 1
    let baseLife = 1
    let baseSpeed: CGFloat = 150
    var isSlowed = false
    var movingToPoint = CGPointMake(0, 0)
    //let nodeSpeed = 125
    
    class func makeHero(position: CGPoint) -> HeroClass{
        let hero = HeroClass(imageNamed: "walkman4.png")
        hero.position = position
        hero.anchorPoint = CGPointMake(0.5, 0.5)
        hero.name = "hero"
        hero.currentAngle = pi / 2.0
        hero.setupPhysicsBody()
        hero.life = 3.0
        hero.zPosition = 1
        hero.damage = 1
        return hero
    }
    
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.dynamic = true
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
        self.physicsBody?.collisionBitMask = 0 //CollisionBitMasks.collisionCategoryWizard.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryProjectile.rawValue | CollisionBitMasks.collisionCategoryBlizzard.rawValue
    }
 
    
    /*
    func oldmoveHelper(position: CGPoint) -> Void{
        if let item = self.parent!.childNodeWithName("item") as? ItemClass{
            var myPos = position
            //clicked on wizard node, move infront of instead of to the position
            //check if any point generated is in the wizard
            let manyPoints = generatePointsOnLine(self.position, position)
            for onePoint in manyPoints{
                if (item.containsPoint(onePoint) && !item.containsPoint(position)){
                    self.runAction(getAroundMove(self, position, item), withKey: "runAction")
                    return
                }
            }
            if (item.containsPoint(position)){
                moveTo(self, self.position, infrontOf(item, self.position))
                self.runAction(getAttackMove(self, item, self.isAttacking), withKey: "runAction")
                return
            }
            //self.moveTo(position, clickedEnemy: false, goingAround: false)
            self.runAction(getSimpleMove(self, position), withKey: "runAction")
            
        }else if let aWizard = self.parent!.childNodeWithName("wizard") as? WizardClass{
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
                //moveTo(self, self.position, infrontOf(aWizard, self.position))
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
                //moveTo(self, self.position, infrontOf(aBomber, self.position))
                self.runAction(getAttackMove(self, aBomber, self.isAttacking), withKey: "runAction")
                return
            }
            //self.moveTo(position, clickedEnemy: false, goingAround: false)
            self.runAction(getSimpleMove(self, position), withKey: "runAction")
            return

        }else if let mineThrower = self.parent!.childNodeWithName("MineThrower") as? MineThrowerNode{
            var myPos = position
            //clicked on wizard node, move infront of instead of to the position
            //check if any point generated is in the wizard
            let manyPoints = generatePointsOnLine(self.position, position)
            for onePoint in manyPoints{
                if (mineThrower.containsPoint(onePoint) && !mineThrower.containsPoint(position)){
                    self.runAction(getAroundMove(self, position, mineThrower), withKey: "runAction")
                    return
                }
            }
            if (mineThrower.containsPoint(position)){
                //moveTo(self, self.position, infrontOf(aBomber, self.position))
                self.runAction(getAttackMove(self, mineThrower, self.isAttacking), withKey: "runAction")
                return
            }
            //self.moveTo(position, clickedEnemy: false, goingAround: false)
            self.runAction(getSimpleMove(self, position), withKey: "runAction")
            return
        }else if let block = self.parent!.childNodeWithName("block") as? Block{
            var myPos = position
            //clicked on wizard node, move infront of instead of to the position
            //check if any point generated is in the wizard
            let manyPoints = generatePointsOnLine(self.position, position)
            for onePoint in manyPoints{
                if (block.containsPoint(onePoint) && !block.containsPoint(position)){
                    self.runAction(getAroundMove(self, position, block), withKey: "runAction")
                    return
                }
            }
            if (block.containsPoint(position)){
                moveTo(self, self.position, infrontOf(block, self.position))
                self.runAction(getAttackMove(self, block, self.isAttacking), withKey: "runAction")
                return
            }
            //self.moveTo(position, clickedEnemy: false, goingAround: false)
            self.runAction(getSimpleMove(self, position), withKey: "runAction")
        }
    }

*/
    
    func interactableNode(node: SKSpriteNode) -> Bool{
        if node.name? != nil{
            if node.name! == "bomb" || node.name! == "Fireball" || node.name! == "Mine" || node.name! == "hero"{
                return false
            }else{
                return true
            }
        }
        return true
    }
    
    func changeSpeed(change: CGFloat){
        heroSpeed += change
        if self.actionForKey("runAction") != nil{
            moveHelper(movingToPoint)
        }
    }
    
    func moveHelper(position: CGPoint) -> Void{
        //check all nodes to see if the point is within the node and set boolean
        movingToPoint = position
        var clickedNode = false
        var theClickedNode: SKSpriteNode?
        for node in self.parent!.children{
            if node is SKSpriteNode && node.containsPoint(position) && node.zPosition? > -1 && node.position? != self.position && interactableNode(node as SKSpriteNode){
                clickedNode = true
                theClickedNode = node as? SKSpriteNode
            }
        }
        //check if there is something hit first, move around this item
        let manyPoints = generatePointsOnLine(self.position, position)
        for onePoint in manyPoints{
            for node in self.parent!.children{
                if (node is SKSpriteNode && node.containsPoint(onePoint) && !node.containsPoint(position) && node.zPosition > -1) && interactableNode(node as SKSpriteNode){
                    self.runAction(getAroundMove(self, position, node as SKSpriteNode), withKey: "runAction")
                    return
                }
            }
        }
        //attack move if bool is set
        if clickedNode{
            self.runAction(getAttackMove(self, theClickedNode!, self.isAttacking), withKey: "runAction")
            return
        }
        //do simple move
        self.runAction(getSimpleMove(self, position), withKey: "runAction")
    }



    
    func pickupItem(theItem: ItemClass){
        if let theInventory = self.parent!.userData?.objectForKey("inventory") as? Inventory{
            println("about to pic it up!!!")
            theInventory.addItem(theItem.itemName!)
        }
        theItem.removeFromParent()

    }





    func pickupItem(){
        let theItem = self.parent?.childNodeWithName("item") as ItemClass
        println("picking up item!\(theItem.texture)")

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
    
    func takeDamage(damage: CGFloat) -> Bool{
        self.life! -= damage
        if (self.life! <= 0){
            println("THE HERO HAS DIED!")
            return true
        }else{
            return false
        }
    }
    
    func updateStats(){
        heroSpeed = 150
        self.damage = CGFloat(baseDamage)
        self.life = CGFloat(baseLife)
        heroSpeed = CGFloat(baseSpeed)
        if let theInventory = self.parent!.userData?.objectForKey("inventory") as? Inventory{
            //check that its holding a weapon
            if let weaponSpot = theInventory.childNodeWithName("weapon") as? ItemSpaceNode{
            if (theInventory.weapon != nil){
                for stat in theInventory.weapon!.itemStats!{
                    if stat.0 == "Damage"{
                        self.damage! += stat.1
                    }
                }
                }}
            if let bodySpot = theInventory.childNodeWithName("body") as? ItemSpaceNode{
            if (theInventory.body != nil){
                for stat in theInventory.body!.itemStats!{
                    if stat.0 == "Life"{
                        self.life! += stat.1
                    }
                }
                }}
            if let feetSpot = theInventory.childNodeWithName("feet") as? ItemSpaceNode{
            if (theInventory.feet != nil){
                for stat in theInventory.feet!.itemStats!{
                    if stat.0 == "Movement"{
                        heroSpeed += stat.1
                    }
                }
                }}
        }
    }
    
    func attack(){
        if let theWizard = self.parent!.childNodeWithName("wizard") as? WizardClass{
            if distanceBetween(self.position, theWizard.position) < 30{
                theWizard.takeDamage(self.damage!)
            }
            //println("THE WIZARD HAS DIED!")
        }else if let theBomber = self.parent!.childNodeWithName("bomber") as? BomberClass{
            if distanceBetween(self.position, theBomber.position) < 30{
                theBomber.takeDamage(self.damage!)
            }
            //println("THE BOMBER HAS DIED!")
        }else if let mineThrower = self.parent!.childNodeWithName("MineThrower") as? MineThrowerNode{
            if distanceBetween(self.position, mineThrower.position) < 30{
                mineThrower.takeDamage(self.damage!)
            }
        }
    }
}
