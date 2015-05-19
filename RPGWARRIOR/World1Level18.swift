//
//  World1Level18.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 4/4/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class World1Level18: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastFireball: Double = 0.0
    var levelOver = false
    let levelName = "world1level18"
    var droppedItem = false
    //REGEN CODE******
    var lastHeal: Double = 0.0
    let healSpeed = 5.0
    var lifeNode: SKLabelNode?
    var maxLife: CGFloat = 0.0
    //*****************
    let wizardAttackSpeed = 0.5
    var attackSpots: [CGPoint] = []
    var whichSpot = 0
    
    //larger attack speed, slower attack
    
    var theWizard: WizardClass?
    var theHero: HeroClass?
    var blizzInContact: BlizzNode?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(CGPointMake(self.frame.minX + 30, 30))
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
        //outter = rows
        for (var i = 80; i < Int(self.frame.maxY - 140); i += 160){
            for (var k = 20; k < Int(self.frame.maxX) - 60; k += 40){
                self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(k), CGFloat(i))))
            }
        }
        for (var i = 160; i < Int(self.frame.maxY - 140); i += 160){
            for (var k = 60; k < Int(self.frame.maxX) - 20; k += 40){
                self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(k), CGFloat(i))))
            }
        }
        //if isPlus{
           // self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 390, self.frame.maxY - 100)))
       // }
        //******
        for (var k = 20; k < Int(self.frame.maxX) - 60; k += 40){
            attackSpots.append(CGPointMake(CGFloat(k), 40))
        }
        attackSpots.append(CGPointMake(0, 0))
        for (var k = Int(self.frame.maxX) - 20; k > 60; k -= 40){
            attackSpots.append(CGPointMake(CGFloat(k), 120))
        }
        attackSpots.append(CGPointMake(0, 0))
        for (var k = 20; k < Int(self.frame.maxX) - 60; k += 40){
            attackSpots.append(CGPointMake(CGFloat(k), 200))
        }
        attackSpots.append(CGPointMake(0, 0))
        for (var k = Int(self.frame.maxX) - 20; k > 60; k -= 40){
            attackSpots.append(CGPointMake(CGFloat(k), 280))
        }
        attackSpots.append(CGPointMake(0, 0))
        for (var k = 20; k < Int(self.frame.maxX) - 60; k += 40){
            attackSpots.append(CGPointMake(CGFloat(k), 360))
        }
        attackSpots.append(CGPointMake(0, 0))
        for (var k = Int(self.frame.maxX) - 20; k > 60; k -= 40){
            attackSpots.append(CGPointMake(CGFloat(k), 440))
        }
        attackSpots.append(CGPointMake(0, 0))
        for (var k = 20; k < Int(self.frame.maxX) - 60; k += 40){
            attackSpots.append(CGPointMake(CGFloat(k), 520))
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
                let aHero = self.childNodeWithName("hero") as! HeroClass
                aHero.takeDamage(1)
                secondBody.node!.removeFromParent()
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
        }
        self.totalGameTime += currentTime - self.lastUpdatesTime
        if currentTime - lastFireball  > wizardAttackSpeed{
            self.lastFireball = currentTime
            if whichSpot < attackSpots.count {
                if !(attackSpots[whichSpot].x == 0 && attackSpots[whichSpot].y == 0){
                    theWizard!.shootFireball(attackSpots[whichSpot])
                }
                whichSpot += 1
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
                    dropLoot("level18", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
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