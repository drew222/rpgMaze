//
//  World1Level20.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/2/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class World1Level20: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastFireball: Double = 0.0
    var levelOver = false
    let levelName = "world1level20"
    var droppedItem = false
    //REGEN CODE******
    var lastHeal: Double = 0.0
    let healSpeed = 5.0
    var lifeNode: SKLabelNode?
    var maxLife: CGFloat = 0.0
    //*****************
    
    //larger attack speed, slower attack
    let wizardAttackSpeed = 1.0
    
    var theWizard: WizardClass?
    var theHero: HeroClass?
    
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
        
        theWizard = WizardClass.makeWizard(CGPointMake(self.frame.midX, self.frame.maxY - 50))
        self.addChild(theWizard!)
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
        
        //shells i = y, k = x
        //right column
        for (var i = 20; i < Int(self.frame.maxY); i += 30){
            for (var k = 260.0; k < Double(self.frame.maxX); k += 30){
                self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(k), CGFloat(i))))
                if Double(self.frame.maxX) - k > 40 && Double(self.frame.maxX) - k < 30 {
                    self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(k + 30), CGFloat(i))))
                }
            }
        }
        //left column a = x b = y
        for (var b = 20; b < Int(self.frame.maxY); b += 30){
            for (var a = 20.0; a < Double(self.frame.maxX - 255); a += 30){
                self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(a), CGFloat(b))))
                if Double(self.frame.maxX) - a > 40 && Double(self.frame.maxX) - a < 30 {
                    self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(a + 30), CGFloat(b))))
                }
            }
        }
        //mid column c = x d = y
        for (var d = 80; d < Int(self.frame.maxY - 100); d += 30){
            for (var c = 140.0; c < Double(self.frame.maxX - 140); c += 30){
                self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(c), CGFloat(d))))
                if Double(self.frame.maxX) - c > 150 && Double(self.frame.maxX) - c < 150 {
                    self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(c + 30), CGFloat(d))))
                }
            }
        }
        //4 shells surrounding kraken at bottom
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 40, self.frame.minY + 20)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 40, self.frame.minY + 20)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 40, self.frame.minY + 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 40, self.frame.minY + 50)))
        
        
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
        //HERO VS SEASHELL
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategorySeashell.rawValue){
                let mine = secondBody.node as? MineNode
                mine!.explode(secondBody.node!.position)//(theHero!.position)//secondBody.node!.position)
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
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.lastUpdatesTime = currentTime
            self.lastFireball = currentTime
        }
        self.totalGameTime += currentTime - self.lastUpdatesTime
        if currentTime - lastFireball  > wizardAttackSpeed{
            self.lastFireball = currentTime
            theWizard!.shootFireball(theHero!.position)
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
                
                let skTransition = SKTransition.fadeWithDuration(5.0)
                
                self.view?.presentScene(self.userData?.objectForKey("menu") as! MainMenuScene, transition: skTransition)
                
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil && self.childNodeWithName("gold") == nil){
                if theWizard!.isDead{
                    dropLoot("level20", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
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

