//
//  World1Level17.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/7/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class World1Level17: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastFireball: Double = 0.0
    var levelOver = false
    let levelName = "world1level17"
    var droppedItem = false
    
    let wizardAttackSpeed = 1.0
    
    var theWizard: WizardClass?
    var theHero: HeroClass?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, 30))
        theHero!.setScale(0.6)
        self.addChild(theHero!)
        theWizard = WizardClass.makeWizard(CGPointMake(self.frame.midX, self.frame.maxY - 30))
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
        theHero!.updateStats()
        //self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX + 100, self.frame.midY + 100), endPosition: CGPointMake(self.frame.midX - 100, self.frame.midY)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, self.frame.midY)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 50, self.frame.midY + 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 50, self.frame.midY - 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 50, self.frame.midY - 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 50, self.frame.midY + 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 100, self.frame.midY + 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 100, self.frame.midY - 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 100, self.frame.midY - 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 100, self.frame.midY + 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 150, self.frame.midY + 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 150, self.frame.midY - 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 150, self.frame.midY - 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 150, self.frame.midY + 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, self.frame.midY + 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, self.frame.midY - 150)))
        
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
        
        self.lastUpdatesTime = currentTime
        
        //check for win condition
        if (theWizard!.isDead || theHero!.life <= 0) && !levelOver{
            if (self.childNodeWithName("item") == nil && droppedItem) || theHero!.life <= 0{
                let skTransition = SKTransition.fadeWithDuration(5.0)
                println("got here111")
                self.view?.presentScene(self.userData?.objectForKey("menu") as MainMenuScene, transition: skTransition)
                println("got here222")
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil){
                if theWizard!.isDead{
                    dropLoot("world1level17", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
                    droppedItem = true
                }
            }
        }
    }
}


