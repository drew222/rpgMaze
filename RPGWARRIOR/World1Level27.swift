//
//  World1Level27.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/7/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class World1Level27: SKScene, SKPhysicsContactDelegate {
    
    var timeSinceCrabAdded : NSTimeInterval = 0
    var addCrabTimeInterval : NSTimeInterval = 1.25
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastFireball: Double = 0.0
    var levelOver = false
    let levelName = "world1level27"
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
        //crabs
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 290, 100), endPosition: CGPointMake(self.frame.minX + 240, 150)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 190, 200), endPosition: CGPointMake(self.frame.minX + 140, 150)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 190, 300), endPosition: CGPointMake(self.frame.minX + 240, 250)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 290, 200), endPosition: CGPointMake(self.frame.minX + 340, 150)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 90, 200), endPosition: CGPointMake(self.frame.minX + 140, 250)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX - 10, 100), endPosition: CGPointMake(self.frame.minX + 40, 150)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 215, 375), endPosition: CGPointMake(self.frame.minX + 290, 300)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 165, 375), endPosition: CGPointMake(self.frame.minX + 90, 300)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX - 10, 200), endPosition: CGPointMake(self.frame.minX + 40, 250)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 340, 450), endPosition: CGPointMake(self.frame.minX + 290, 500)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 40, 450), endPosition: CGPointMake(self.frame.minX + 90, 500)))
        
        
        
        //shells i = y, k = x
        
        //row 1
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 40, 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 140, 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 240, 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 340, 100)))
       
        //row 2
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 90, 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 190, 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 290, 150)))
        
        //row 3
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 40, 200)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 140, 200)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 240, 200)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 340, 200)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 440, 200)))
        
        //row 4
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 90, 250)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 190, 250)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 290, 250)))
        
        //row 5
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 40, 300)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 140, 300)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 240, 300)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 340, 300)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 440, 300)))
        
        //row 6
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 90, 350)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 190, 350)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 290, 350)))
        
        //row 7
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 40, 400)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 140, 400)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 240, 400)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 340, 400)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 440, 400)))
        
        //row 8
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 90, 450)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 190, 450)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 290, 450)))
        
        //row 9
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 40, 500)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 140, 500)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 240, 500)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 340, 500)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 440, 500)))
        
        //row 10
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 90, 550)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 190, 550)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 290, 550)))
        
        //misc shells
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 265, 175)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 115, 175)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 165, 525)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 215, 525)))
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let aHero = self.childNodeWithName("hero") as! HeroClass
        let aBomber = self.childNodeWithName("bomber") as! BomberClass
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
            aHero.moveHelper((touch as! UITouch).locationInNode(self))
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
        
        self.timeSinceCrabAdded = self.timeSinceCrabAdded + currentTime - self.lastUpdatesTime
        
        
        if (self.timeSinceCrabAdded > self.addCrabTimeInterval && !self.levelOver) {
            self.addChild(MiniCrab.crabDash(CGPointMake(self.frame.minX + 390, 300), endPosition: CGPointMake(self.frame.minX - 10, 700)))
            self.addChild(MiniCrab.crabDash(CGPointMake(self.frame.minX - 10, 300), endPosition: CGPointMake(self.frame.minX + 390, 700)))
            
            
            
            
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
                self.view?.presentScene(self.userData?.objectForKey("menu") as! MainMenuScene, transition: skTransition)
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil){
                if theBomber!.isDead{
                    dropLoot("world1level27", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
                    droppedItem = true
                }
            }
        }
    }
}
