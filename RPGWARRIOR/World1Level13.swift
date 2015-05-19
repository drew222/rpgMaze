//
//  World1Level13.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 4/4/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class World1Level13: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastFireball: Double = 0.0
    var levelOver = false
    let levelName = "world1level13"
    var droppedItem = false
    var lastBlizz = 0.0
    //REGEN CODE******
    var lastHeal: Double = 0.0
    let healSpeed = 5.0
    var lifeNode: SKLabelNode?
    var maxLife: CGFloat = 0.0
    //*****************
    let wizardAttackSpeed = 2.0
    
    var theWizard: WizardClass?
    var theHero: HeroClass?
    var blizzInContact: BlizzNode?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, 30))
        theHero!.setScale(0.6)
        theHero!.name = "hero"
        self.addChild(theHero!)
        lifeNode = SKLabelNode(text: "\(Int(floor(theHero!.life!)))")
        lifeNode!.position = CGPointMake(self.frame.maxX - 20, self.frame.maxY - 20)
        lifeNode!.name = "life"
        lifeNode!.fontColor = UIColor.redColor()
        lifeNode!.fontSize = 20
        self.addChild(lifeNode!)
        theWizard = WizardClass.makeWizard(CGPointMake(self.frame.midX, self.frame.maxY - 30))
        self.addChild(theWizard!)
        //the below constraints did nothing
        //let distanceConstraint = SKConstraint.distance(SKRange(lowerLimit: 10), toNode: aWizard)
        //ourHero.constraints = [distanceConstraint]
        let background = SKSpriteNode(imageNamed: "Beach_Background_1.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.name = "background"
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.physicsWorld.contactDelegate = self
        self.addChild(background)
        theHero!.updateStats()
        //*****REGENE CODE****
        maxLife = theHero!.life!
        //********************
        
        //seashells
        //bottom row
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 30, self.frame.minY + 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 70, self.frame.minY + 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 110, self.frame.minY + 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 150, self.frame.minY + 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 190, self.frame.minY + 100)))
        
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 310, self.frame.minY + 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 350, self.frame.minY + 100)))
        //top row
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 30, self.frame.maxY - 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 70, self.frame.maxY - 100)))
        
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 190, self.frame.maxY - 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 230, self.frame.maxY - 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 270, self.frame.maxY - 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 310, self.frame.maxY - 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 350, self.frame.maxY - 100)))
        if isPlus{
            self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 390, self.frame.maxY - 100)))
        }
        //right inside diagnols
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 225, self.frame.minY + 140)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 245, self.frame.minY + 180)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 265, self.frame.minY + 220)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 245, self.frame.minY + 260)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 225, self.frame.minY + 300)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 245, self.frame.minY + 340)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 265, self.frame.minY + 380)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 245, self.frame.minY + 420)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 225, self.frame.minY + 460)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 245, self.frame.minY + 500)))
        //right outside diagnols
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 320, self.frame.minY + 140)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 340, self.frame.minY + 180)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 360, self.frame.minY + 220)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 340, self.frame.minY + 260)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 320, self.frame.minY + 300)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 340, self.frame.minY + 340)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 360, self.frame.minY + 380)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 340, self.frame.minY + 420)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 320, self.frame.minY + 460)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 340, self.frame.minY + 500)))
        if isPlus{
            self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 400, self.frame.minY + 380)))
            self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 400, self.frame.minY + 220)))
        }
        //left inside diagnols
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 165, self.frame.maxY - 140)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 145, self.frame.maxY - 180)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 125, self.frame.maxY - 220)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 145, self.frame.maxY - 260)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 165, self.frame.maxY - 300)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 145, self.frame.maxY - 340)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 125, self.frame.maxY - 380)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 145, self.frame.maxY - 420)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 165, self.frame.maxY - 460)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 145, self.frame.maxY - 500)))
        //left outside diagnols
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 60, self.frame.maxY - 140)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 40, self.frame.maxY - 180)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 20, self.frame.maxY - 220)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 40, self.frame.maxY - 260)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 60, self.frame.maxY - 300)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 40, self.frame.maxY - 340)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 20, self.frame.maxY - 380)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 40, self.frame.maxY - 420)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 60, self.frame.maxY - 460)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 40, self.frame.maxY - 500)))

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
        //HERO VS FIRE
        else if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryProjectile.rawValue){
                let aHero = self.childNodeWithName("hero") as! HeroClass
                aHero.takeDamage(3)
                secondBody.node!.removeFromParent()
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let aHero = self.childNodeWithName("hero") as! HeroClass
        let aWizard = self.childNodeWithName("wizard") as! WizardClass
        for touch in touches{
            aHero.moveHelper((touch as! UITouch).locationInNode(self))
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        let hero = self.childNodeWithName("hero")
        
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.lastUpdatesTime = currentTime
            self.lastFireball = currentTime
            self.lastBlizz = currentTime
        }
        self.totalGameTime += currentTime - self.lastUpdatesTime
        if currentTime - lastFireball  > wizardAttackSpeed{
            self.lastFireball = currentTime
            theWizard!.shootFireball(theHero!.position)
        }
        if currentTime - lastBlizz > (3 * wizardAttackSpeed) {
            theWizard!.createBlizz(theWizard!.getBlizzLocation(theHero!.position))
            self.lastBlizz = currentTime
        }
        //loop through all the blizzards and check if position is in them
        var blizzFound = false
        for node in self.children{
            if (node as? BlizzNode != nil){
                //println("found blizzNode")
                if node.name == "blizz"{
                    if node.containsPoint(hero!.position){
                        blizzFound = true
                        if !theHero!.isSlowed{
                            theHero!.changeSpeed(-60)
                            theHero!.isSlowed = true
                        }
                        blizzInContact = node as? BlizzNode
                    }
                }
            }
        }
        if !blizzFound && blizzInContact != nil{
            if theHero!.isSlowed{
                theHero!.changeSpeed(60)
                theHero!.isSlowed = false
            }
        }
        
        self.totalGameTime += currentTime - self.lastUpdatesTime
        
        //******REGEN CODE
        if currentTime - lastHeal  > healSpeed{
            self.lastHeal = currentTime
            if theHero!.life < maxLife{
                theHero!.life! += theHero!.regeneration!
                if theHero!.life > maxLife{
                    theHero!.life = maxLife
                }
            }
        }
        self.lastUpdatesTime = currentTime
        lifeNode!.text = "\(Int(floor(theHero!.life!)))"
        //***************
        
        //win condition
        //check for win condition
        if (theWizard!.isDead || theHero!.life <= 0) && !levelOver{
            
            if (self.childNodeWithName("gold") == nil && self.childNodeWithName("item") == nil && droppedItem) || theHero!.life <= 0{
                
                let skTransition = SKTransition.fadeWithDuration(1.0)
                
                self.view?.presentScene(self.userData?.objectForKey("menu") as! MainMenuScene, transition: skTransition)
                
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil && self.childNodeWithName("gold") == nil){
                if theWizard!.isDead{
                    dropLoot("level13", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
                    droppedItem = true
                    for node in self.children{
                        if node.name != "background" && node.name != "item" && node.name != "hero" && node.name != "wizard" && node.name != "life" && node.name != "gold"{
                            node.removeFromParent()
                        }
                    }
                }
            }
        }
    }
}
