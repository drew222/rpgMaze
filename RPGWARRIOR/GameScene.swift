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
    var droppedItem = false
    
    let wizardAttackSpeed = 1.0
    
    var theWizard: WizardClass?
    var theHero: HeroClass?
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(position: CGPointMake(self.frame.midX, self.frame.maxY * 0.1))
        theHero!.setScale(0.6)
        self.addChild(theHero!)
        theWizard = WizardClass.makeWizard(position: CGPointMake(self.frame.maxX * 0.25, self.frame.maxY * 0.75))
        self.addChild(theWizard!)
        //the below constraints did nothing
        //let distanceConstraint = SKConstraint.distance(SKRange(lowerLimit: 10), toNode: aWizard)
        //ourHero.constraints = [distanceConstraint]
        let background = SKSpriteNode(imageNamed: "Beach_Background_1.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.physicsWorld.contactDelegate = self
        self.addChild(background)
        let block = Block.blockAtPosition(position: CGPointMake(self.frame.midX, self.frame.midY - 50), vertical: false)
        block.name = "block"
        self.addChild(block)
        theHero!.updateStats()
        self.addChild(MiniCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX + 100, self.frame.midY + 100), endPosition: CGPointMake(self.frame.midX - 100, self.frame.midY)))

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
            let aHero = self.childNode(withName: "hero") as! HeroClass
            aHero.takeDamage(damage: 1)
                secondBody.node!.removeFromParent()
        }
        //HERO VS WIZARD
        //else if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            //secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryWizard.rawValue){
                //let aHero = self.childNodeWithName("hero") as HeroClass
                //aHero.attack()
        //}
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        let aHero = self.childNode(withName: "hero") as! HeroClass
        _ = self.childNode(withName: "wizard") as! WizardClass
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
            aHero.moveHelper(position: (touch ).location(in: self))
        }
    }
   
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.lastUpdatesTime = currentTime
            self.lastFireball = currentTime
        }
        self.totalGameTime += currentTime - self.lastUpdatesTime
        if currentTime - lastFireball  > wizardAttackSpeed{
            self.lastFireball = currentTime
            theWizard!.shootFireball(aPosition: theHero!.position)
        }
        
        self.lastUpdatesTime = currentTime
        
        //check for win condition
        if (theWizard!.isDead || theHero!.life! <= 0) && !levelOver{
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
            if (self.childNode(withName: "item") == nil && droppedItem) || theHero!.life! <= 0{
                //let menuScene = MainMenuScene(size: self.frame.size)
                //println("got here111")
                //(self.userData?.objectForKey("menu") as MainMenuScene).userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                //println("got here222")
                //menuScene.userData?.setValue(self.userData?.objectForKey("inventory"), forKey: "inventory")
                let skTransition = SKTransition.fade(withDuration: 1.0)
                //let gameScene = self.userData?.objectForKey("menu") as MainMenuScene
                self.view?.presentScene(self.userData?.object(forKey: "menu") as! MainMenuScene, transition: skTransition)
                levelOver = true
            }
            else if (self.childNode(withName: "item") == nil){
                if theWizard!.isDead{
                    dropLoot(level: "level1", scene: self, position: CGPointMake(self.frame.midX, self.frame.midY), size: CGSizeMake(30, 30))
                    droppedItem = true
                }
            }
        }
    }
}
