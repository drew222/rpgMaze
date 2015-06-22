//
//  World1Level28.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/5/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//
import SpriteKit

//import AVFoundation

class World1Level28: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastFireball: Double = 0.0
    var levelOver = false
    let levelName = "world1level28"
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
    
    //larger attack speed, slower attack
    let wizardAttackSpeed = 1.4
    
    var theWizard: WizardClass?
    var theHero: HeroClass?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, 30))
        theHero!.setScale(0.6)
        theHero!.name = "hero"
        self.addChild(theHero!)
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
        regenAmount.fontColor = UIColor.whiteColor()
        regenAmount.zPosition = 2
        regenAmount.fontName = "ChalkboardSE-Bold"
        self.addChild(regenAmount)
        //*************************
        
        //### Seashell Maze ###
        
        if isPlus{
            //add bot right corner
            self.addChild(GreyShell.mineAtPos(CGPointMake(290, 120)))
            self.addChild(GreyShell.mineAtPos(CGPointMake(320, 150)))
            self.addChild(GreyShell.mineAtPos(CGPointMake(340, 180)))
            //add top right corner
            self.addChild(GreyShell.mineAtPos(CGPointMake(210, 560)))
            self.addChild(GreyShell.mineAtPos(CGPointMake(250, 560)))
            self.addChild(GreyShell.mineAtPos(CGPointMake(290, 540)))
            self.addChild(GreyShell.mineAtPos(CGPointMake(320, 510)))
            self.addChild(GreyShell.mineAtPos(CGPointMake(340, 480)))
            //add top left corner
            self.addChild(GreyShell.mineAtPos(CGPointMake(70, 560)))
            self.addChild(GreyShell.mineAtPos(CGPointMake(90, 590)))
            self.addChild(GreyShell.mineAtPos(CGPointMake(120, 620)))
            //add bottom left corner
            self.addChild(GreyShell.mineAtPos(CGPointMake(70, 260)))
            self.addChild(GreyShell.mineAtPos(CGPointMake(90, 230)))
            self.addChild(GreyShell.mineAtPos(CGPointMake(120, 200)))
            self.addChild(GreyShell.mineAtPos(CGPointMake(160, 180)))
            self.addChild(GreyShell.mineAtPos(CGPointMake(200, 180)))
            
            //add bot horizontal row
            for (var i = 20; i < Int(self.frame.maxX - 130); i += 40){
                self.addChild(GreyShell.mineAtPos(CGPointMake(CGFloat(i),  100)))
            }
            //add top row
            for (var i = 155; i < Int(self.frame.maxX); i += 40){
                self.addChild(GreyShell.mineAtPos(CGPointMake(CGFloat(i), self.frame.maxY - 100)))
            }
            //right column
            for (var i = Int(self.frame.maxY) - 290; i > 180; i -= 40){
                self.addChild(GreyShell.mineAtPos(CGPointMake(self.frame.maxX - 60, CGFloat(i))))
            }
            //left column
            for (var i = 290; i < Int(self.frame.maxY) - 180; i += 40){
                self.addChild(GreyShell.mineAtPos(CGPointMake(60, CGFloat(i))))
            }
        } else {
        //add bot right corner
        self.addChild(GreyShell.mineAtPos(CGPointMake(260, 120)))
        self.addChild(GreyShell.mineAtPos(CGPointMake(290, 150)))
        self.addChild(GreyShell.mineAtPos(CGPointMake(310, 180)))
        //add top right corner
        self.addChild(GreyShell.mineAtPos(CGPointMake(180, 490)))
        self.addChild(GreyShell.mineAtPos(CGPointMake(220, 490)))
        self.addChild(GreyShell.mineAtPos(CGPointMake(260, 470)))
        self.addChild(GreyShell.mineAtPos(CGPointMake(290, 440)))
        self.addChild(GreyShell.mineAtPos(CGPointMake(310, 410)))
        //add top left corner
        self.addChild(GreyShell.mineAtPos(CGPointMake(70, 490)))
        self.addChild(GreyShell.mineAtPos(CGPointMake(90, 520)))
        self.addChild(GreyShell.mineAtPos(CGPointMake(120, 550)))
        //add bottom left corner
        self.addChild(GreyShell.mineAtPos(CGPointMake(70, 260)))
        self.addChild(GreyShell.mineAtPos(CGPointMake(90, 230)))
        self.addChild(GreyShell.mineAtPos(CGPointMake(120, 200)))
        self.addChild(GreyShell.mineAtPos(CGPointMake(160, 180)))
        self.addChild(GreyShell.mineAtPos(CGPointMake(200, 180)))
        
        //add bot horizontal row
        for (var i = 20; i < Int(self.frame.maxX - 130); i += 40){
            self.addChild(GreyShell.mineAtPos(CGPointMake(CGFloat(i),  100)))
        }
        //add top row
        for (var i = 155; i < Int(self.frame.maxX); i += 40){
            self.addChild(GreyShell.mineAtPos(CGPointMake(CGFloat(i), self.frame.maxY - 100)))
        }
        //right column
        for (var i = Int(self.frame.maxY) - 290; i > 180; i -= 40){
            self.addChild(GreyShell.mineAtPos(CGPointMake(self.frame.maxX - 60, CGFloat(i))))
        }
        //left column
        for (var i = 290; i < Int(self.frame.maxY) - 180; i += 40){
            self.addChild(GreyShell.mineAtPos(CGPointMake(60, CGFloat(i))))
        }
        }
        
        // ### Mud Crabs ###
       //mid
        self.addChild(MudCrab.crabAtPosition(CGPointMake(self.frame.midX, self.frame.midY + 20), endPosition: CGPointMake(self.frame.midX - 200, self.frame.midY + 20)))
        self.addChild(MudCrab.crabAtPosition(CGPointMake(self.frame.midX, self.frame.midY + 20), endPosition: CGPointMake(self.frame.midX + 200, self.frame.midY + 20)))
        //top 2
        self.addChild(MudCrab.crabAtPosition(CGPointMake(self.frame.midX, self.frame.midY + 20), endPosition: CGPointMake(self.frame.midX + 141, self.frame.midY + 161)))
        self.addChild(MudCrab.crabAtPosition(CGPointMake(self.frame.midX, self.frame.midY + 20), endPosition: CGPointMake(self.frame.midX - 141, self.frame.midY + 161)))
        //bot 2
        self.addChild(MudCrab.crabAtPosition(CGPointMake(self.frame.midX, self.frame.midY + 20), endPosition: CGPointMake(self.frame.midX + 141, self.frame.midY - 121)))
        self.addChild(MudCrab.crabAtPosition(CGPointMake(self.frame.midX, self.frame.midY + 20), endPosition: CGPointMake(self.frame.midX - 141, self.frame.midY - 121)))
        
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
        //HERO VS PEARL PROJECTILE
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryProjectile.rawValue){
                let aHero = self.childNodeWithName("hero") as! HeroClass
                aHero.takeDamage(1)
                secondBody.node!.removeFromParent()
        }
        //HERO VS GREYSHELL
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryGreyShell.rawValue){
                let mine = secondBody.node as? GreyShell
                mine!.explode(secondBody.node!.position)//(theHero!.position)//secondBody.node!.position)
                theHero!.takeDamage(10)
        }
        //HERO VS MINI CRAB
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryMudCrab.rawValue){
                theHero!.takeDamage(5)
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
                    let newLevel1 = World1Level28(size: self.frame.size)
                    newLevel1.userData = NSMutableDictionary()
                    newLevel1.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                    newLevel1.userData?.setObject(self.userData?.objectForKey("menu") as! MainMenuScene, forKey: "menu")
                    //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                    let skTransition = SKTransition.fadeWithDuration(1.0)
                    self.view?.presentScene(newLevel1, transition: skTransition)
                    
                }else if self.childNodeWithName("noText")!.containsPoint((touch as! UITouch).locationInNode(self)){
                    let skTransition = SKTransition.fadeWithDuration(1.0)
                    if soundOn {
                        levelMusic.stop()
                    }
                    self.view?.presentScene(self.userData?.objectForKey("menu") as! MainMenuScene, transition: skTransition)
                }
            }
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
        if currentTime - lastFireball  > wizardAttackSpeed && !inkSplatted && !droppedChest{
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
        lifeNode!.text = "\(Int(theHero!.life!))"
        if (theWizard!.isDead || theHero!.life <= 0) && !levelOver{
            
            if (self.childNodeWithName("gold") == nil && self.childNodeWithName("item") == nil && droppedItem) || theHero!.life <= 0{
                
                //INK SPLAT CODE
                if theHero!.life <= 0 {
                    let inkSplat = SKSpriteNode(imageNamed: "Ink_Splat_1")
                    for node in self.children{
                        if node as? SKLabelNode != nil {
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
                    if soundOn {
                    self.runAction(splatterSound)
                    }
                }else{
                    
                    //&&
                    let persistentData = NSUserDefaults.standardUserDefaults()
                    if (self.userData?.objectForKey("menu") as! MainMenuScene).highestLevel < 28{
                    persistentData.setObject(28, forKey: "highestLevel")
                        (self.userData?.objectForKey("menu") as! MainMenuScene).highestLevel = 28
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
                if theWizard!.isDead && droppedChest && (self.childNodeWithName("chest") as! TreasureChest).open{
                    dropLoot("level28", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
                    droppedItem = true
                    itemDropped = self.childNodeWithName("item") as? ItemClass
                }else if theWizard!.isDead && !droppedChest {
                    for node in self.children{
                        if node as? SKLabelNode != nil {
                            node.removeFromParent()
                        }
                        if (node as? SKSpriteNode != nil) && node.name != "background" && node.name != "item" && node.name != "hero" && node.name != "wizard" && node.name != "life" && node.name != "gold" && node.name != "chest"{
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
