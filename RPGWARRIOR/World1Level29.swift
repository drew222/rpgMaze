//
//  World1Level29.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/22/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//
import SpriteKit

//import AVFoundation

class World1Level29: SKScene, SKPhysicsContactDelegate {
    
    var timeSinceCrabAdded : TimeInterval = 0
    var addCrabTimeInterval : TimeInterval = 1.25
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastBomb: Double = 0.0
    var levelOver = false
    let levelName = "world1level29"
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
    
    let bomberAttackSpeed = 5.0
    
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
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.name = "background"
        background.zPosition = -1
        self.physicsWorld.contactDelegate = self
        self.addChild(background)
        
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
        theHero!.updateStats()
        maxLife = theHero!.life!
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
        
        
        //crabs
        if isPlus{
            //inside square
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX + 100, self.frame.midY + 100), endPosition: CGPointMake(self.frame.midX - 100, self.frame.midY + 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX - 130, self.frame.midY + 100), endPosition: CGPointMake(self.frame.midX - 130, self.frame.midY - 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX - 100, self.frame.midY - 100), endPosition: CGPointMake(self.frame.midX + 100, self.frame.midY - 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX + 140, self.frame.midY - 100), endPosition: CGPointMake(self.frame.midX + 140, self.frame.midY + 100)))
            //outside square
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX + 150, self.frame.midY + 150), endPosition: CGPointMake(self.frame.midX - 150, self.frame.midY + 150)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX - 180, self.frame.midY + 150), endPosition: CGPointMake(self.frame.midX - 180, self.frame.midY - 150)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX - 150, self.frame.midY - 150), endPosition: CGPointMake(self.frame.midX + 150, self.frame.midY - 150)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX + 180, self.frame.midY - 150), endPosition: CGPointMake(self.frame.midX + 180, self.frame.midY + 150)))
            
        } else if is5 || isPad {
            //inside square
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX + 100, self.frame.midY + 100), endPosition: CGPointMake(self.frame.midX - 100, self.frame.midY + 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX - 90, self.frame.midY + 100), endPosition: CGPointMake(self.frame.midX - 90, self.frame.midY - 120)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX - 100, self.frame.midY - 100), endPosition: CGPointMake(self.frame.midX + 100, self.frame.midY - 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX + 90, self.frame.midY - 100), endPosition: CGPointMake(self.frame.midX + 90, self.frame.midY + 100)))
            //outside square
            if !isPad{
                self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX + 150, self.frame.midY + 150), endPosition: CGPointMake(self.frame.midX - 150, self.frame.midY + 150)))
            }
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX - 140, self.frame.midY + 150), endPosition: CGPointMake(self.frame.midX - 140, self.frame.midY - 170)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX - 150, self.frame.midY - 150), endPosition: CGPointMake(self.frame.midX + 150, self.frame.midY - 150)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX + 140, self.frame.midY - 150), endPosition: CGPointMake(self.frame.midX + 140, self.frame.midY + 150)))

        } else {
        //inside square
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX + 100, self.frame.midY + 100), endPosition: CGPointMake(self.frame.midX - 100, self.frame.midY + 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX - 100, self.frame.midY + 100), endPosition: CGPointMake(self.frame.midX - 100, self.frame.midY - 120)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX - 100, self.frame.midY - 100), endPosition: CGPointMake(self.frame.midX + 100, self.frame.midY - 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX + 100, self.frame.midY - 100), endPosition: CGPointMake(self.frame.midX + 100, self.frame.midY + 100)))
        //outside square
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX + 150, self.frame.midY + 150), endPosition: CGPointMake(self.frame.midX - 150, self.frame.midY + 150)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX - 150, self.frame.midY + 150), endPosition: CGPointMake(self.frame.midX - 150, self.frame.midY - 170)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX - 150, self.frame.midY - 150), endPosition: CGPointMake(self.frame.midX + 150, self.frame.midY - 150)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.midX + 150, self.frame.midY - 150), endPosition: CGPointMake(self.frame.midX + 150, self.frame.midY + 150)))
        }
        
        
        //shells i = y, k = x
        //inside square
        //right wall
        self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX + 60, self.frame.midY)))
        self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX + 60, self.frame.midY - 30)))
        self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX + 60, self.frame.midY - 60)))
        //left wall
        self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX - 60, self.frame.midY)))
        self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX - 60, self.frame.midY + 30)))
        //bottom wall
        self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX, self.frame.midY - 60)))
        self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX + 30, self.frame.midY - 60)))
        if !(is5 || isPad){
            self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX + 90, self.frame.midY - 60)))
        }
    
        //top wall
        self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX, self.frame.midY + 60)))
        self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX - 30, self.frame.midY + 60)))
        self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX - 60, self.frame.midY + 60)))
        if !isPad{
            self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX - 90, self.frame.midY + 60)))
        }
        
        //top mid column
        if !isPad{
            self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX, self.frame.midY + 90)))
            self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX, self.frame.midY + 120)))
            self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX, self.frame.midY + 150)))
        if !(is5 || isPad){
            self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX, self.frame.midY + 180)))
        }
        }
        //bottom mid column
        self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX, self.frame.midY - 90)))
        self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX, self.frame.midY - 120)))
        self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX, self.frame.midY - 150)))
        if !isPad{
            self.addChild(GreyShell.mineAtPos(position: CGPointMake(self.frame.midX, self.frame.midY - 180)))
        }
        
        //bottom big wall
        if !isPad{
            for (var i = 20; i < Int(self.frame.maxX - 80); i += 30){
                self.addChild(GreyShell.mineAtPos(CGPointMake(CGFloat(i),  self.frame.midY - 205)))
            }
        }
        //top big wall
        if is5{
            for (var i = 90; i < Int(self.frame.maxX); i += 30){
                self.addChild(GreyShell.mineAtPos(CGPointMake(CGFloat(i),  self.frame.midY + 175)))
            }
        }else if !isPad{
            for (var i = 90; i < Int(self.frame.maxX); i += 30){
                self.addChild(GreyShell.mineAtPos(CGPointMake(CGFloat(i),  self.frame.midY + 205)))
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
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryMudCrab.rawValue){
            theHero!.takeDamage(damage: 5)
            let fadeOut = SKAction.fadeOut(withDuration: 0.6)
            let codeBlock = SKAction.run({secondBody.node?.removeFromParent()})
                let sequence = SKAction.sequence([fadeOut, codeBlock])
            secondBody.node?.run(sequence)
        }else  if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryGreyShell.rawValue){
                let mine = secondBody.node as? GreyShell
            mine!.explode(position: secondBody.node!.position)
            theHero!.takeDamage(damage: 10)
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        let aHero = self.childNode(withName: "hero") as? HeroClass
        for touch in touches{
            if !inkSplatted{
                aHero!.moveHelper(position: (touch ).location(in: self))
            }else if self.childNode(withName: "yesText") != nil{
                if self.childNode(withName: "yesText")!.contains((touch ).location(in: self)){
                    let newLevel1 = World1Level29(size: self.frame.size)
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
            self.lastBomb = currentTime
        }
        if currentTime - lastBomb  > bomberAttackSpeed && !inkSplatted && !droppedChest{
            self.lastBomb = currentTime
            theBomber!.throwBeachBall()
        }
        
        self.lastUpdatesTime = currentTime
        self.totalGameTime += currentTime - self.lastUpdatesTime
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
        lifeNode!.text = "\(Int(theHero!.life!))"
        if (theBomber!.isDead || theHero!.life ?? <#default value#> <= 0) && !levelOver{
            
            if (self.childNode(withName: "gold") == nil && self.childNode(withName: "item") == nil && droppedItem) || theHero!.life ?? <#default value#> <= 0{
                
                //INK SPLAT CODE
                if theHero!.life ?? <#default value#> <= 0 {
                    let inkSplat = SKSpriteNode(imageNamed: "Ink_Splat_1")
                    for node in self.children{
                        if node as? SKLabelNode != nil {
                            node.removeFromParent()
                        }
                        if (node as? SKEmitterNode != nil){
                            node.removeFromParent()
                        }
                        if (node as? SKSpriteNode != nil) && node.name != "background"{
                            node.removeFromParent()
                        }
                        self.childNode(withName: "lifeNumber")?.removeFromParent()
                    }
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
                if theBomber!.isDead && droppedChest && (self.childNode(withName: "chest") as! TreasureChest).open{
                    dropLoot(level: "level29", scene: self, position: CGPointMake(self.frame.midX, self.frame.midY), size: CGSizeMake(30, 30))
                    droppedItem = true
                    itemDropped = self.childNode(withName: "item") as? ItemClass
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
                    self.childNode(withName: "lifeNumber")?.removeFromParent()
                    self.addChild(TreasureChest.chestAtPosition(position: CGPointMake(self.frame.midX, self.frame.midY)))
                    droppedChest = true
                    if (self.userData?.object(forKey: "menu") as! MainMenuScene).highestLevel < 29{
                        (self.userData?.object(forKey: "inventory") as! Inventory).gold += 300
                        let persistentData = UserDefaults.standard
                        persistentData.set((self.userData?.object(forKey: "inventory") as! Inventory).gold, forKey: "gold")
                        persistentData.set(29, forKey: "highestLevel")
                        (self.userData?.object(forKey: "menu") as! MainMenuScene).highestLevel = 29
                    }
                }
            }
        }
    }
}
