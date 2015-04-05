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
        
        // ### Crabs ###
        //middle three vertical crabs
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX + 50, self.frame.maxY - 150), endPosition: CGPointMake(self.frame.midX + 50, self.frame.minY + 50)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX - 50, self.frame.maxY - 150), endPosition: CGPointMake(self.frame.midX - 50, self.frame.minY + 50)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX, self.frame.maxY - 150), endPosition: CGPointMake(self.frame.midX, self.frame.minY + 50)))
        //top left two vertical crabs
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 30, self.frame.midY + 20), endPosition: CGPointMake(self.frame.minX + 30, self.frame.maxY - 50)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 80, self.frame.midY + 20), endPosition: CGPointMake(self.frame.minX + 80, self.frame.maxY - 50)))
        //top right two vertical crabs
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.maxX - 30, self.frame.midY + 20), endPosition: CGPointMake(self.frame.maxX - 30, self.frame.maxY - 50)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.maxX - 80, self.frame.midY + 20), endPosition: CGPointMake(self.frame.maxX - 80, self.frame.maxY - 50)))
        //bottom left two vertical crabs
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 30, self.frame.midY - 20), endPosition: CGPointMake(self.frame.minX + 30, self.frame.minY + 50)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 80, self.frame.midY - 20), endPosition: CGPointMake(self.frame.minX + 80, self.frame.minY + 50)))
        //bottom right two vertical crabs
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.maxX - 30, self.frame.midY - 20), endPosition: CGPointMake(self.frame.maxX - 30, self.frame.minY + 50)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.maxX - 80, self.frame.midY - 20), endPosition: CGPointMake(self.frame.maxX - 80, self.frame.minY + 50)))
        //horizontal crabs (bottom to top)
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 30, self.frame.minY + 30), endPosition: CGPointMake(self.frame.maxX - 30, self.frame.minY + 30)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.maxX - 30, self.frame.minY + 180),
            endPosition: CGPointMake(self.frame.minX + 30, self.frame.minY + 180)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 30, self.frame.minY + 330), endPosition: CGPointMake(self.frame.maxX - 30, self.frame.minY + 330)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.maxX - 30, self.frame.minY + 480),
            endPosition: CGPointMake(self.frame.minX + 30, self.frame.minY + 480)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 30, self.frame.minY + 630), endPosition: CGPointMake(self.frame.maxX - 30, self.frame.minY + 630)))
        
        
        
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

