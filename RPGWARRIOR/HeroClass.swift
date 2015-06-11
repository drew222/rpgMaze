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
    let baseSpeed: CGFloat = 120
    var isSlowed = false
    var movingToPoint = CGPointMake(0, 0)
    var isMoving = false
    var regeneration: CGFloat?
    //let nodeSpeed = 125
    
    class func makeHero(position: CGPoint) -> HeroClass{
        let hero = HeroClass(imageNamed: "Kraken_Movement_5.png")
        hero.position = position
        hero.anchorPoint = CGPointMake(0.5, 0.5)
        hero.name = "hero"
        hero.currentAngle = pi / 2.0
        hero.setupPhysicsBody()
        hero.life = 1.0
        hero.regeneration = 0
        hero.zPosition = 4
        hero.setScale(0.6)
        hero.damage = 1
        return hero
    }
    
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width * 0.80, self.frame.height * 0.80))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.dynamic = true
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
        self.physicsBody?.collisionBitMask = 0 //CollisionBitMasks.collisionCategoryWizard.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryProjectile.rawValue | CollisionBitMasks.collisionCategoryBlizzard.rawValue
    }
 
    
    func interactableNode(node: SKSpriteNode) -> Bool{
        if node.name != nil{
            if node.name! == "bomb" || node.name! == "Fireball" || node.name! == "krill" || node.name! == "Mine" || node.name! == "hero" || node.name! == "spike" || node.name! == "crab" || node.name! == "tentacle" || node.name! == "safeSpot1" || node.name! == "safeSpot2" || node.name! == "wave" || node.name! == "buff" || node.name! == "phaseText" || node.name! == "coin" || node.name! == "infText"{
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
        isMoving = true
        var clickedNode = false
        var theClickedNode: SKSpriteNode?
        if self.parent == nil {
            return
        }
        for node in self.parent!.children{
            if node is SKSpriteNode && node.containsPoint(position) && node.zPosition > -1 && node.position != self.position && interactableNode(node as! SKSpriteNode){
                clickedNode = true
                theClickedNode = node as? SKSpriteNode
            }
        }
        //check if there is something hit first, move around this item
        let manyPoints = generatePointsOnLine(self.position, position)
        for onePoint in manyPoints{
            for node in self.parent!.children{
                if (node is SKSpriteNode && node.containsPoint(onePoint) && !node.containsPoint(position) && node.zPosition > -1) && interactableNode(node as! SKSpriteNode){
                    self.runAction(getAroundMove(self, position, node as! SKSpriteNode), withKey: "runAction")
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
            theInventory.addItem(theItem.itemName!)
        }
        theItem.removeFromParent()

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
        return SKTexture(imageNamed: "Kraken_Movement_5.png")
    }
    
    
    func getMoveTextures()-> [SKTexture]{
        return [SKTexture(imageNamed: "Kraken_Movement_4.png"),
            SKTexture(imageNamed: "Kraken_Movement_3.png"),
            SKTexture(imageNamed: "Kraken_Movement_2.png"),
            SKTexture(imageNamed: "Kraken_Movement_1.png"),
            SKTexture(imageNamed: "Kraken_Movement_2.png"),
            SKTexture(imageNamed: "Kraken_Movement_3.png"),
            SKTexture(imageNamed: "Kraken_Movement_4.png"),
            SKTexture(imageNamed: "Kraken_Movement_5.png"),
            SKTexture(imageNamed: "Kraken_Movement_11.png"),
            SKTexture(imageNamed: "Kraken_Movement_12.png"),
            SKTexture(imageNamed: "Kraken_Movement_13.png"),
            SKTexture(imageNamed: "Kraken_Movement_14.png"),
            SKTexture(imageNamed: "Kraken_Movement_15.png"),
            SKTexture(imageNamed: "Kraken_Movement_16.png"),
            SKTexture(imageNamed: "Kraken_Movement_6.png"),
            SKTexture(imageNamed: "Kraken_Movement_7.png"),
            SKTexture(imageNamed: "Kraken_Movement_8.png"),
            SKTexture(imageNamed: "Kraken_Movement_9.png"),
            SKTexture(imageNamed: "Kraken_Movement_10.png"),
            SKTexture(imageNamed: "Kraken_Movement_9.png"),
            SKTexture(imageNamed: "Kraken_Movement_8.png"),
            SKTexture(imageNamed: "Kraken_Movement_7.png"),
            SKTexture(imageNamed: "Kraken_Movement_6.png"),
            SKTexture(imageNamed: "Kraken_Movement_16.png"),
            SKTexture(imageNamed: "Kraken_Movement_15.png"),
            SKTexture(imageNamed: "Kraken_Movement_14.png"),
            SKTexture(imageNamed: "Kraken_Movement_13.png"),
            SKTexture(imageNamed: "Kraken_Movement_12.png"),
            SKTexture(imageNamed: "Kraken_Movement_11.png"),
            SKTexture(imageNamed: "Kraken_Movement_5.png")]
    }
    
    func takeDamage(damage: CGFloat) -> Bool{
        //animate damage stuff
        let codeBlock0 = SKAction.runBlock({
            var textures: [SKTexture] = []
            textures.append(SKTexture(imageNamed:"Kraken_Gets_Hurt_1"))
            let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
            let repeatAction0 = SKAction.repeatActionForever(animation)
            self.runAction(repeatAction0, withKey: "repeatAction")
        })
        let codeBlock = SKAction.runBlock({
            var textures: [SKTexture] = []
            if (self.isMoving){
                for var i = 1; i <= 10; i=i+1{
                    textures.append(SKTexture(imageNamed:"Kraken_Movement_\(i)"))
                }
            }else{
                textures.append(SKTexture(imageNamed:"Kraken_Movement_1"))
            }
            let animation2 = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
            let repeatAction = SKAction.repeatActionForever(animation2)
            self.runAction(repeatAction , withKey: "repeatAction")
        })
        let sequence = SKAction.sequence([codeBlock0, SKAction.waitForDuration(0.1), codeBlock])
        self.runAction(sequence)
        //damage
        self.life! -= damage
        if (self.life! <= 0){
            self.life! = 0
            return true
        }else{
            return false
        }
    }
    
    func updateStats(){
        heroSpeed = 120
        self.damage = CGFloat(baseDamage)
        self.life = CGFloat(baseLife)
        heroSpeed = CGFloat(baseSpeed)
        if let theInventory = self.parent!.userData?.objectForKey("inventory") as? Inventory{
            //check that its holding a weapon
            if let weaponSpot = theInventory.childNodeWithName("weapon") as? ItemSpaceNode{
            if (weaponSpot.item != nil){
                for stat in weaponSpot.item!.itemStats!{
                    if stat.0 == "Life"{
                        self.life! += stat.1
                    }else if stat.0 == "Movement"{
                        heroSpeed += stat.1
                    }else if stat.0 == "Regeneration"{
                        self.regeneration! += stat.1
                    }
                }
                }}
            if let bodySpot = theInventory.childNodeWithName("body") as? ItemSpaceNode{
            if (bodySpot.item != nil){
                for stat in bodySpot.item!.itemStats!{
                    if stat.0 == "Life"{
                        self.life! += stat.1
                    }else if stat.0 == "Movement"{
                        heroSpeed += stat.1
                    }else if stat.0 == "Regeneration"{
                        self.regeneration! += stat.1
                    }
                }
                }}
            if let feetSpot = theInventory.childNodeWithName("feet") as? ItemSpaceNode{
            if (feetSpot.item != nil){
                for stat in feetSpot.item!.itemStats!{
                    if stat.0 == "Movement"{
                        heroSpeed += stat.1
                    }else if stat.0 == "Life"{
                        self.life! += stat.1
                    }else if stat.0 == "Regeneration"{
                        self.regeneration! += stat.1
                    }
                }
                }}
            if let neckSpot = theInventory.childNodeWithName("neck") as? ItemSpaceNode{
                if (neckSpot.item != nil){
                    for stat in neckSpot.item!.itemStats!{
                        if stat.0 == "Regeneration"{
                            self.regeneration! += stat.1
                        }else if stat.0 == "Movement"{
                            heroSpeed += stat.1
                        }else if stat.0 == "Life"{
                            self.life! += stat.1
                        }
                    }
                }}
        }
    }
    
    func attack(){
        if let theWizard = self.parent!.childNodeWithName("wizard") as? WizardClass{
            if distanceBetween(self.position, theWizard.position) < 110{
                theWizard.takeDamage(1)
            }
            //println("THE WIZARD HAS DIED!")
        }else if let theBomber = self.parent!.childNodeWithName("bomber") as? BomberClass{
            if distanceBetween(self.position, theBomber.position) < 110{
                theBomber.takeDamage(1)
            }
            //println("THE BOMBER HAS DIED!")
        }else if let mineThrower = self.parent!.childNodeWithName("MineThrower") as? MineThrowerNode{
            if distanceBetween(self.position, mineThrower.position) < 110{
                mineThrower.takeDamage(1)
            }
        }else if let whaleBoss = self.parent!.childNodeWithName("whale") as? WhaleBoss{
            if distanceBetween(self.position, whaleBoss.position) < 110{
                whaleBoss.takeDamage(1)
            }
        }else if let krakenBoss = self.parent!.childNodeWithName("kraken") as? KrakenBoss{
            if distanceBetween(self.position, krakenBoss.position) < 110{
                krakenBoss.takeDamage(1)
            }
        }else if let treasureChest = self.parent!.childNodeWithName("chest") as? TreasureChest{
            if distanceBetween(self.position, treasureChest.position) < 110{
                treasureChest.openChest()
            }
        
        }
    }
}
