//
//  World1Level25.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/22/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class World1Level25: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastTentacle = 0.0
    var lastWave = 0.0
    
    var levelOver = false
    let levelName = "world1level25"
    var droppedItem = false
    //REGEN CODE******
    var lastHeal: Double = 0.0
    let healSpeed = 20.0
    var maxLife: CGFloat = 0.0
    //*****************
    var krakenAttackSpeed = 1.5
    
    //Ink / Life / Chest Changes*****
    var inkSplatted = false
    var lifeNode: SKLabelNode?
    var clickedChest = false
    var droppedChest = false
    //*******************************
    var itemDropped: ItemClass?
    
    
    var theKraken: KrakenBoss?
    var theHero: HeroClass?
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        if is5 {
            krakenAttackSpeed = 3.0
        }
        if isPad {
            krakenAttackSpeed = 4.0
        }
        theHero = HeroClass.makeHero(position: CGPointMake(self.frame.midX, 30))
        theHero!.setScale(0.6)
        self.addChild(theHero!)
        theKraken = KrakenBoss.makeKraken(position: CGPointMake(self.frame.midX, self.frame.maxY - 50))
        theKraken!.size = CGSizeMake(150, 120)
        self.addChild(theKraken!)
        //the below constraints did nothing
        //let distanceConstraint = SKConstraint.distance(SKRange(lowerLimit: 10), toNode: aWizard)
        //ourHero.constraints = [distanceConstraint]
        let background = SKSpriteNode(imageNamed: "Beach_Background_1.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.name = "background"
        background.zPosition = -1
        self.addChild(background)
        self.physicsWorld.contactDelegate = self
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
        let spinAction = SKAction.rotate(byAngle: 2 * pi, duration: healSpeed)
        let repeatAction = SKAction.repeatForever(spinAction)
        clockNode.run(repeatAction)
        clockNode.zRotation = pi / 1.55
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
        regenAmount.fontColor = UIColor.white
        regenAmount.zPosition = 2
        regenAmount.fontName = "ChalkboardSE-Bold"
        self.addChild(regenAmount)
        //*************************
        
        //bot shells
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX, 65)))
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 45, 65)))
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 45, 65)))
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 45, 25)))
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 45, 25)))
        
        //top shells
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 100, self.frame.maxY - 25)))
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 100, self.frame.maxY - 25)))
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 100, self.frame.maxY - 65)))
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 100, self.frame.maxY - 65)))
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 100, self.frame.maxY - 105)))
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 100, self.frame.maxY - 105)))
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 100, self.frame.maxY - 145)))
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 100, self.frame.maxY - 145)))
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 100, self.frame.maxY - 145)))
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 60, self.frame.maxY - 145)))
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 20, self.frame.maxY - 145)))
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 60, self.frame.maxY - 145)))
        self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 20, self.frame.maxY - 145)))

        for (var i = 20; CGFloat(i) < (self.frame.maxX + CGFloat(10)); i += 40) {
            self.addChild(WhiteShell.mineAtPos(CGPointMake(CGFloat(i), self.frame.midY)))
        }
        if isPad {
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 10, self.frame.midY)))
        }
        if is5{
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 10, self.frame.midY)))
        }
        if isPlus{
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(50, 200), endPosition: CGPointMake(self.frame.maxX - 50, 200)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(50, 500), endPosition: CGPointMake(self.frame.maxX - 50, 500)))
        } else{
        //crabs
            if is5 || isPad{
                self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(50, 185), endPosition: CGPointMake(self.frame.maxX - 50, 185)))
            }else{
                self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(50, 200), endPosition: CGPointMake(self.frame.maxX - 50, 200)))
                self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(50, 440), endPosition: CGPointMake(self.frame.maxX - 50, 440)))
            }
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
        //HERO VS SEASHELL
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryWhiteShell.rawValue){
                let mine = secondBody.node as? WhiteShell
            mine!.explode(position: secondBody.node!.position)
            theHero!.takeDamage(damage: 2)
        }
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategorySpike.rawValue){
            theHero!.takeDamage(damage: 10)
            let fadeOut = SKAction.fadeOut(withDuration: 0.6)
            let codeBlock = SKAction.run({secondBody.node?.removeFromParent()})
                let sequence = SKAction.sequence([fadeOut, codeBlock])
            secondBody.node?.run(sequence)
        }
        //HERO VS CRAB
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryMudCrab.rawValue){
            theHero!.takeDamage(damage: 5)
            let fadeOut = SKAction.fadeOut(withDuration: 0.6)
            let codeBlock = SKAction.run({secondBody.node?.removeFromParent()})
                let sequence = SKAction.sequence([fadeOut, codeBlock])
            secondBody.node?.run(sequence)
        }
        /*
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
        secondBody.categoryBitMask == CollisionBitMasks.collisionCategorySpike.rawValue){
        if !self.childNodeWithName("safeSpot1")!.containsPoint(theHero!.position){
        theHero!.takeDamage(3)
        println("died by wave")
        }
        }*/
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        let aHero = self.childNode(withName: "hero") as? HeroClass
        for touch in touches{
            if !inkSplatted{
                aHero!.moveHelper(position: (touch ).location(in: self))
            }else if self.childNode(withName: "yesText") != nil{
                if self.childNode(withName: "yesText")!.contains((touch ).location(in: self)){
                    let newLevel1 = World1Level25(size: self.frame.size)
                    newLevel1.userData = NSMutableDictionary()
                    newLevel1.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                    newLevel1.userData?.setObject(self.userData?.object(forKey: "menu") as! MainMenuScene, forKey: "menu" as NSCopying)
                    //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                    let skTransition = SKTransition.fade(withDuration: 1.0)
                    self.view?.presentScene(newLevel1, transition: skTransition)
                    
                }else if self.childNode(withName: "noText")!.contains((touch ).location(in: self)){
                    let skTransition = SKTransition.fade(withDuration: 1.0)
                    if soundOn {
                        levelMusic!.stop()
                    }
                    self.view?.presentScene(self.userData?.object(forKey: "menu") as! MainMenuScene, transition: skTransition)
                }
            }
        }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.lastUpdatesTime = currentTime
            
        }
        self.totalGameTime += currentTime - self.lastUpdatesTime
        if currentTime - lastTentacle  > krakenAttackSpeed && !levelOver && !inkSplatted && !droppedChest && self.totalGameTime > 4{
            self.lastTentacle = currentTime
            theKraken!.throwTentacle()
        }
        
        /*
        if currentTime - lastWave  > krakenAttackSpeed * 3{
        for node in self.children{
        if let aNode = node as? SKSpriteNode{
        if aNode.name == "safeSpot1" || aNode.name == "safeSpot2"{
        aNode.removeFromParent()
        }
        }
        }
        self.lastWave = currentTime
        theKraken!.createSafeAndWave()
        }
        */
        
        
        //******REGEN CODE
        if currentTime - lastHeal  > healSpeed{
            self.lastHeal = currentTime
            if theHero!.life ?? <#default value#> < maxLife{
                if soundOn && !levelOver && !droppedChest{
                    self.run(regenSound)
                }
                theHero!.life! += theHero!.regeneration!
                if theHero!.life ?? <#default value#> > maxLife{
                    theHero!.life = maxLife
                }
            }
        }
        
        self.lastUpdatesTime = currentTime
        lifeNode!.text = "\(Int(theHero!.life!))"
        if (theKraken!.isDead || theHero!.life ?? <#default value#> <= 0) && !levelOver{
            
            if (self.childNode(withName: "gold") == nil && self.childNode(withName: "item") == nil && droppedItem) || theHero!.life ?? <#default value#> <= 0{
                
                //INK SPLAT CODE
                if theHero!.life ?? <#default value#> <= 0 {
                    let inkSplat = SKSpriteNode(imageNamed: "Ink_Splat_1")
                    for node in self.children{
                        if node as? SKLabelNode != nil {
                            node.removeFromParent()
                        }
                        if (node as? SKSpriteNode != nil) && node.name != "background"{
                            node.removeFromParent()
                        }
                    }
                    self.childNode(withName: "lifeNumber")?.removeFromParent()
                    inkSplat.position = CGPointMake(self.frame.midX, self.frame.midY)
                    inkSplat.size = CGSizeMake(50, 50)
                    self.addChild(inkSplat)
                    let stretchAction = SKAction.scaleX(by: 7, y: 7, duration: 0.4)
                    let codeBlock = SKAction.run({
                        let yesText = SKSpriteNode(imageNamed: "Yes_Text_1")
                        let noText = SKSpriteNode(imageNamed: "No_Text_1")
                        yesText.zPosition = 3
                        noText.zPosition = 3
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
                    inkSplat.run(sequence)
                    inkSplatted = true
                    if soundOn {
                        self.run(splatterSound)
                    }
                }else{
                    
                    //&&
                    let persistentData = UserDefaults.standard
                    if (self.userData?.object(forKey: "menu") as! MainMenuScene).highestLevel < 25{
                        persistentData.set(25, forKey: "highestLevel")
                        (self.userData?.object(forKey: "menu") as! MainMenuScene).highestLevel = 25
                    }
                    //&&
                    
                    //ITEM DISPLAY***************
                    let skTransition = SKTransition.fade(withDuration: 1.0)
                    let itemDisplayScene = ItemDisplayScene(size: self.frame.size)
                    if itemDropped != nil{
                        itemDisplayScene.itemName = itemDropped!.itemName!
                    }else{
                        itemDisplayScene.itemName = "Booty_1"
                        itemDisplayScene.numBooty = 10
                    }
                    itemDisplayScene.userData = NSMutableDictionary()
                    itemDisplayScene.userData?.setObject(self.userData?.object(forKey: "menu") as! MainMenuScene, forKey: "menu" as NSCopying)
                    itemDisplayScene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                    self.view?.presentScene(itemDisplayScene, transition: skTransition)
                    //***************************
                }
                
                levelOver = true
            }
            else if (self.childNode(withName: "item") == nil && self.childNode(withName: "gold") == nil){
                if theKraken!.isDead && droppedChest && (self.childNode(withName: "chest") as! TreasureChest).open{
                    dropLoot(level: "level25", scene: self, position: CGPointMake(self.frame.midX, self.frame.midY), size: CGSizeMake(30, 30))
                    droppedItem = true
                    itemDropped = self.childNode(withName: "item") as? ItemClass
                }else if theKraken!.isDead && !droppedChest {
                    for node in self.children{
                        if node as? SKLabelNode != nil {
                            node.removeFromParent()
                        }
                        if (node as? SKSpriteNode != nil) && node.name != "background" && node.name != "item" && node.name != "hero" && node.name != "kraken" && node.name != "life" && node.name != "gold" && node.name != "chest"{
                            node.removeFromParent()
                        }
                    }
                    self.childNode(withName: "lifeNumber")?.removeFromParent()
                    self.addChild(TreasureChest.chestAtPosition(position: CGPointMake(self.frame.midX, self.frame.midY)))
                    droppedChest = true
                }
            }
        }
    }
}





