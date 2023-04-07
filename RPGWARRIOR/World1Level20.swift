//
//  World1Level20.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/2/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//
import Foundation
import SpriteKit

class World1Level20: SKScene, SKPhysicsContactDelegate  {
    
    var timeSinceCrabAdded : TimeInterval = 0
    var addCrabTimeInterval : TimeInterval = 1.1
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var levelOver = false
    let levelName = "world1level20"
    var theHero: HeroClass?
    var theBomber: BomberClass?
    var droppedItem = false
    //REGEN CODE******
    var lastHeal: Double = 0.0
    let healSpeed = 5.0
    var maxLife: CGFloat = 0.0
    //*****************
    let bomberAttackSpeed = 1.5
    
    //Ink / Life / Chest Changes*****
    var inkSplatted = false
    var lifeNode: SKLabelNode?
    var clickedChest = false
    var droppedChest = false
    //*******************************
    var itemDropped: ItemClass?
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        let background = SKSpriteNode(imageNamed: "Beach_Background_1.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        background.name = "background"
        self.physicsWorld.contactDelegate = self
        self.addChild(background)
        theHero = HeroClass.makeHero(position: CGPointMake(self.frame.midX, self.frame.maxY * 0.04))
        theHero!.setScale(0.6)
        theHero!.name = "hero"
        self.addChild(theHero!)
        theBomber = BomberClass.makeBomber(position: CGPointMake(self.frame.midX, self.frame.maxY - 50))
        self.addChild(theBomber!)
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
        
        //lower strafing crabs
        if is5 || isPad{
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX, self.frame.midY - 145), endPosition: CGPointMake(self.frame.minX + 500, self.frame.midY - 145)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX + 150, self.frame.midY - 145), endPosition: CGPointMake(self.frame.minX + 650, self.frame.midY - 145)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX + 300, self.frame.midY - 145), endPosition: CGPointMake(self.frame.minX + 800, self.frame.midY - 145)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX - 150, self.frame.midY - 145), endPosition: CGPointMake(self.frame.minX + 350, self.frame.midY - 145)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX - 300, self.frame.midY - 145), endPosition: CGPointMake(self.frame.minX + 200, self.frame.midY - 145)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX - 450, self.frame.midY - 145), endPosition: CGPointMake(self.frame.minX + 50, self.frame.midY - 145)))
        }else{
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX, self.frame.midY - 100), endPosition: CGPointMake(self.frame.minX + 500, self.frame.midY - 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX + 150, self.frame.midY - 100), endPosition: CGPointMake(self.frame.minX + 650, self.frame.midY - 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX + 300, self.frame.midY - 100), endPosition: CGPointMake(self.frame.minX + 800, self.frame.midY - 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX - 150, self.frame.midY - 100), endPosition: CGPointMake(self.frame.minX + 350, self.frame.midY - 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX - 300, self.frame.midY - 100), endPosition: CGPointMake(self.frame.minX + 200, self.frame.midY - 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX - 450, self.frame.midY - 100), endPosition: CGPointMake(self.frame.minX + 50, self.frame.midY - 100)))
        }
        //higher strafing crabs
        if is5 || isPad{
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX, self.frame.midY + 50), endPosition: CGPointMake(self.frame.minX + 500, self.frame.midY + 50)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX + 150, self.frame.midY + 50), endPosition: CGPointMake(self.frame.minX + 650, self.frame.midY + 50)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX + 300, self.frame.midY + 50), endPosition: CGPointMake(self.frame.minX + 800, self.frame.midY + 50)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX - 150, self.frame.midY + 50), endPosition: CGPointMake(self.frame.minX + 350, self.frame.midY + 50)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX - 300, self.frame.midY + 50), endPosition: CGPointMake(self.frame.minX + 200, self.frame.midY + 50)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX - 450, self.frame.midY + 50), endPosition: CGPointMake(self.frame.minX + 50, self.frame.midY + 50)))
        }else{
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX, self.frame.midY + 100), endPosition: CGPointMake(self.frame.minX + 500, self.frame.midY + 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX + 150, self.frame.midY + 100), endPosition: CGPointMake(self.frame.minX + 650, self.frame.midY + 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX + 300, self.frame.midY + 100), endPosition: CGPointMake(self.frame.minX + 800, self.frame.midY + 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX - 150, self.frame.midY + 100), endPosition: CGPointMake(self.frame.minX + 350, self.frame.midY + 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX - 300, self.frame.midY + 100), endPosition: CGPointMake(self.frame.minX + 200, self.frame.midY + 100)))
            self.addChild(MudCrab.crabAtPosition(startPos: CGPointMake(self.frame.minX - 450, self.frame.midY + 100), endPosition: CGPointMake(self.frame.minX + 50, self.frame.midY + 100)))
        }
        
        
        //bottom row seashells
        if is5 || isPad{
            if isPad{
                self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 70, self.frame.midY - 190)))
                self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 100, self.frame.midY - 190)))
                self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 130, self.frame.midY - 190)))
                self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 160, self.frame.midY - 190)))
                self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 190, self.frame.midY - 190)))
                self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 220, self.frame.midY - 190)))
                self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 250, self.frame.midY - 190)))
            }else{
                self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 70, self.frame.midY - 200)))
                self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 100, self.frame.midY - 200)))
                self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 130, self.frame.midY - 200)))
                self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 160, self.frame.midY - 200)))
                self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 190, self.frame.midY - 200)))
                self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 220, self.frame.midY - 200)))
                self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 250, self.frame.midY - 200)))
            }
        }else{
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 10, self.frame.midY - 250)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 40, self.frame.midY - 250)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 70, self.frame.midY - 250)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 100, self.frame.midY - 250)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 130, self.frame.midY - 250)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 160, self.frame.midY - 250)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 190, self.frame.midY - 250)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 220, self.frame.midY - 250)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 250, self.frame.midY - 250)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 280, self.frame.midY - 250)))
        }
        //2nd from bottom
        if is5 || isPad{
        }else{
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 50, self.frame.midY - 150)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 80, self.frame.midY - 150)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 50, self.frame.midY - 150)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 80, self.frame.midY - 150)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 110, self.frame.midY - 150)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 110, self.frame.midY - 150)))
        }
        if is5 || isPad{
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 150, self.frame.midY - 100)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 60, self.frame.midY - 100)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 90, self.frame.midY - 100)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 120, self.frame.midY - 100)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 150, self.frame.midY - 100)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 60, self.frame.midY - 100)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 90, self.frame.midY - 100)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 120, self.frame.midY - 100)))
        }else{
        //3rd from bottom
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX, self.frame.midY - 50)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 30, self.frame.midY - 50)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 60, self.frame.midY - 50)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 90, self.frame.midY - 50)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 120, self.frame.midY - 50)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 30, self.frame.midY - 50)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 60, self.frame.midY - 50)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 90, self.frame.midY - 50)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 120, self.frame.midY - 50)))
        }
        //top row
        if is5 || isPad{
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 10, self.frame.midY + 110)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 40, self.frame.midY + 110)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 70, self.frame.midY + 110)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 310, self.frame.midY + 110)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 280, self.frame.midY + 110)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 100, self.frame.midY + 110)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 220, self.frame.midY + 110)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 250, self.frame.midY + 110)))
        }else{
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 10, self.frame.midY + 230)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 40, self.frame.midY + 230)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 70, self.frame.midY + 230)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 100, self.frame.midY + 230)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 130, self.frame.midY + 230)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 160, self.frame.midY + 230)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 190, self.frame.midY + 230)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 220, self.frame.midY + 230)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 250, self.frame.midY + 230)))
        }
        //2nd from top
        if is5 || isPad{
            
        }else{
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 10, self.frame.midY + 150)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 40, self.frame.midY + 150)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 70, self.frame.midY + 150)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 100, self.frame.midY + 150)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 130, self.frame.midY + 150)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 160, self.frame.midY + 150)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 260, self.frame.midY + 150)))
        }
        
        //3rd from top
        if is5 || isPad{
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX, self.frame.midY)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 30, self.frame.midY)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 30, self.frame.midY)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 100, self.frame.midY)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 70, self.frame.midY)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 100, self.frame.midY)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 70, self.frame.midY)))
        }else{
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX, self.frame.midY + 50)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX + 30, self.frame.midY + 50)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.midX - 30, self.frame.midY + 50)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 10, self.frame.midY + 50)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 40, self.frame.midY + 50)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.minX + 70, self.frame.midY + 50)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 10, self.frame.midY + 50)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 40, self.frame.midY + 50)))
            self.addChild(WhiteShell.mineAtPos(position: CGPointMake(self.frame.maxX - 70, self.frame.midY + 50)))
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
        
        //HERO VS BEACH CRAB
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryMudCrab.rawValue){
            theHero!.takeDamage(damage: 5)
            let fadeOut = SKAction.fadeOut(withDuration: 0.6)
            let codeBlock = SKAction.run({secondBody.node?.removeFromParent()})
                let sequence = SKAction.sequence([fadeOut, codeBlock])
            secondBody.node?.run(sequence)
        }
        
        //HERO VS WHITESHELL
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryWhiteShell.rawValue){
                let mine = secondBody.node as? WhiteShell
            mine!.explode(position: secondBody.node!.position)
            theHero!.takeDamage(damage: 2)
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
                    let newLevel1 = World1Level20(size: self.frame.size)
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
        //println("current time: \(currentTime)")
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.lastUpdatesTime = currentTime
        }
        
        self.totalGameTime += currentTime - self.lastUpdatesTime
        
        //CRAB STAMPEDE
        
        self.timeSinceCrabAdded = self.timeSinceCrabAdded + currentTime - self.lastUpdatesTime
        
        
        if (self.timeSinceCrabAdded > self.addCrabTimeInterval && !self.levelOver && !inkSplatted && !droppedChest) {
            if is5 || isPad{
                self.addChild(MudCrab.crabDash(startPos: CGPointMake(self.frame.maxX, self.frame.midY - 50), endPosition: CGPointMake(self.frame.minX, self.frame.midY - 50)))
            }else{
                self.addChild(MudCrab.crabDash(startPos: CGPointMake(self.frame.minX, self.frame.midY ), endPosition: CGPointMake(self.frame.maxX, self.frame.midY)))
                self.addChild(MudCrab.crabDash(startPos: CGPointMake(self.frame.maxX, self.frame.midY - 200 ), endPosition: CGPointMake(self.frame.minX, self.frame.midY - 200)))
                self.addChild(MudCrab.crabDash(startPos: CGPointMake(self.frame.minX, self.frame.midY - 400), endPosition: CGPointMake(self.frame.maxX, self.frame.midY - 400)))
                self.addChild(MudCrab.crabDash(startPos: CGPointMake(self.frame.maxX, self.frame.midY + 200), endPosition: CGPointMake(self.frame.minX, self.frame.midY + 200)))
            }
            
            
            self.timeSinceCrabAdded = 0
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
        if (theBomber!.isDead || theHero!.life ?? <#default value#> <= 0) && !levelOver{
            
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
                    if (self.userData?.object(forKey: "menu") as! MainMenuScene).highestLevel < 20{
                        persistentData.set(20, forKey: "highestLevel")
                        (self.userData?.object(forKey: "menu") as! MainMenuScene).highestLevel = 20
                    }
                    //&&
                    
                    //ITEM DISPLAY***************
                    let skTransition = SKTransition.fade(withDuration: 1.0)
                    let itemDisplayScene = ItemDisplayScene(size: self.frame.size)
                    if itemDropped != nil{
                        itemDisplayScene.itemName = itemDropped!.itemName!
                    }else{
                        itemDisplayScene.itemName = "Booty_1"
                        itemDisplayScene.numBooty = 7
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
                    dropLoot(level: "level20", scene: self, position: CGPointMake(self.frame.midX, self.frame.midY), size: CGSizeMake(30, 30))
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
