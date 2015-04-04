//
//  World1Level10.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/3/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class World1Level10: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastFireball: Double = 0.0
    var levelOver = false
    let levelName = "world1level10"
    var droppedItem = false
    
    //larger attack speed, slower attack
    let wizardAttackSpeed = 1.4
    
    var theWizard: WizardClass?
    var theHero: HeroClass?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, 30))
        theHero!.setScale(0.6)
        self.addChild(theHero!)
        theWizard = WizardClass.makeWizard(CGPointMake(self.frame.midX, self.frame.maxY - 50))
        self.addChild(theWizard!)
        let background = SKSpriteNode(imageNamed: "Beach_Background_1.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.physicsWorld.contactDelegate = self
        self.addChild(background)
        theHero!.updateStats()
        
        //add bot horizontal row
        for (var i = 20; i < Int(self.frame.maxX - 50); i += 40){
            self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(i),  100)))
        }
        //add second row
        //for (var i = Int(self.frame.maxX - 75); i > 50; i -= 40){
            //self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(i), 180)))
        //}
        //add top row
        for (var i = 75; i < Int(self.frame.maxX); i += 40){
            self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(i), self.frame.maxY - 100)))
        }
        //top right column
        for (var i = Int(self.frame.maxY) - 210; i > 100; i -= 40){
            self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 60, CGFloat(i))))
        }
        //bot left column
        for (var i = 210; i < Int(self.frame.maxY) - 100; i += 40){
            self.addChild(MineNode.mineAtPos(CGPointMake(60, CGFloat(i))))
        }
        //middle top horizontal row
        for (var i = 75; i < Int(self.frame.maxX - 115); i += 40){
            self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(i), self.frame.maxY - 165)))
        }
        //third row
        for (var i = Int(self.frame.maxX - 115); i > 115; i -= 40){
            self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(i), 180)))
        }
        //mid right column
        for (var i = Int(self.frame.maxY) - 200; i > 310; i -= 40){
            self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 140, CGFloat(i))))
        }
        //mid left column
        for (var i = 290; i < Int(self.frame.maxY) - 220; i += 40){
            self.addChild(MineNode.mineAtPos(CGPointMake(140, CGFloat(i))))
        }
        
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
                secondBody.node!.removeFromParent()
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let aHero = self.childNodeWithName("hero") as HeroClass
        let aWizard = self.childNodeWithName("wizard") as WizardClass
        for touch in touches{
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
        if (theWizard!.isDead || theHero!.life <= 0) && !levelOver{
            if (self.childNodeWithName("item") == nil && droppedItem) || theHero!.life <= 0{
                let skTransition = SKTransition.fadeWithDuration(5.0)
                self.view?.presentScene(self.userData?.objectForKey("menu") as MainMenuScene, transition: skTransition)
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil){
                if theWizard!.isDead{
                    dropLoot("world1level10", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
                    droppedItem = true
                }
            }
        }
    }
}
