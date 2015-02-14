//
//  Level2Scene.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 2/8/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class Level2Scene: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastBomb: Double = 0.0
    var levelOver = false
    let levelName = "level2"
    var droppedItem = false
    
    let bomberAttackSpeed = 1.0
    
    var theBomber: BomberClass?
    var theHero: HeroClass?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, self.frame.maxY * 0.1))
        theHero!.setScale(0.6)
        self.addChild(theHero!)
        theBomber = BomberClass.makeBomber(CGPointMake(self.frame.maxX * 0.25, self.frame.maxY * 0.75))
        theBomber!.setScale(0.3)
        self.addChild(theBomber!)
        //the below constraints did nothing
        //let distanceConstraint = SKConstraint.distance(SKRange(lowerLimit: 10), toNode: aWizard)
        //ourHero.constraints = [distanceConstraint]
        let background = SKSpriteNode(imageNamed: "valgrind_desert_forest1.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.physicsWorld.contactDelegate = self
        self.addChild(background)
        theHero!.updateStats()
        
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
        //HERO VS FIRE
       // if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
         //   secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryProjectile.rawValue){
         //       let aHero = self.childNodeWithName("hero") as HeroClass
          //      aHero.takeDamage(1)
        //}
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
        for touch in touches{
            aHero.moveHelper(touch.locationInNode(self))
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //println("current time: \(currentTime)")
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.lastUpdatesTime = currentTime
            self.lastBomb = currentTime
        }
        self.totalGameTime += currentTime - self.lastUpdatesTime
        if currentTime - lastBomb  > bomberAttackSpeed{
            self.lastBomb = currentTime
            theBomber!.throwBomb()
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
                    dropLoot("level2", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
                    droppedItem = true
                }
            }
        }
    }
}