//
//  World1Level3.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 4/3/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class World1Level3: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastFireball: Double = 0.0
    var levelOver = false
    let levelName = "world1level3"
    var droppedItem = false
    //REGEN CODE******
    var lastHeal: Double = 0.0
    let healSpeed = 5.0
    var maxLife: CGFloat = 0.0
    //*****************
    let wizardAttackSpeed = 1.0
    
    //Ink / Life / Chest Changes*****
    var inkSplatted = false
    var lifeNode: SKLabelNode?
    var clickedChest = false
    var droppedChest = false
    //*******************************
    var itemDropped: ItemClass?
    
    var theWizard: WizardClass?
    var theHero: HeroClass?
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(position: CGPointMake(self.frame.midX, 30))
        theHero!.setScale(0.6)
        theHero!.name = "hero"
        self.addChild(theHero!)
        theWizard = WizardClass.makeWizard(position: CGPointMake(self.frame.midX, self.frame.maxY - 30))
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
        
        if isPlus {
            
            // bot row
            for i in stride(from: 20, to: Int(self.frame.maxX - 90), by: 40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(CGFloat(i), self.frame.midY - 237)))
            }
            
            //add 1st row from bot
            for i in stride(from: Int(self.frame.maxX - 20), to: 90, by: -40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(CGFloat(i), self.frame.midY - 157)))
            }
            //add top row
            for i in stride(from: Int(self.frame.maxX - 20), to: 90, by: -40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(CGFloat(i), self.frame.midY + 235)))
            }
            //2nd from top row
            for i in stride(from: 20, to: Int(self.frame.maxX - 90), by: 40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(CGFloat(i), self.frame.midY + 155)))
            }
            //right column
            for i in stride(from: Int(self.frame.maxY) - 212, to: 300, by: -40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 80, CGFloat(i))))
            }
            //left column
            for i in stride(from: 213, to: Int(self.frame.maxY) - 297, by: 40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(80, CGFloat(i))))
            }
            //midtop row
            for i in stride(from: 120, to: Int(self.frame.maxX - 155), by: 40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(CGFloat(i), self.frame.midY + 47)))
            }
            //midbot row
            for i in stride(from: Int(self.frame.maxX - 120), to: 155, by: -40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(CGFloat(i), self.frame.midY - 43)))
            }
            
        } else if isPad || is5{
            //midtop row
            for i in stride(from: 70, to: Int(self.frame.maxX), by: 40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(CGFloat(i), self.frame.midY + 150)))
            }
            //midbot row
            for i in stride(from: 70, to: Int(self.frame.maxX), by: 40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(CGFloat(i), self.frame.midY - 150)))
            }
            //right column
            for i in stride(from: Int(self.frame.midY) - 130, to: Int(self.frame.midY + 100), by: 40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 70, CGFloat(i))))
            }
            //left column
            for i in stride(from: Int(self.frame.midY + 100), to: Int(self.frame.midY) - 100, by: -40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(70, CGFloat(i))))
            }
        } else {
            // bot row
            for i in stride(from: 20, to: Int(self.frame.maxX - 90), by: 40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(CGFloat(i), self.frame.midY - 202)))
            }
            
            //add 1st row from bot
            for i in stride(from: Int(self.frame.maxX - 20), to: 90, by: -40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(CGFloat(i), self.frame.midY - 122)))
            }
            //add top row
            for i in stride(from: Int(self.frame.maxX - 20), to: 90, by: -40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(CGFloat(i), self.frame.midY + 200)))
            }
            //2nd from top row
            for i in stride(from: 20, to: Int(self.frame.maxX - 90), by: 40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(CGFloat(i), self.frame.midY + 120)))
            }
            //right column
            for i in stride(from: Int(self.frame.maxY) - 212, to: 260, by: -40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(self.frame.maxX - 80, CGFloat(i))))
            }
            //left column
            for i in stride(from: 213, to: Int(self.frame.maxY) - 257, by: 40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(80, CGFloat(i))))
            }
            //midtop row
            for i in stride(from: 120, to: Int(self.frame.maxX - 155), by: 40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(CGFloat(i), self.frame.midY + 42)))
            }
            //midbot row
            for i in stride(from: Int(self.frame.maxX - 120), to: 155, by: -40) {
                self.addChild(MineNode.mineAtPos(position: CGPointMake(CGFloat(i), self.frame.midY - 38)))
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
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategorySeashell.rawValue){
                let mine = secondBody.node as? MineNode
            mine!.explode(position: secondBody.node!.position)
            theHero!.takeDamage(damage: 1)
        }
        //HERO VS WIZARD
        //else if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
        //secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryWizard.rawValue){
        //let aHero = self.childNodeWithName("hero") as HeroClass
        //aHero.attack()
        //}
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        let aHero = self.childNode(withName: "hero") as? HeroClass
        _ = self.childNode(withName: "wizard") as? WizardClass
        for touch in touches{
            if !inkSplatted{
                aHero!.moveHelper(position: (touch ).location(in: self))
            }else if self.childNode(withName: "yesText") != nil{
                if self.childNode(withName: "yesText")!.contains((touch ).location(in: self)){
                    let newLevel1 = World1Level3(size: self.frame.size)
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
        if (theWizard!.isDead || theHero!.life! <= 0) && !levelOver{
            
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
                    if (self.userData?.object(forKey: "menu") as! MainMenuScene).highestLevel < 3{
                        persistentData.set(3, forKey: "highestLevel")
                        (self.userData?.object(forKey: "menu") as! MainMenuScene).highestLevel = 3
                    }
                    //&&
                    
                    //ITEM DISPLAY***************
                    let skTransition = SKTransition.fade(withDuration: 1.0)
                    let itemDisplayScene = ItemDisplayScene(size: self.frame.size)
                    if itemDropped != nil{
                        itemDisplayScene.itemName = itemDropped!.itemName!
                    }else{
                        itemDisplayScene.itemName = "Booty_1"
                        itemDisplayScene.numBooty = 1
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
                if theWizard!.isDead && droppedChest && (self.childNode(withName: "chest") as! TreasureChest).open{
                    dropLoot(level: "level3", scene: self, position: CGPointMake(self.frame.midX, self.frame.midY), size: CGSizeMake(30, 30))
                    droppedItem = true
                    itemDropped = self.childNode(withName: "item") as? ItemClass
                }else if theWizard!.isDead && !droppedChest {
                    for node in self.children{
                        if node as? SKLabelNode != nil {
                            node.removeFromParent()
                        }
                        if (node as? SKSpriteNode != nil) && node.name != "background" && node.name != "item" && node.name != "hero" && node.name != "wizard" && node.name != "life" && node.name != "gold" && node.name != "chest"{
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
