//
//  World1Level30.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/2/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class World1Level30: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastTentacle = 0.0
    var lastWave = 0.0
    var lastCrab = 0.0
    var lastKrill = 0.0
    var lastBuff = 0.0
    
    var levelOver = false
    let levelName = "world1level30"
    var droppedItem = false
    //REGEN CODE******
    var lastHeal: Double = 0.0
    let healSpeed = 5.0
    var lifeNode: SKLabelNode?
    var maxLife: CGFloat = 0.0
    var maxSpeed: CGFloat = 0.0
    //*****************
    var krakenAttackSpeed = 5.0
    var krakenAttackSpeedSpike = 15.0
    var whaleAttackSpeedWave = 20.0
    var whaleAttackSpeedKrill = 10.0
    var crabSpawnSpeed = 5.0
    var phase = 1
    var lastWaterWave = 0.0
    var spikeDamage = CGFloat(3)
    var waterWaveDamage = CGFloat(3)
    var oilWaveDamage = CGFloat(5)
    var krillDamage = CGFloat(1)
    var crabDamage = CGFloat(2)
    var lifeBuff = CGFloat(3)
    var speedBuff = CGFloat(25)
    var inking = false
    var inkingTimer = 0.0
    var buffSpawnSpeed = 30.0
    
    
    var theKraken: KrakenBoss?
    var theHero: HeroClass?
    var theWhale: WhaleBoss?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, 30))
        theHero!.setScale(0.6)
        self.addChild(theHero!)
        
        let lifeHeart = SKSpriteNode(imageNamed: "Life_Symbol_1")
        lifeHeart.position = CGPointMake(self.frame.maxX - 30, self.frame.maxY - 30)
        lifeHeart.name = "lifeheart"
        lifeHeart.setScale(0.15)
        self.addChild(lifeHeart)
        
        lifeNode = SKLabelNode(text: "\(Int(floor(theHero!.life!)))")
        lifeNode!.position = CGPointMake(self.frame.maxX - 30, self.frame.maxY - 35)
        lifeNode!.fontName = "ChalkboardSE-Bold"
        lifeNode!.fontSize = 16
        self.addChild(lifeNode!)
        
        theKraken = KrakenBoss.makeKraken(CGPointMake(self.frame.midX, self.frame.maxY + 200))
        theKraken!.size = CGSizeMake(150, 120)
        self.addChild(theKraken!)
        theWhale = WhaleBoss.makeWhale(CGPointMake(self.frame.midX, self.frame.maxY + 200))
        theWhale!.size = CGSizeMake(150, 120)
        self.addChild(theWhale!)
        //the below constraints did nothing
        //let distanceConstraint = SKConstraint.distance(SKRange(lowerLimit: 10), toNode: aWizard)
        //ourHero.constraints = [distanceConstraint]
        let background = SKSpriteNode(imageNamed: "Gauntlet_Background_1.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.name = "background"
        background.zPosition = -1
        self.addChild(background)
        self.physicsWorld.contactDelegate = self
        theHero!.updateStats()
        //*****REGENE CODE****
        maxLife = theHero!.life!
        maxSpeed = heroSpeed
        //********************
        
        //regen spinning clock
        let backTimer = SKSpriteNode(imageNamed: "Regen_Timer_1")
        backTimer.size = CGSizeMake(30, 30)
        backTimer.position = CGPointMake(self.frame.maxX - 70, self.frame.maxY - 30)
        backTimer.name = "backTimer"
        backTimer.zPosition = 2
        self.addChild(backTimer)
        let clockNode = SKSpriteNode(imageNamed: "Regen_Timer_2")
        clockNode.position = CGPointMake(self.frame.maxX - 70, self.frame.maxY - 30)
        clockNode.size = CGSizeMake(30, 30)
        clockNode.name = "regenClock"
        clockNode.zPosition = 3
        let spinAction = SKAction.rotateByAngle(2 * pi, duration: healSpeed)
        let repeatAction = SKAction.repeatActionForever(spinAction)
        clockNode.runAction(repeatAction)
        clockNode.zRotation = pi / 1.25
        self.addChild(clockNode)
        //********************
        
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
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategorySpike.rawValue){
                theHero!.takeDamage(spikeDamage)
                let fadeOut = SKAction.fadeOutWithDuration(1)
                let codeBlock = SKAction.runBlock({secondBody.node?.removeFromParent()})
                let sequence = SKAction.sequence([fadeOut, codeBlock])
                secondBody.node?.runAction(sequence)
        }
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryMiniCrab.rawValue){
                theHero!.takeDamage(crabDamage)
                let fadeOut = SKAction.fadeOutWithDuration(1)
                let codeBlock = SKAction.runBlock({secondBody.node?.removeFromParent()})
                let sequence = SKAction.sequence([fadeOut, codeBlock])
                secondBody.node?.runAction(sequence)
        }
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryKrill.rawValue){
                theHero!.takeDamage(krillDamage)
                let fadeOut = SKAction.fadeOutWithDuration(1)
                let codeBlock = SKAction.runBlock({secondBody.node?.removeFromParent()})
                let sequence = SKAction.sequence([fadeOut, codeBlock])
                secondBody.node?.runAction(sequence)
        }
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryBuff.rawValue){
                if (secondBody.node as! BuffSpawn).buffType == 1 {
                    //life
                    theHero!.life! += lifeBuff
                    if theHero!.life! > maxLife {
                        theHero!.life = maxLife
                    }
                    let fadeOut = SKAction.fadeOutWithDuration(1)
                    let codeBlock = SKAction.runBlock({secondBody.node?.removeFromParent()})
                    let sequence = SKAction.sequence([fadeOut, codeBlock])
                    secondBody.node?.runAction(sequence)
                } else if (secondBody.node as! BuffSpawn).buffType == 2 {
                    //movespeed
                    heroSpeed += 30
                    let waitAction = SKAction.waitForDuration(4)
                    let runBlock = SKAction.runBlock({heroSpeed -= 30})
                    let asequence = SKAction.sequence([waitAction, runBlock])
                    self.runAction(asequence)
                    
                    let fadeOut = SKAction.fadeOutWithDuration(1)
                    let codeBlock = SKAction.runBlock({secondBody.node?.removeFromParent()})
                    let sequence = SKAction.sequence([fadeOut, codeBlock])
                    secondBody.node?.runAction(sequence)
                } else {
                    //killAll
                    
                    for node in self.children {
                        if (node as? SKSpriteNode != nil) && node.name != "background" && node.name != "item" && node.name != "hero" && node.name != "bomber" && node.name != "whale" && node.name != "kraken" && node.name != "life" && node.name != "gold" && node.name != "chest" && node.name != "lifeheart" && node.name != "regenClock"{
                            let fadeOut = SKAction.fadeOutWithDuration(1)
                            let codeBlock = SKAction.runBlock({node.removeFromParent()})
                            let sequence = SKAction.sequence([fadeOut, codeBlock])
                            node.runAction(sequence)
                        }
                    }
                    let fadeOut = SKAction.fadeOutWithDuration(1)
                    let codeBlock = SKAction.runBlock({secondBody.node?.removeFromParent()})
                    let sequence = SKAction.sequence([fadeOut, codeBlock])
                    secondBody.node?.runAction(sequence)
                }
                secondBody.node?.removeFromParent()
        }
        //HERO VS SEASHELL
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryWave.rawValue){
                if (secondBody.node as? WaveNode != nil){
                    theHero!.takeDamage(waterWaveDamage)
                }else{
                    if !self.childNodeWithName("safeSpot1")!.containsPoint(theHero!.position){
                        theHero!.takeDamage(oilWaveDamage)
                    }
                }
        }
        
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let aHero = self.childNodeWithName("hero") as! HeroClass
        let aKraken = self.childNodeWithName("kraken") as! KrakenBoss
        for touch in touches{
            aHero.moveHelper((touch as! UITouch).locationInNode(self))
        }
    }
    
    
    func updateLevel() {
        phase += 1
        
        //Phase Transition
        var phaseText = SKSpriteNode()
        phaseText.size = CGSizeMake(200, 70)
        phaseText.position = CGPointMake(self.frame.midX, self.frame.midY)
        phaseText.name = "phaseText"
        let runBlock = SKAction.runBlock({phaseText.removeFromParent()})
        let runBlock2 = SKAction.runBlock({phaseText.texture = SKTexture(imageNamed: "Phase_\(self.phase)_Text")})
        let waitAction = SKAction.waitForDuration(3)
        let waitAction2 = SKAction.waitForDuration(5)
        let sequence = SKAction.sequence([waitAction2, runBlock2, waitAction, runBlock])
        self.addChild(phaseText)
        phaseText.runAction(sequence)
        
        
        //Balance Stuff
        krakenAttackSpeed -= 0.5
        krakenAttackSpeedSpike -= 0.5
        whaleAttackSpeedKrill -= 0.5
        whaleAttackSpeedWave -= 0.5
        crabSpawnSpeed -= 0.5
        if phase % 5 == 0{
            spikeDamage += 3
            waterWaveDamage += 3
            oilWaveDamage += 5
            krillDamage += 1
            crabDamage += 1
            buffSpawnSpeed -= 1
        }
        
    }
    
    func addRandomBuff(){
        //generate random position and type
        let randX = randomWithMin(40, Int(self.frame.maxX - 40))
        let randY = randomWithMin(40, Int(self.frame.maxY - 140))
        let type = randomWithMin(1, 3)
        let buff = BuffSpawn.buffAtPos(CGPointMake(CGFloat(randX), CGFloat(randY)), type: type)
        let fadeInAction = SKAction.fadeInWithDuration(1)
        let waitAction = SKAction.waitForDuration(10)
        let removeBlock = SKAction.runBlock({buff.removeFromParent()})
        self.addChild(buff)
        let sequence = SKAction.sequence([fadeInAction, waitAction, removeBlock])
        buff.runAction(sequence)
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.lastUpdatesTime = currentTime
            self.lastWaterWave = currentTime
            self.lastTentacle = currentTime
            self.lastWave = currentTime
        }
        self.totalGameTime += currentTime - self.lastUpdatesTime
        
        if currentTime - lastWave  > 45{
            for node in self.children{
                if let aNode = node as? SKSpriteNode{
                    if aNode.name == "safeSpot1" || aNode.name == "safeSpot2" || aNode.name == "crab" || aNode.name == "krill" || aNode.name == "wave" || aNode.name == "tentacle"{
                        aNode.removeFromParent()
                    }
                }
            }
            self.lastWave = currentTime
            theKraken!.createSafeAndWave()
            updateLevel()
            inking = true
            inkingTimer = currentTime
        }
        
        if inking && currentTime - inkingTimer > 5{
            inking = false
            for node in self.children{
                if let aNode = node as? SKSpriteNode{
                    if aNode.name == "safeSpot1" || aNode.name == "safeSpot2" {
                        aNode.removeFromParent()
                    }
                }
            }
        }
        
        if currentTime - lastTentacle  > krakenAttackSpeedSpike && !levelOver && !inking{
            self.lastTentacle = currentTime
            theKraken!.throwTentacle()
        }
        
        if currentTime - lastBuff  > buffSpawnSpeed && !levelOver && !inking{
            self.lastBuff = currentTime
            if phase > 4{
                addRandomBuff()
            }
        }
        
        if currentTime - lastKrill  > whaleAttackSpeedKrill && !levelOver && !inking{
            self.lastKrill = currentTime
            theWhale!.shootKrill()
        }
        
        if currentTime - lastWaterWave  > whaleAttackSpeedWave && !levelOver && !inking{
            self.lastWaterWave = currentTime
            let yValue = randomWithMin(Int(self.frame.minY + 100), Int(self.frame.maxY - 175))
            let xBool = randomWithMin(0, 10)
            var xValue = self.frame.maxX + 20
            if xBool < 5 {
                xValue = -20
            }
            theWhale!.throwWave(CGPointMake(xValue, CGFloat(yValue)))
        }
        
        
        if (currentTime - lastCrab > crabSpawnSpeed && !self.levelOver && !inking) {
            var xMatch = CGFloat(randomWithMin(Int(self.frame.minX + 80), Int(self.frame.maxX - 80)))
            self.addChild(MiniCrab.crabDash(CGPointMake(xMatch, self.frame.maxY + 30), endPosition: CGPointMake(xMatch, self.frame.minY)))
            
            
            self.lastCrab = currentTime
        }
        
        
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
        lifeNode!.text = "\(Int(floor(theHero!.life!)))"
        //***************
        
        //check for win condition
        if (theKraken!.isDead || theHero!.life <= 0) && !levelOver{
            if (self.childNodeWithName("item") == nil && droppedItem) || theHero!.life <= 0{
                let skTransition = SKTransition.fadeWithDuration(5.0)
                self.view?.presentScene(self.userData?.objectForKey("menu") as! MainMenuScene, transition: skTransition)
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil){
                if theKraken!.isDead{
                    dropLoot("world1level30", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
                    droppedItem = true
                }
            }
        }
    }
}

