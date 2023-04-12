//
//  World1Level16.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/5/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class World1Level16: SKScene, SKPhysicsContactDelegate {
    
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastWave: Double = 0.0
    var levelOver = false
    let levelName = "world1level16"
    var droppedItem = false
    //REGEN CODE******
    var lastHeal: Double = 0.0
    let healSpeed = 5.0
    var maxLife: CGFloat = 0.0
    //*****************
    let whaleAttackSpeed = 2.0
    var whichWave = 0
    var wavePositions: [CGPoint]?
    
    //Ink / Life / Chest Changes*****
    var inkSplatted = false
    var lifeNode: SKLabelNode?
    var clickedChest = false
    var droppedChest = false
    //*******************************
    var itemDropped: ItemClass?
    
    
    var theWhale: WhaleBoss?
    var theHero: HeroClass?
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(position: CGPointMake(self.frame.midX, 30))
        theHero!.setScale(0.6)
        theHero!.name = "hero"
        self.addChild(theHero!)
        if isPlus{
            wavePositions = [
                CGPointMake(-20, 150),
                CGPointMake(self.frame.maxX + 20, 250),
                CGPointMake(-20, 150),
                CGPointMake(self.frame.maxX + 20, 250),
                CGPointMake(-20, 455),
                CGPointMake(self.frame.maxX + 20, 500),
                CGPointMake(-20, 455),
                CGPointMake(self.frame.maxX + 20, 500),
            CGPointMake(self.frame.maxX - 20, 600)]
            
        } else if isPad{
            wavePositions = [
                CGPointMake(-20, 140),
                CGPointMake(self.frame.maxX + 20, 190),
                CGPointMake(-20, 140),
                CGPointMake(self.frame.maxX + 20, 190),
                CGPointMake(-20, 360),
                CGPointMake(self.frame.maxX + 20, 360),
                CGPointMake(-20, 360)]
        } else if is5 {
            wavePositions = [
                CGPointMake(-20, 150),
                CGPointMake(self.frame.maxX + 20, 230),
                CGPointMake(-20, 150),
                CGPointMake(self.frame.maxX + 20, 230),
                CGPointMake(-20, 340),
                CGPointMake(self.frame.maxX + 20, 430),
                CGPointMake(-20, 340),
                CGPointMake(self.frame.maxX + 20, 430)]
        } else{
        wavePositions = [
            CGPointMake(-20, 150),
            CGPointMake(self.frame.maxX + 20, 250),
            CGPointMake(-20, 150),
            CGPointMake(self.frame.maxX + 20, 250),
            CGPointMake(-20, 400),
            CGPointMake(self.frame.maxX + 20, 500),
            CGPointMake(-20, 400),
            CGPointMake(self.frame.maxX + 20, 500)]
        }
        theWhale = WhaleBoss.makeWhale(position: CGPointMake(self.frame.midX, self.frame.maxY - 50))
        self.addChild(theWhale!)
        //the below constraints did nothing
        //let distanceConstraint = SKConstraint.distance(SKRange(lowerLimit: 10), toNode: aWizard)
        //ourHero.constraints = [distanceConstraint]
        let background = SKSpriteNode(imageNamed: "Beach_Background_1.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.name = "background"
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
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
        regenAmount.fontColor = UIColor.white
        regenAmount.zPosition = 2
        regenAmount.fontName = "ChalkboardSE-Bold"
        self.addChild(regenAmount)
        //*************************

        
        for (var i = 30; CGFloat(i) < self.frame.maxX - 10; i += 45){
            self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(i), self.frame.midY)))
        }
        
        
        //bot shells
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, 65)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 45, 65)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 45, 65)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 45, 25)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 45, 25)))
        //top shells
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 100, self.frame.maxY - 25)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 100, self.frame.maxY - 25)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 100, self.frame.maxY - 65)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 100, self.frame.maxY - 65)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 100, self.frame.maxY - 105)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 100, self.frame.maxY - 105)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 60, self.frame.maxY - 105)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 20, self.frame.maxY - 105)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 60, self.frame.maxY - 105)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 20, self.frame.maxY - 105)))
        
        
        
        
        //crabs
        if !isPad{
            if is5 {
                self.addChild(MiniCrab.crabAtPosition(startPos: CGPointMake(50, 380), endPosition: CGPointMake(self.frame.maxX - 50, 380)))
                self.addChild(MiniCrab.crabAtPosition(startPos: CGPointMake(50, 180), endPosition: CGPointMake(self.frame.maxX - 50, 180)))
            }else{
                self.addChild(MiniCrab.crabAtPosition(startPos: CGPointMake(50, 450), endPosition: CGPointMake(self.frame.maxX - 50, 450)))
                self.addChild(MiniCrab.crabAtPosition(startPos: CGPointMake(50, 200), endPosition: CGPointMake(self.frame.maxX - 50, 200)))
            }
            
        }else{
            self.addChild(MiniCrab.crabAtPosition(startPos: CGPointMake(50, 290), endPosition: CGPointMake(self.frame.maxX - 50, 290)))
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
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategorySeashell.rawValue){
                let mine = secondBody.node as? MineNode
            mine!.explode(position: secondBody.node!.position)
            theHero!.takeDamage(damage: 1)
        }
        //HERO VS CRAB
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryMiniCrab.rawValue){
            theHero!.takeDamage(damage: 1)
            let fadeOut = SKAction.fadeOut(withDuration: 0.6)
            let codeBlock = SKAction.run({secondBody.node?.removeFromParent()})
                let sequence = SKAction.sequence([fadeOut, codeBlock])
            secondBody.node?.run(sequence)
        }
        //HERO VS WAVE
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryWave.rawValue){
            theHero!.takeDamage(damage: 10)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        let aHero = self.childNode(withName: "hero") as? HeroClass
        for touch in touches{
            if !inkSplatted{
                aHero!.moveHelper(position: (touch ).location(in: self))
            }else if self.childNode(withName: "yesText") != nil{
                if self.childNode(withName: "yesText")!.contains((touch ).location(in: self)){
                    let newLevel1 = World1Level16(size: self.frame.size)
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
            self.lastWave = currentTime
        }
        self.totalGameTime += currentTime - self.lastUpdatesTime
        
        if currentTime - lastWave  > whaleAttackSpeed && !levelOver && !droppedItem && !droppedChest{
            self.lastWave = currentTime
            if whichWave == wavePositions!.count {
                whichWave = 0
            }
            theWhale!.throwWave(gapPosition: wavePositions![whichWave])
            whichWave += 1
        }
        
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
        if (theWhale!.isDead || theHero!.life ?? <#default value#> <= 0) && !levelOver{
            
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
                    if (self.userData?.object(forKey: "menu") as! MainMenuScene).highestLevel < 16{
                        persistentData.set(16, forKey: "highestLevel")
                        (self.userData?.object(forKey: "menu") as! MainMenuScene).highestLevel = 16
                    }
                    //&&
                    
                    //ITEM DISPLAY***************
                    let skTransition = SKTransition.fade(withDuration: 1.0)
                    let itemDisplayScene = ItemDisplayScene(size: self.frame.size)
                    if itemDropped != nil{
                        itemDisplayScene.itemName = itemDropped!.itemName!
                    }else{
                        itemDisplayScene.itemName = "Booty_1"
                        itemDisplayScene.numBooty = 5
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
                if theWhale!.isDead && droppedChest && (self.childNode(withName: "chest") as! TreasureChest).open{
                    dropLoot(level: "level16", scene: self, position: CGPointMake(self.frame.midX, self.frame.midY), size: CGSizeMake(30, 30))
                    droppedItem = true
                    itemDropped = self.childNode(withName: "item") as? ItemClass
                }else if theWhale!.isDead && !droppedChest {
                    for node in self.children{
                        if node as? SKLabelNode != nil {
                            node.removeFromParent()
                        }
                        if (node as? SKSpriteNode != nil) && node.name != "background" && node.name != "item" && node.name != "hero" && node.name != "whale" && node.name != "life" && node.name != "gold" && node.name != "chest"{
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
