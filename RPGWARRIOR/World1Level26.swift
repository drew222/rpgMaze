//
//  World1Level26.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/6/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class World1Level26: SKScene, SKPhysicsContactDelegate {
    
    var timeSinceCrabAdded : NSTimeInterval = 0
    var addCrabTimeInterval : NSTimeInterval = 0.35
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastFireball: Double = 0.0
    var levelOver = false
    let levelName = "world1level26"
    var droppedItem = false
    
    let wizardAttackSpeed = 1.0
    
    var theBomber: BomberClass?
    var theHero: HeroClass?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, 30))
        theHero!.setScale(0.6)
        self.addChild(theHero!)
        theBomber = BomberClass.makeBomber(CGPointMake(self.frame.midX, self.frame.maxY - 50))
        self.addChild(theBomber!)
        //the below constraints did nothing
        //let distanceConstraint = SKConstraint.distance(SKRange(lowerLimit: 10), toNode: aWizard)
        //ourHero.constraints = [distanceConstraint]
        let background = SKSpriteNode(imageNamed: "Beach_Background_1.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.physicsWorld.contactDelegate = self
        self.addChild(background)
        theHero!.updateStats()
        
        //patrol crabs
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 30, self.frame.minY - 1000), endPosition: CGPointMake(self.frame.minX + 30, self.frame.maxY + 1000)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.maxX - 30, self.frame.minY - 1000), endPosition: CGPointMake(self.frame.maxX - 30, self.frame.maxY + 1000)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 30, self.frame.minY - 2000), endPosition: CGPointMake(self.frame.minX + 30, self.frame.maxY + 2000)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.maxX - 30, self.frame.minY - 2000), endPosition: CGPointMake(self.frame.maxX - 30, self.frame.maxY + 2000)))
        
        
        //seashells
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 20, 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 50, 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 20, 130)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 50, 130)))
        
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 20, 200)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 50, 200)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 20, 230)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 50, 230)))
        
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 20, 300)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 50, 300)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 20, 330)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 50, 330)))
        
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 20, 400)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 50, 400)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 20, 430)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 50, 430)))
        
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 20, 500)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 50, 500)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 20, 530)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 50, 530)))
        
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 20, 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 50, 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 20, 130)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 50, 130)))
        
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 20, 200)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 50, 200)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 20, 230)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 50, 230)))
        
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 20, 300)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 50, 300)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 20, 330)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 50, 330)))
        
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 20, 400)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 50, 400)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 20, 430)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 50, 430)))
        
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 20, 500)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 50, 500)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 20, 530)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 50, 530)))
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody!
        var secondBody: SKPhysicsBody!
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        //HERO VS SEASHELL
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryMiniCrab.rawValue){
                let mine = secondBody.node as? MiniCrab
                mine!.explode(secondBody.node!.position)//(theHero!.position)//secondBody.node!.position)
        }else  if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategorySeashell.rawValue){
                let mine = secondBody.node as? MineNode
                mine!.explode(secondBody.node!.position)//(theHero!.position)//secondBody.node!.position)
        }
        //HERO VS WIZARD
        //else if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
        //secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryWizard.rawValue){
        //let aHero = self.childNodeWithName("hero") as HeroClass
        //aHero.attack()
        //}
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let aHero = self.childNodeWithName("hero") as HeroClass
        let aBomber = self.childNodeWithName("bomber") as BomberClass
        for touch in touches{
            //stop when mouse comes in contact hero
            //let theSpot = spotToStop(aHero, touch.locationInNode(self))
            //if theSpot != aHero.position{
            //aHero.moveTo(theSpot)
            // if (aWizard.containsPoint(touch.locationInNode(self))){
            //  if (distanceBetween(aWizard.position, aHero.position) < 10){
            //      aHero.attack()
            //  }
            //}
            aHero.moveHelper(touch.locationInNode(self))
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.lastUpdatesTime = currentTime
            self.lastFireball = currentTime
        }
        self.totalGameTime += currentTime - self.lastUpdatesTime
        
        //CRAB STAMPEDE
        
        var xMatch = CGFloat(randomWithMin(Int(self.frame.minX + 80), Int(self.frame.maxX - 80)))
        self.timeSinceCrabAdded = self.timeSinceCrabAdded + currentTime - self.lastUpdatesTime
    
        
        if (self.timeSinceCrabAdded > self.addCrabTimeInterval && !self.levelOver) {
            self.addChild(MiniCrab.crabDash(CGPointMake(xMatch, self.frame.maxY + 30), endPosition: CGPointMake(xMatch, self.frame.minY)))
            
            
            self.timeSinceCrabAdded = 0
        }

        
        self.lastUpdatesTime = currentTime
        
        //check for win condition
        if (theBomber!.isDead || theHero!.life <= 0) && !levelOver{
            //parent of self is viewcontroller, has view, extends sknode
            //if (theHero!.life == 0){
            //   let deathNode = SKLabelNode.init(text: "You died, try again!")
            //   deathNode.position = CGPointMake(self.frame.midX, self.frame.midY)
            //   self.addChild(deathNode)
            // }else if (theBomber!.isDead){
            //   let winNode = SKLabelNode.init(text: "You win, congratulations!")
            //   winNode.position = CGPointMake(self.frame.midX, self.frame.midY)
            //   self.addChild(winNode)
            // }
            if (self.childNodeWithName("item") == nil && droppedItem) || theHero!.life <= 0{
                //let menuScene = MainMenuScene(size: self.frame.size)
                //println("got here111")
                //(self.userData?.objectForKey("menu") as MainMenuScene).userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                //println("got here222")
                //menuScene.userData?.setValue(self.userData?.objectForKey("inventory"), forKey: "inventory")
                let skTransition = SKTransition.fadeWithDuration(5.0)
                //let gameScene = self.userData?.objectForKey("menu") as MainMenuScene
                self.view?.presentScene(self.userData?.objectForKey("menu") as MainMenuScene, transition: skTransition)
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil){
                if theBomber!.isDead{
                    dropLoot("world1level26", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
                    droppedItem = true
                }
            }
        }
    }
}
