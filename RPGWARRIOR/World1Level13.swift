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
    
    var timeSinceCrabAdded : TimeInterval = 0
    var addCrabTimeInterval : TimeInterval = 0.35
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastFireball: Double = 0.0
    var levelOver = false
    let levelName = "world1level13"
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
    
    let wizardAttackSpeed = 1.0
    
    var theBomber: BomberClass?
    var theHero: HeroClass?
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(position: CGPointMake(self.frame.midX, 30))
        theHero!.setScale(0.6)
        theHero!.name = "hero"
        self.addChild(theHero!)
        theBomber = BomberClass.makeBomber(position: CGPointMake(self.frame.midX, self.frame.maxY - 50))
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
        
        //patrol crabs
        self.addChild(MiniCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX + 30, self.frame.minY - 1000), endPosition: CGPointMake(self.frame.minX + 30, self.frame.maxY + 1000)))
        self.addChild(MiniCrab.crabAtPosition(startPos: CGPointMake(self.frame.maxX - 30, self.frame.minY - 1000), endPosition: CGPointMake(self.frame.maxX - 30, self.frame.maxY + 1000)))
        self.addChild(MiniCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX + 30, self.frame.minY - 2000), endPosition: CGPointMake(self.frame.minX + 30, self.frame.maxY + 2000)))
        self.addChild(MiniCrab.crabAtPosition(startPos: CGPointMake(self.frame.maxX - 30, self.frame.minY - 2000), endPosition: CGPointMake(self.frame.maxX - 30, self.frame.maxY + 2000)))
        
        
        //seashells
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.minX + 20, 100)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.minX + 50, 100)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.minX + 20, 130)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.minX + 50, 130)))
        
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.minX + 20, 250)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.minX + 50, 250)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.minX + 20, 280)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.minX + 50, 280)))
        
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.minX + 20, 400)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.minX + 50, 400)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.minX + 20, 430)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.minX + 50, 430)))
        if !(is5 || isPad){
            self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.minX + 20, 550)))
            self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.minX + 50, 550)))
            self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.minX + 20, 580)))
            self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.minX + 50, 580)))
        }
        /*
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 20, 500)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 50, 500)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 20, 530)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 50, 530)))
        */
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 20, 100)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 50, 100)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 20, 130)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 50, 130)))
        
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 20, 250)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 50, 250)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 20, 280)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 50, 280)))
        
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 20, 400)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 50, 400)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 20, 430)))
        self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 50, 430)))
        
        if !(is5 || isPad){
            self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 20, 550)))
            self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 50, 550)))
            self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 20, 580)))
            self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 50, 580)))
        }
        /*
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 20, 500)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 50, 500)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 20, 530)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 50, 530)))
        */

        
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
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryMiniCrab.rawValue){
            theHero!.takeDamage(damage: 1)
            let fadeOut = SKAction.fadeOut(withDuration: 0.6)
            let codeBlock = SKAction.run({secondBody.node?.removeFromParent()})
                let sequence = SKAction.sequence([fadeOut, codeBlock])
            secondBody.node?.run(sequence)
        }else  if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategorySeashell.rawValue){
                let mine = secondBody.node as? MineNode
            mine!.explode(position: secondBody.node!.position)
            theHero!.takeDamage(damage: 1)
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
                    let newLevel1 = World1Level13(size: self.frame.size)
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
            self.lastFireball = currentTime
        }
        self.totalGameTime += currentTime - self.lastUpdatesTime
        
        //CRAB STAMPEDE
        
        let xMatch = CGFloat(randomWithMin(min: Int(self.frame.minX + 80), max: Int(self.frame.maxX - 80)))
        self.timeSinceCrabAdded = self.timeSinceCrabAdded + currentTime - self.lastUpdatesTime
        
        
        if (self.timeSinceCrabAdded > self.addCrabTimeInterval && !self.levelOver && !droppedItem && !droppedChest) {
            self.addChild(MiniCrab.crabDash(startPos: CGPointMake(xMatch, self.frame.maxY + 30), endPosition: CGPointMake(xMatch, self.frame.minY)))
            
            
            self.timeSinceCrabAdded = 0
        }
        
        
        self.lastUpdatesTime = currentTime
        //******REGEN CODE
        if currentTime - lastHeal  > healSpeed{
            self.lastHeal = currentTime
            if theHero!.life! < maxLife{
                if soundOn && !levelOver && !droppedChest{
                    self.run(regenSound)
                }
                theHero!.life! += theHero!.regeneration!
                if theHero!.life! > maxLife{
                    theHero!.life = maxLife
                }
            }
        }
        self.lastUpdatesTime = currentTime
        lifeNode!.text = "\(Int(theHero!.life!))"
        if (theBomber!.isDead || theHero!.life! <= 0) && !levelOver{
            
            if (self.childNode(withName: "gold") == nil && self.childNode(withName: "item") == nil && droppedItem) || theHero!.life! <= 0{
                
                //INK SPLAT CODE
                if theHero!.life! <= 0 {
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
                    if (self.userData?.object(forKey: "menu") as! MainMenuScene).highestLevel < 13{
                        persistentData.set(13, forKey: "highestLevel")
                        (self.userData?.object(forKey: "menu") as! MainMenuScene).highestLevel = 13
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
                if theBomber!.isDead && droppedChest && (self.childNode(withName: "chest") as! TreasureChest).open{
                    dropLoot(level: "level13", scene: self, position: CGPointMake(self.frame.midX, self.frame.midY), size: CGSizeMake(30, 30))
                    droppedItem = true
                    itemDropped = self.childNode(withName: "item") as? ItemClass
                }else if theBomber!.isDead && !droppedChest {
                    for node in self.children{
                        if node as? SKLabelNode != nil {
                            node.removeFromParent()
                        }
                        if (node as? SKSpriteNode != nil) && node.name != "background" && node.name != "item" && node.name != "hero" && node.name != "bomber" && node.name != "life" && node.name != "gold" && node.name != "chest"{
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
