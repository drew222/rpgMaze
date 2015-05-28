//
//  World1Level14.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 4/4/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class World1Level14: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastFireball: Double = 0.0
    var levelOver = false
    let levelName = "world1level14"
    var droppedItem = false
    //REGEN CODE******
    var lastHeal: Double = 0.0
    let healSpeed = 5.0
    var maxLife: CGFloat = 0.0
    //*****************
    let wizardAttackSpeed = 0.5
    var attackSpots: [CGPoint] = []
    var whichSpot = 0
    
    //Ink / Life / Chest Changes*****
    var inkSplatted = false
    var newLifeNode: SKSpriteNode?
    var clickedChest = false
    var droppedChest = false
    //*******************************
    
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
        
        //Ink / Life / Chest Changes*****
        newLifeNode = SKSpriteNode(imageNamed: "World_1_Level_\(Int(theHero!.life!))_Text")
        newLifeNode!.position = CGPointMake(self.frame.maxX - 20, self.frame.maxY - 20)
        newLifeNode!.size = CGSizeMake(10, 10)
        newLifeNode!.name = "lifeNumber"
        newLifeNode!.zPosition = 3
        self.addChild(newLifeNode!)
        
        let lifeHeart = SKSpriteNode(imageNamed: "Life_Symbol_1")
        lifeHeart.position = CGPointMake(self.frame.maxX - 20, self.frame.maxY - 20)
        lifeHeart.name = "lifeheart"
        lifeHeart.setScale(0.15)
        self.addChild(lifeHeart)
        //************************************
        
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
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategorySeashell.rawValue){
                theHero!.takeDamage(3)
                (secondBody.node as! MineNode).explode(secondBody.node!.position)
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let aHero = self.childNodeWithName("hero") as? HeroClass
        for touch in touches{
            if !inkSplatted{
                aHero!.moveHelper((touch as! UITouch).locationInNode(self))
            }else if self.childNodeWithName("yesText") != nil{
                if self.childNodeWithName("yesText")!.containsPoint((touch as! UITouch).locationInNode(self)){
                    let newLevel1 = World1Level14(size: self.frame.size)
                    newLevel1.userData = NSMutableDictionary()
                    newLevel1.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                    newLevel1.userData?.setObject(self.userData?.objectForKey("menu") as! MainMenuScene, forKey: "menu")
                    //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                    let skTransition = SKTransition.fadeWithDuration(1.0)
                    self.view?.presentScene(newLevel1, transition: skTransition)
                    
                }else if self.childNodeWithName("noText")!.containsPoint((touch as! UITouch).locationInNode(self)){
                    let skTransition = SKTransition.fadeWithDuration(1.0)
                    
                    self.view?.presentScene(self.userData?.objectForKey("menu") as! MainMenuScene, transition: skTransition)
                }
            }
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
        if currentTime - lastFireball  > wizardAttackSpeed && !inkSplatted && !droppedChest && !droppedItem{
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
        newLifeNode!.texture = SKTexture(imageNamed: "World_1_Level_\(Int(theHero!.life!))_Text")
        if (theWizard!.isDead || theHero!.life <= 0) && !levelOver{
            
            if (self.childNodeWithName("gold") == nil && self.childNodeWithName("item") == nil && droppedItem) || theHero!.life <= 0{
                
                //INK SPLAT CODE
                if theHero!.life <= 0 {
                    let inkSplat = SKSpriteNode(imageNamed: "Ink_Splat_1")
                    for node in self.children{
                        if (node as? SKSpriteNode != nil) && node.name != "background"{
                            node.removeFromParent()
                        }
                    }
                    inkSplat.position = CGPointMake(self.frame.midX, self.frame.midY)
                    inkSplat.size = CGSizeMake(50, 50)
                    self.addChild(inkSplat)
                    let stretchAction = SKAction.scaleXBy(7, y: 7, duration: 0.4)
                    let codeBlock = SKAction.runBlock({
                        let yesText = SKSpriteNode(imageNamed: "Yes_Text_1")
                        let noText = SKSpriteNode(imageNamed: "No_Text_1")
                        yesText.size = CGSizeMake(75, 40)
                        noText.size = CGSizeMake(75, 40)
                        yesText.position = CGPointMake(self.frame.midX - 60, self.frame.midY - 30)
                        noText.position = CGPointMake(self.frame.midX + 60, self.frame.midY - 30)
                        yesText.name = "yesText"
                        noText.name = "noText"
                        self.addChild(yesText)
                        self.addChild(noText)
                    })
                    let sequence = SKAction.sequence([stretchAction, codeBlock])
                    inkSplat.runAction(sequence)
                    inkSplatted = true
                }else{
                    let skTransition = SKTransition.fadeWithDuration(1.0)
                    
                    self.view?.presentScene(self.userData?.objectForKey("menu") as! MainMenuScene, transition: skTransition)
                }
                
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil && self.childNodeWithName("gold") == nil){
                if theWizard!.isDead && droppedChest && (self.childNodeWithName("chest") as! TreasureChest).open{
                    dropLoot("level14", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
                    droppedItem = true
                }else if theWizard!.isDead && !droppedChest {
                    for node in self.children{
                        if (node as? SKSpriteNode != nil) && node.name != "background" && node.name != "item" && node.name != "hero" && node.name != "wizard" && node.name != "life" && node.name != "gold" && node.name != "chest"{
                            node.removeFromParent()
                        }
                    }
                    self.addChild(TreasureChest.chestAtPosition(CGPointMake(self.frame.midX, self.frame.midY)))
                    droppedChest = true
                }
            }
        }
    }
}
