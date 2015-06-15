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
    var lastBomb: Double = 0.0
    var levelOver = false
    let levelName = "world1level11"
    var droppedItem = false
    //REGEN CODE******
    var lastHeal: Double = 0.0
    let healSpeed = 5.0
    var maxLife: CGFloat = 0.0
    //*****************
    
    //Ink / Life / Chest Changes*****
    var inkSplatted = false
    var lifeNode: SKLabelNode?
    var clickedChest = false
    var droppedChest = false
    //*******************************
    var itemDropped: ItemClass?
    
    let bomberAttackSpeed = 1.5
    
    var theBomber: BomberClass?
    var theHero: HeroClass?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, 30))
        theHero!.setScale(0.6)
        theHero!.name = "hero"
        self.addChild(theHero!)
        theBomber = BomberClass.makeBomber(CGPointMake(self.frame.midX, self.frame.maxY - 50))
        theBomber!.attackSpeed = 1.5
        self.addChild(theBomber!)
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
        
        //left crabs
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 30, self.frame.minY + 100), endPosition: CGPointMake(self.frame.maxX - 30, self.frame.minY + 250)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 30, self.frame.minY + 250), endPosition: CGPointMake(self.frame.maxX - 30, self.frame.minY + 400)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 30, self.frame.minY + 400), endPosition: CGPointMake(self.frame.maxX - 30, self.frame.minY + 550)))
        //right crabs
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.maxX - 30, self.frame.minY + 175), endPosition: CGPointMake(self.frame.minX + 30, self.frame.minY + 325)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.maxX - 30, self.frame.minY + 325), endPosition: CGPointMake(self.frame.minX + 30, self.frame.minY + 475)))
        
        theHero!.updateStats()
        //*****REGENE CODE****
        maxLife = theHero!.life!
        //********************
        //Ink / Life / Chest Changes*****
        lifeNode = SKLabelNode(text: "\(Int(floor(theHero!.life!)))")
        lifeNode!.position = CGPointMake(self.frame.maxX - 20, self.frame.maxY - 25)
        lifeNode!.fontName = "ChalkboardSE-Bold"
        lifeNode!.name = "lifeNumber"
        lifeNode!.zPosition = 3
        lifeNode!.fontSize = 16
        self.addChild(lifeNode!)
        
        let lifeHeart = SKSpriteNode(imageNamed: "Life_Symbol_1")
        lifeHeart.position = CGPointMake(self.frame.maxX - 20, self.frame.maxY - 20)
        lifeHeart.name = "lifeheart"
        lifeHeart.setScale(0.15)
        self.addChild(lifeHeart)
        //************************************
        
        //regen spinning clock
        let backTimer = SKSpriteNode(imageNamed: "Regen_Timer_1")
        backTimer.size = CGSizeMake(30, 30)
        backTimer.position = CGPointMake(self.frame.maxX - 60, self.frame.maxY - 20)
        backTimer.name = "backTimer"
        backTimer.zPosition = 2
        self.addChild(backTimer)
        let clockNode = SKSpriteNode(imageNamed: "Regen_Timer_2")
        clockNode.position = CGPointMake(self.frame.maxX - 60, self.frame.maxY - 20)
        clockNode.size = CGSizeMake(30, 30)
        clockNode.name = "regenClock"
        clockNode.zPosition = 3
        let spinAction = SKAction.rotateByAngle(2 * pi, duration: healSpeed)
        let repeatAction = SKAction.repeatActionForever(spinAction)
        clockNode.runAction(repeatAction)
        clockNode.zRotation = pi / 1.25
        self.addChild(clockNode)
        //********************
        
        //Regen Amount behind clock
        let regenAmount = SKLabelNode(text: "\(Int(theHero!.regeneration!))")
        regenAmount.position = CGPointMake(self.frame.maxX - 60, self.frame.maxY - 25)
        if theHero!.regeneration! < 10 {
            regenAmount.fontSize = 16
        }else{
            regenAmount.fontSize = 13
        }
        regenAmount.fontColor = UIColor.blackColor()
        regenAmount.zPosition = 2
        regenAmount.fontName = "ChalkboardSE-Bold"
        self.addChild(regenAmount)
        //*************************
        
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
        
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryMiniCrab.rawValue){
                theHero!.takeDamage(1)
                let fadeOut = SKAction.fadeOutWithDuration(0.6)
                let codeBlock = SKAction.runBlock({secondBody.node?.removeFromParent()})
                let sequence = SKAction.sequence([fadeOut, codeBlock])
                secondBody.node?.runAction(sequence)
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
                    let newLevel1 = World1Level11(size: self.frame.size)
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
        //println("current time: \(currentTime)")
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.lastUpdatesTime = currentTime
            self.lastBomb = currentTime
        }
        self.totalGameTime += currentTime - self.lastUpdatesTime
        if currentTime - lastBomb  > bomberAttackSpeed{
            self.lastBomb = currentTime
            theBomber!.throwBomb()
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
        lifeNode!.text = "\(Int(theHero!.life!))"
        if (theBomber!.isDead || theHero!.life <= 0) && !levelOver{
            
            if (self.childNodeWithName("gold") == nil && self.childNodeWithName("item") == nil && droppedItem) || theHero!.life <= 0{
                
                //INK SPLAT CODE
                if theHero!.life <= 0 {
                    let inkSplat = SKSpriteNode(imageNamed: "Ink_Splat_1")
                    for node in self.children{
                        if (node as? SKEmitterNode != nil){
                            node.removeFromParent()
                        }
                        if (node as? SKSpriteNode != nil) && node.name != "background"{
                            node.removeFromParent()
                        }
                    }
                    self.childNodeWithName("lifeNumber")?.removeFromParent()
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
                    
                    //&&
                    let persistentData = NSUserDefaults.standardUserDefaults()
                    if (self.userData?.objectForKey("menu") as! MainMenuScene).highestLevel < 11{
                    persistentData.setObject(11, forKey: "highestLevel")
                        (self.userData?.objectForKey("menu") as! MainMenuScene).highestLevel = 11
                    }
                    //&&
                    
                    //ITEM DISPLAY***************
                    let skTransition = SKTransition.fadeWithDuration(1.0)
                    let itemDisplayScene = ItemDisplayScene(size: self.frame.size)
                    if itemDropped != nil{
                        itemDisplayScene.itemName = itemDropped!.itemName!
                    }else{
                        itemDisplayScene.itemName = "Booty_1"
                        itemDisplayScene.numBooty = 1
                    }
                    itemDisplayScene.userData = NSMutableDictionary()
                    itemDisplayScene.userData?.setObject(self.userData?.objectForKey("menu") as! MainMenuScene, forKey: "menu")
                    itemDisplayScene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                    self.view?.presentScene(itemDisplayScene, transition: skTransition)
                    //***************************
                }
                
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil && self.childNodeWithName("gold") == nil){
                if theBomber!.isDead && droppedChest && (self.childNodeWithName("chest") as! TreasureChest).open{
                    dropLoot("level11", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
                    droppedItem = true
                    itemDropped = self.childNodeWithName("item") as? ItemClass
                }else if theBomber!.isDead && !droppedChest {
                    for node in self.children{
                        if node as? SKLabelNode != nil {
                            node.removeFromParent()
                        }
                        if (node as? SKEmitterNode != nil) && node.name != "inkAttack"{
                            node.removeFromParent()
                        }
                        if (node as? SKSpriteNode != nil) && node.name != "background" && node.name != "item" && node.name != "hero" && node.name != "bomber" && node.name != "life" && node.name != "gold" && node.name != "chest"{
                            node.removeFromParent()
                        }
                    }
                    self.childNodeWithName("lifeNumber")?.removeFromParent()
                    self.addChild(TreasureChest.chestAtPosition(CGPointMake(self.frame.midX, self.frame.midY)))
                    droppedChest = true
                }
            }
        }
    }
}

