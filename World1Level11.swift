//
//  World1Level11.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/4/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class World1Level11: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastFireball: Double = 0.0
    var levelOver = false
    let levelName = "world1level11"
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
        
        //### Seashell Maze ###
        
        //add bot horizontal row
        for (var i = 20; i < Int(self.frame.maxX - 130); i += 40){
            self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(i),  100)))
        }
        //add bot right corner
        self.addChild(MineNode.mineAtPos(CGPointMake(260, 110)))
        self.addChild(MineNode.mineAtPos(CGPointMake(290, 140)))
        self.addChild(MineNode.mineAtPos(CGPointMake(310, 180)))
        //add top right corner
        self.addChild(MineNode.mineAtPos(CGPointMake(260, 490)))
        self.addChild(MineNode.mineAtPos(CGPointMake(290, 470)))
        self.addChild(MineNode.mineAtPos(CGPointMake(310, 450)))
        //add top left corner
        self.addChild(MineNode.mineAtPos(CGPointMake(70, 520)))
        self.addChild(MineNode.mineAtPos(CGPointMake(90, 540)))
        self.addChild(MineNode.mineAtPos(CGPointMake(110, 560)))
        //add bottom left corner
        self.addChild(MineNode.mineAtPos(CGPointMake(80, 260)))
        self.addChild(MineNode.mineAtPos(CGPointMake(100, 230)))
        self.addChild(MineNode.mineAtPos(CGPointMake(120, 200)))
        //add top row
        for (var i = 155; i < Int(self.frame.maxX); i += 40){
            self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(i), self.frame.maxY - 100)))
        }
        //right column
        for (var i = Int(self.frame.maxY) - 250; i > 180; i -= 40){
            self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 60, CGFloat(i))))
        }
        //left column
        for (var i = 290; i < Int(self.frame.maxY) - 140; i += 40){
            self.addChild(MineNode.mineAtPos(CGPointMake(60, CGFloat(i))))
        }
        //middle top horizontal row
        for (var i = 180; i < Int(self.frame.maxX - 120); i += 40){
            self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(i), self.frame.maxY - 165)))
        }
        //second row
        for (var i = 140; i < Int(self.frame.maxX - 130); i += 40){
            self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(i),  180)))
        }
        
        // ### Crabs ###
        
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX, self.frame.midY + 20), endPosition: CGPointMake(self.frame.minX, self.frame.midY + 20)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX, self.frame.midY + 20), endPosition: CGPointMake(self.frame.minX + 20, self.frame.midY + 150)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX, self.frame.midY + 20), endPosition: CGPointMake(self.frame.midX, self.frame.maxY - 120)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX, self.frame.midY + 20), endPosition: CGPointMake(self.frame.maxX - 20, self.frame.midY + 150)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX, self.frame.midY + 20), endPosition: CGPointMake(self.frame.maxX, self.frame.midY + 20)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX, self.frame.midY + 20), endPosition: CGPointMake(self.frame.maxX - 30, self.frame.midY - 150)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX, self.frame.midY + 20), endPosition: CGPointMake(self.frame.midX, self.frame.minY + 140)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX, self.frame.midY + 20), endPosition: CGPointMake(self.frame.minX + 30, self.frame.midY - 150)))
        
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
                    dropLoot("world1level11", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
                    droppedItem = true
                }
            }
        }
    }
}

