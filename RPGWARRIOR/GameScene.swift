//
//  GameScene.swift
//  TestRpgGame
//
//  Created by Drew Zoellner on 1/26/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastFireball: Double = 0.0
    var levelOver = false
    let levelName = "level1"
    var droppedLoot = false
    
    let wizardAttackSpeed = 1.0
    
    var theWizard: WizardClass?
    var theHero: HeroClass?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, self.frame.maxY * 0.1))
        theHero!.setScale(0.6)
        self.addChild(theHero!)
        theWizard = WizardClass.makeWizard(CGPointMake(self.frame.maxX * 0.25, self.frame.maxY * 0.75))
        theWizard!.setScale(0.3)
        self.addChild(theWizard!)
        //the below constraints did nothing
        //let distanceConstraint = SKConstraint.distance(SKRange(lowerLimit: 10), toNode: aWizard)
        //ourHero.constraints = [distanceConstraint]
        let background = SKSpriteNode(imageNamed: "valgrind_desert_forest1.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.physicsWorld.contactDelegate = self
        self.addChild(background)

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
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryProjectile.rawValue){
            let aHero = self.childNodeWithName("hero") as HeroClass
                aHero.takeDamage(1)
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
        let aWizard = self.childNodeWithName("wizard") as WizardClass
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
        if currentTime - lastFireball  > wizardAttackSpeed{
            self.lastFireball = currentTime
            theWizard!.shootFireball()
        }
        
        self.lastUpdatesTime = currentTime
        
        //check for win condition
        if (theWizard!.isDead == true || theHero!.life == 0) && levelOver == false{
            //parent of self is viewcontroller, has view, extends sknode
          //  if (theHero!.life == 0){
            //    let deathNode = SKLabelNode.init(text: "You died, try again!")
            //    deathNode.position = CGPointMake(self.frame.midX, self.frame.midY)
            //    self.addChild(deathNode)
           // }else if (theWizard!.isDead){
           //     let winNode = SKLabelNode.init(text: "You win, congratulations!")
            //    winNode.position = CGPointMake(self.frame.midX, self.frame.midY)
            //    self.addChild(winNode)
          //  }
            if droppedLoot && self.childNodeWithName("item") == nil{
                let menuScene = MainMenuScene(size: self.frame.size)
                let skTransition = SKTransition.fadeWithDuration(5.0)
                self.view?.presentScene(menuScene, transition: skTransition)
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil){
                if theWizard!.isDead{
                    dropLoot("level1", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
                    droppedLoot = true
                }
            }
        }
    }
}
