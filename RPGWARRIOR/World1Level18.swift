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
    var lastBlizz = 0.0
    //REGEN CODE******
    var lastHeal: Double = 0.0
    let healSpeed = 5.0
    var maxLife: CGFloat = 0.0
    //*****************
    let wizardAttackSpeed = 2.0
    
    //Ink / Life / Chest Changes*****
    var inkSplatted = false
    var lifeNode: SKLabelNode?
    var clickedChest = false
    var droppedChest = false
    //*******************************
    var itemDropped: ItemClass?
    
    var theWizard: WizardClass?
    var theHero: HeroClass?
    var blizzInContact: BlizzNode?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, 30))
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
        
        //seashells
        //bottom row
        if isPlus{
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 30, self.frame.minY + 160)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 70, self.frame.minY + 160)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 110, self.frame.minY + 160)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 150, self.frame.minY + 160)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 190, self.frame.minY + 160)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 230, self.frame.minY + 160)))
            
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 350, self.frame.minY + 160)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 390, self.frame.minY + 160)))
        }else{
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 30, self.frame.minY + 100)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 70, self.frame.minY + 100)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 110, self.frame.minY + 100)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 150, self.frame.minY + 100)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 190, self.frame.minY + 100)))
            
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 310, self.frame.minY + 100)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 350, self.frame.minY + 100)))
            if is5{
                self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 220, self.frame.minY + 100)))
            }else if isPlus{
                self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 260, self.frame.minY + 100)))
            }
        }
        //top row
        if isPlus{
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 390, self.frame.maxY - 100)))
        }
        
        if !(is5 || isPad){
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 30, self.frame.maxY - 100)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 70, self.frame.maxY - 100)))
        }
        
        self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 190, self.frame.maxY - 100)))
        self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 230, self.frame.maxY - 100)))
        self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 270, self.frame.maxY - 100)))
        self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 310, self.frame.maxY - 100)))
        self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 350, self.frame.maxY - 100)))
        if is5 || isPad{
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 150, self.frame.maxY - 100)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 110, self.frame.maxY - 100)))
        }
        //right inside diagnols
        if isPlus{
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 265, self.frame.minY + 200)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 285, self.frame.minY + 240)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 305, self.frame.minY + 280)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 285, self.frame.minY + 320)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 265, self.frame.minY + 360)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 285, self.frame.minY + 400)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 305, self.frame.minY + 440)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 285, self.frame.minY + 480)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 265, self.frame.minY + 520)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 285, self.frame.minY + 560)))
            
            
        }else if is5 || isPad{
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 225, self.frame.minY + 180)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 225, self.frame.minY + 220)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 225, self.frame.minY + 260)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 225, self.frame.minY + 300)))
            if is5{
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 225, self.frame.minY + 340)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 225, self.frame.minY + 380)))
            }
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 225, self.frame.minY + 140)))
        }else{
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 225, self.frame.minY + 100)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 225, self.frame.minY + 140)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 245, self.frame.minY + 180)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 265, self.frame.minY + 220)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 245, self.frame.minY + 260)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 225, self.frame.minY + 300)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 245, self.frame.minY + 340)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 265, self.frame.minY + 380)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 245, self.frame.minY + 420)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 225, self.frame.minY + 460)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 245, self.frame.minY + 500)))
        }
        //right outside diagnols
        if isPlus{
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 360, self.frame.minY + 200)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 380, self.frame.minY + 240)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 400, self.frame.minY + 280)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 380, self.frame.minY + 320)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 360, self.frame.minY + 360)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 380, self.frame.minY + 400)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 400, self.frame.minY + 440)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 380, self.frame.minY + 480)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 360, self.frame.minY + 520)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 380, self.frame.minY + 560)))
            
        }else if is5 || isPad{
        }else{
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 320, self.frame.minY + 140)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 340, self.frame.minY + 180)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 360, self.frame.minY + 220)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 340, self.frame.minY + 260)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 320, self.frame.minY + 300)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 340, self.frame.minY + 340)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 360, self.frame.minY + 380)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 340, self.frame.minY + 420)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 320, self.frame.minY + 460)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 340, self.frame.minY + 500)))
        }
        //left inside diagnols
        if is5 || isPad{
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 105, self.frame.maxY - 140)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 105, self.frame.maxY - 180)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 105, self.frame.maxY - 220)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 105, self.frame.maxY - 260)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 105, self.frame.maxY - 300)))
            if is5{
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 105, self.frame.maxY - 340)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 105, self.frame.maxY - 380)))
            }
        }else{
            //self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 165, self.frame.maxY - 220)))
            //self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 145, self.frame.maxY - 260)))
            //self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 125, self.frame.maxY - 300)))
            //self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 145, self.frame.maxY - 340)))
            //self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 165, self.frame.maxY - 380)))
            //self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 145, self.frame.maxY - 420)))
            //self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 125, self.frame.maxY - 460)))
            //self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 145, self.frame.maxY - 500)))
            //self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 165, self.frame.maxY - 540)))
            
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 165, self.frame.maxY - 140)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 145, self.frame.maxY - 180)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 125, self.frame.maxY - 220)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 145, self.frame.maxY - 260)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 165, self.frame.maxY - 300)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 145, self.frame.maxY - 340)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 125, self.frame.maxY - 380)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 145, self.frame.maxY - 420)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 165, self.frame.maxY - 460)))
        }
        //left outside diagnols
        if is5 || isPad {

        }else{
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 60, self.frame.maxY - 140)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 40, self.frame.maxY - 180)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 20, self.frame.maxY - 220)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 40, self.frame.maxY - 260)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 60, self.frame.maxY - 300)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 40, self.frame.maxY - 340)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 20, self.frame.maxY - 380)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 40, self.frame.maxY - 420)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 60, self.frame.maxY - 460)))
            self.addChild(WhiteShell.mineAtPos(CGPointMake(self.frame.minX + 40, self.frame.maxY - 500)))
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
        //HERO VS WHITESHELL
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryWhiteShell.rawValue){
                let mine = secondBody.node as? WhiteShell
                mine!.explode(secondBody.node!.position)
                theHero!.takeDamage(2)
        }
            //HERO VS FIRE
        else if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryProjectile.rawValue){
                let aHero = self.childNodeWithName("hero") as! HeroClass
                aHero.takeDamage(1)
                secondBody.node!.removeFromParent()
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
                    let newLevel1 = World1Level18(size: self.frame.size)
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
        let hero = self.childNodeWithName("hero")
        
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.lastUpdatesTime = currentTime
            self.lastFireball = currentTime
            self.lastBlizz = currentTime
        }
        self.totalGameTime += currentTime - self.lastUpdatesTime
        if currentTime - lastFireball  > wizardAttackSpeed && !inkSplatted && !droppedChest{
            self.lastFireball = currentTime
            theWizard!.shootFireball(theHero!.position)
        }
        if currentTime - lastBlizz > (3 * wizardAttackSpeed) && !inkSplatted && !droppedChest{
            theWizard!.createBlizz(theWizard!.getBlizzLocation(theHero!.position))
            self.lastBlizz = currentTime
        }
        //loop through all the blizzards and check if position is in them
        var blizzFound = false
        for node in self.children{
            if (node as? BlizzNode != nil){
                //println("found blizzNode")
                if node.name == "blizz"{
                    if node.containsPoint(hero!.position){
                        blizzFound = true
                        if !theHero!.isSlowed{
                            theHero!.changeSpeed(-60)
                            theHero!.isSlowed = true
                        }
                        blizzInContact = node as? BlizzNode
                    }
                }
            }
        }
        if !blizzFound && blizzInContact != nil{
            if theHero!.isSlowed{
                theHero!.changeSpeed(60)
                theHero!.isSlowed = false
            }
        }
        
        self.totalGameTime += currentTime - self.lastUpdatesTime
        
        //******REGEN CODE
        if currentTime - lastHeal  > healSpeed{
            self.lastHeal = currentTime
            if theHero!.life < maxLife{
                if soundOn && !levelOver && !droppedChest{
                    self.runAction(regenSound)
                }
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
                    inkSplat.runAction(sequence)
                    inkSplatted = true
                    if soundOn {
                    self.runAction(splatterSound)
                    }
                }else{
                    
                    //&&
                    let persistentData = NSUserDefaults.standardUserDefaults()
                    if (self.userData?.objectForKey("menu") as! MainMenuScene).highestLevel < 18{
                    persistentData.setObject(18, forKey: "highestLevel")
                        (self.userData?.objectForKey("menu") as! MainMenuScene).highestLevel = 18
                    }
                    //&&
                    
                    //ITEM DISPLAY***************
                    let skTransition = SKTransition.fadeWithDuration(1.0)
                    let itemDisplayScene = ItemDisplayScene(size: self.frame.size)
                    if itemDropped != nil{
                        itemDisplayScene.itemName = itemDropped!.itemName!
                    }else{
                        itemDisplayScene.itemName = "Booty_1"
                        itemDisplayScene.numBooty = 6
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
                    dropLoot("level18", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
                    droppedItem = true
                    itemDropped = self.childNodeWithName("item") as? ItemClass
                }else if theWizard!.isDead && !droppedChest {
                    for node in self.children{
                        if node as? SKLabelNode != nil {
                            node.removeFromParent()
                        }
                        if (node as? SKEmitterNode != nil) && node.name != "inkAttack"{
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
