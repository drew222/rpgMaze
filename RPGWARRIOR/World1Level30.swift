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
    var lastBeachball = 0.0
    var lastCoin = 0.0
    
    var levelOver = false
    let levelName = "world1level30"
    var droppedItem = false
    var droppedChest = false
    var splatted = false
    var firstEndless = true
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
    var crabAttackSpeed = 11.0
    var crabSpawnSpeed = 5.0
    var phase = 0
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
    var coinSpawnSpeed = 14.0
    var coinAmount = 1.0
    var itemDropped: ItemClass?
    
    
    
    var theKraken: KrakenBoss?
    var theHero: HeroClass?
    var theWhale: WhaleBoss?
    var theCrab: BomberClass?
    
    var persistentData: UserDefaults?
    
    override func didMove(to view: SKView) {
        persistentData = UserDefaults.standard
        
        if soundOn{
            gauntletMusic!.play()
        }
        /* Setup your scene here */
        theHero = HeroClass.makeHero(position: CGPointMake(self.frame.midX, 30))
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
        
        theKraken = KrakenBoss.makeKraken(position: CGPointMake(self.frame.midX, self.frame.maxY + 200))
        theKraken!.size = CGSizeMake(150, 120)
        self.addChild(theKraken!)
        theWhale = WhaleBoss.makeWhale(position: CGPointMake(self.frame.midX, self.frame.maxY + 200))
        theWhale!.size = CGSizeMake(150, 120)
        self.addChild(theWhale!)
        theCrab = BomberClass.makeBomber(position: CGPointMake(self.frame.midX, self.frame.maxY + 200))
        theCrab!.size = CGSizeMake(150, 120)
        self.addChild(theCrab!)
        //the below constraints did nothing
        //let distanceConstraint = SKConstraint.distance(SKRange(lowerLimit: 10), toNode: aWizard)
        //ourHero.constraints = [distanceConstraint]
        let background = SKSpriteNode(imageNamed: "Gauntlet_Background_1.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.name = "background"
        background.zPosition = -1
        self.addChild(background)
        let runGauntlet = SKSpriteNode(imageNamed: "Run_The_Gauntlet_Text.png")
        runGauntlet.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 75)
        runGauntlet.size = CGSizeMake(280, 40)
        runGauntlet.name = "runGauntlet"
        runGauntlet.zPosition = 3
        self.addChild(runGauntlet)
        let waitAction = SKAction.wait(forDuration: 2)
        let waitToFadeOut = SKAction.wait(forDuration: 1.5)
        let fadeOut = SKAction.fadeOut(withDuration: 3)
        let runBlock = SKAction.run({runGauntlet.removeFromParent()})
        let sequence = SKAction.sequence([waitToFadeOut, fadeOut, waitAction, runBlock])
        runGauntlet.run(sequence)
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
        let spinAction = SKAction.rotate(byAngle: 2 * pi, duration: healSpeed)
        let repeatAction = SKAction.repeatForever(spinAction)
        clockNode.run(repeatAction)
        clockNode.zRotation = pi / 1.25
        self.addChild(clockNode)
        //********************
        
        //Regen Amount behind clock
        let regenAmount = SKLabelNode(text: "\(Int(theHero!.regeneration!))")
        regenAmount.position = CGPointMake(self.frame.maxX - 70, self.frame.maxY - 35)
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
        
        
        //maxLife = 100000
        //theHero!.life! = 100000
        
        //******CHECKPOINT FROM GEAR CHECK*****
        let checkPoint = SKSpriteNode(imageNamed: "Checkpoint_Text_1")
        checkPoint.position = CGPointMake(self.frame.midX, self.frame.midY + 150)
        checkPoint.size = CGSizeMake(300, 75)
        let afadeOut = SKAction.fadeOut(withDuration: 1)
        let aRunBlock = SKAction.run({checkPoint.removeFromParent()})
        let aSequence = SKAction.sequence([afadeOut, aRunBlock])
        checkPoint.run(aSequence)
        if theHero!.life! > 128 {
            let phaseText = SKSpriteNode()
            phaseText.size = CGSizeMake(240, 60)
            phaseText.position = CGPointMake(self.frame.midX, self.frame.midY)
            phaseText.name = "phaseText"
            let runBlock = SKAction.run({phaseText.removeFromParent()})
            let runBlock2 = SKAction.run({phaseText.texture = SKTexture(imageNamed: "Phase_\(self.phase)_Text")})
            let waitAction = SKAction.wait(forDuration: 3)
            let waitAction2 = SKAction.wait(forDuration: 5)
            let sequence = SKAction.sequence([waitAction2, runBlock2, waitAction, runBlock])
            self.addChild(phaseText)
            phaseText.run(sequence)
            self.addChild(checkPoint)
            phase = 40
        }else if theHero!.life! > 63{
            let phaseText = SKSpriteNode()
            phaseText.size = CGSizeMake(240, 60)
            phaseText.position = CGPointMake(self.frame.midX, self.frame.midY)
            phaseText.name = "phaseText"
            let runBlock = SKAction.run({phaseText.removeFromParent()})
            let runBlock2 = SKAction.run({phaseText.texture = SKTexture(imageNamed: "Phase_\(self.phase)_Text")})
            let waitAction = SKAction.wait(forDuration: 3)
            let waitAction2 = SKAction.wait(forDuration: 5)
            let sequence = SKAction.sequence([waitAction2, runBlock2, waitAction, runBlock])
            self.addChild(phaseText)
            phaseText.run(sequence)
            self.addChild(checkPoint)
            phase = 30
        }else if theHero!.life! > 31{
            let phaseText = SKSpriteNode()
            phaseText.size = CGSizeMake(240, 60)
            phaseText.position = CGPointMake(self.frame.midX, self.frame.midY)
            phaseText.name = "phaseText"
            let runBlock = SKAction.run({phaseText.removeFromParent()})
            let runBlock2 = SKAction.run({phaseText.texture = SKTexture(imageNamed: "Phase_\(self.phase)_Text")})
            let waitAction = SKAction.wait(forDuration: 3)
            let waitAction2 = SKAction.wait(forDuration: 5)
            let sequence = SKAction.sequence([waitAction2, runBlock2, waitAction, runBlock])
            self.addChild(phaseText)
            phaseText.run(sequence)
            self.addChild(checkPoint)
            phase = 20
        }else if theHero!.life! > 15{
            let phaseText = SKSpriteNode()
            phaseText.size = CGSizeMake(240, 60)
            phaseText.position = CGPointMake(self.frame.midX, self.frame.midY)
            phaseText.name = "phaseText"
            let runBlock = SKAction.run({phaseText.removeFromParent()})
            let runBlock2 = SKAction.run({phaseText.texture = SKTexture(imageNamed: "Phase_\(self.phase)_Text")})
            let waitAction = SKAction.wait(forDuration: 3)
            let waitAction2 = SKAction.wait(forDuration: 5)
            let sequence = SKAction.sequence([waitAction2, runBlock2, waitAction, runBlock])
            self.addChild(phaseText)
            phaseText.run(sequence)
            self.addChild(checkPoint)
            phase = 10
        }
        
        //*************************************
        //phase = 49
        updateLevel()
        //test
        //theHero!.life = 99999
        
        
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
            theHero!.takeDamage(damage: spikeDamage)
            let fadeOut = SKAction.fadeOut(withDuration: 1)
            let codeBlock = SKAction.run({secondBody.node?.removeFromParent()})
                let sequence = SKAction.sequence([fadeOut, codeBlock])
                secondBody.categoryBitMask = 99999
            secondBody.node?.run(sequence)
        }
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryMiniCrab.rawValue){
            theHero!.takeDamage(damage: crabDamage)
            let fadeOut = SKAction.fadeOut(withDuration: 1)
            let codeBlock = SKAction.run({secondBody.node?.removeFromParent()})
                let sequence = SKAction.sequence([fadeOut, codeBlock])
                secondBody.categoryBitMask = 99999
            secondBody.node?.run(sequence)
        }
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryKrill.rawValue){
            theHero!.takeDamage(damage: krillDamage)
            let fadeOut = SKAction.fadeOut(withDuration: 1)
            let codeBlock = SKAction.run({secondBody.node?.removeFromParent()})
                let sequence = SKAction.sequence([fadeOut, codeBlock])
                secondBody.categoryBitMask = 99999
            secondBody.node?.run(sequence)
        }
        
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryCoin.rawValue){
                if soundOn {
                    self.run(bootySound)
                }
            (self.userData?.object(forKey: "inventory") as! Inventory).gold += CGFloat(coinAmount)
            persistentData!.set((self.userData?.object(forKey: "inventory") as! Inventory).gold, forKey: "gold")
            let fadeOut = SKAction.fadeOut(withDuration: 0.2)
            let codeBlock = SKAction.run({secondBody.node?.removeFromParent()})
                let sequence = SKAction.sequence([fadeOut, codeBlock])
                secondBody.categoryBitMask = 99999
            secondBody.node?.run(sequence)
        }
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryBuff.rawValue){
                if (secondBody.node as! BuffSpawn).buffType == 1 {
                    //life
                    if soundOn {
                        self.run(buffSound)
                    }
                    theHero!.life! += lifeBuff
                    if theHero!.life! > maxLife {
                        theHero!.life = maxLife
                    }
                    let fadeOut = SKAction.fadeOut(withDuration: 0.2)
                    let codeBlock = SKAction.run({secondBody.node?.removeFromParent()})
                    let sequence = SKAction.sequence([fadeOut, codeBlock])
                    secondBody.node?.run(sequence)
                } else if (secondBody.node as! BuffSpawn).buffType == 2 {
                    if soundOn {
                        self.run(speedSound)
                    }
                    //movespeed
                    heroSpeed += 30
                    let waitAction = SKAction.wait(forDuration: 4)
                    let runBlock = SKAction.run({heroSpeed -= 30})
                    let asequence = SKAction.sequence([waitAction, runBlock])
                    self.run(asequence)
                    
                    let fadeOut = SKAction.fadeOut(withDuration: 0.2)
                    let codeBlock = SKAction.run({secondBody.node?.removeFromParent()})
                    let sequence = SKAction.sequence([fadeOut, codeBlock])
                    secondBody.node?.run(sequence)
                } else {
                    //killAll
                    if soundOn {
                        self.run(fireworksSound)
                    }
                    for node in self.children {
                        if (node as? SKEmitterNode != nil){
                            node.removeFromParent()
                        }
                        if (node as? SKSpriteNode != nil) && node.name != "background" && node.name != "item" && node.name != "hero" && node.name != "bomber" && node.name != "whale" && node.name != "kraken" && node.name != "life" && node.name != "gold" && node.name != "chest" && node.name != "lifeheart" && node.name != "regenClock" && node.name != "coin"{
                            let fadeOut = SKAction.fadeOut(withDuration: 0.1)
                            let codeBlock = SKAction.run({node.removeFromParent()})
                            let sequence = SKAction.sequence([fadeOut, codeBlock])
                            if node.name == "bomb" {
                                node.removeAllActions()
                            }
                            node.run(sequence)
                        }
                    }
                    let fadeOut = SKAction.fadeOut(withDuration: 0.2)
                    let codeBlock = SKAction.run({secondBody.node?.removeFromParent()})
                    let sequence = SKAction.sequence([fadeOut, codeBlock])
                    secondBody.node?.run(sequence)
                }
                secondBody.node?.removeFromParent()
        }
        //HERO VS SEASHELL
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryWave.rawValue){
                if (secondBody.node as? WaveNode != nil){
                    theHero!.takeDamage(damage: waterWaveDamage)
                    let fadeOut = SKAction.fadeOut(withDuration: 1)
                    let codeBlock = SKAction.run({secondBody.node?.removeFromParent()})
                    let sequence = SKAction.sequence([fadeOut, codeBlock])
                    secondBody.categoryBitMask = 99999
                    secondBody.node?.run(sequence)
                }else{
                    if !self.childNode(withName: "safeSpot1")!.contains(theHero!.position){
                        theHero!.takeDamage(damage: oilWaveDamage)
                    }
                }
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        let aHero = self.childNode(withName: "hero") as! HeroClass
        for touch in touches{
            aHero.moveHelper(position: (touch ).location(in: self))
        }
    }
    
    
    func updateLevel() {
        phase == 49
        if phase < 51{
            phase += 1
        }
    
        
        //Phase Transition
        let phaseText = SKSpriteNode()
        phaseText.size = CGSizeMake(240, 60)
        phaseText.position = CGPointMake(self.frame.midX, self.frame.midY)
        phaseText.name = "phaseText"
        let runBlock = SKAction.run({phaseText.removeFromParent()})
        let runBlock2 = SKAction.run({phaseText.texture = SKTexture(imageNamed: "Phase_\(self.phase)_Text")})
        let waitAction = SKAction.wait(forDuration: 3)
        let waitAction2 = SKAction.wait(forDuration: 5)
        let sequence = SKAction.sequence([waitAction2, runBlock2, waitAction, runBlock])
        if phase < 51{
            self.addChild(phaseText)
        }
        phaseText.run(sequence)
        
        
        
        //Balance Speed Stuff
        if phase < 51 {
        if phase % 10 == 1{
            crabSpawnSpeed = 0.2
            buffSpawnSpeed = 10
            if is5 {
                crabSpawnSpeed = 0.22
            }
            if isPad {
                crabSpawnSpeed = 0.26
            }
        }else if phase % 10 == 2{
            whaleAttackSpeedKrill = 2
            crabSpawnSpeed = 0.4
            buffSpawnSpeed = 10
            if is5 {
                crabSpawnSpeed = 0.45
            }
            if isPad {
                crabSpawnSpeed = 0.5
            }
        }else if phase % 10 == 3{
            whaleAttackSpeedKrill = 2.3
            whaleAttackSpeedWave = 15
            crabSpawnSpeed = 0.4
            buffSpawnSpeed = 10
            if is5 {
                crabSpawnSpeed = 0.45
            }
            if isPad {
                crabSpawnSpeed = 0.5
            }
        }else if phase % 10 == 4{
            whaleAttackSpeedKrill = 2.8
            whaleAttackSpeedWave = 15
            crabSpawnSpeed = 0.5
            crabAttackSpeed = 1.5
            buffSpawnSpeed = 10
            if is5 {
                crabSpawnSpeed = 0.55
            }
            if isPad {
                crabSpawnSpeed = 0.6
            }
        }else if phase % 10 == 5{
            krakenAttackSpeedSpike = 10.0
            whaleAttackSpeedKrill = 3.1
            whaleAttackSpeedWave = 15
            crabSpawnSpeed = 0.5
            crabAttackSpeed = 2.0
            buffSpawnSpeed = 10
            if is5 {
                crabSpawnSpeed = 0.55
                krakenAttackSpeedSpike = 11.0
            }
            if isPad {
                crabSpawnSpeed = 0.6
                krakenAttackSpeedSpike = 13.0
            }
        }else if phase % 10 == 6{
            krakenAttackSpeedSpike = 9.5
            whaleAttackSpeedKrill = 3.0
            whaleAttackSpeedWave = 13
            crabSpawnSpeed = 0.5
            crabAttackSpeed = 1.9
            buffSpawnSpeed = 9
            if is5 {
                crabSpawnSpeed = 0.55
                krakenAttackSpeedSpike = 10.5
            }
            if isPad {
                crabSpawnSpeed = 0.6
                krakenAttackSpeedSpike = 12.5
            }
        }else if phase % 10 == 7{
            krakenAttackSpeedSpike = 9.5
            whaleAttackSpeedKrill = 2.8
            whaleAttackSpeedWave = 12
            crabSpawnSpeed = 0.4
            crabAttackSpeed = 1.8
            buffSpawnSpeed = 8
            if is5 {
                crabSpawnSpeed = 0.55
                krakenAttackSpeedSpike = 10.5
            }
            if isPad {
                crabSpawnSpeed = 0.6
                krakenAttackSpeedSpike = 12.5
            }
        }else if phase % 10 == 8{
            krakenAttackSpeedSpike = 9.5
            whaleAttackSpeedKrill = 2.5
            whaleAttackSpeedWave = 11
            crabSpawnSpeed = 0.4
            crabAttackSpeed = 1.7
            buffSpawnSpeed = 8
            if is5 {
                crabSpawnSpeed = 0.55
                krakenAttackSpeedSpike = 10.5
            }
            if isPad {
                crabSpawnSpeed = 0.6
                krakenAttackSpeedSpike = 12.5
            }
        }else if phase % 10 == 9{
            krakenAttackSpeedSpike = 9.5
            whaleAttackSpeedKrill = 2.3
            whaleAttackSpeedWave = 10
            crabSpawnSpeed = 0.4
            crabAttackSpeed = 1.6
            buffSpawnSpeed = 7
            if is5 {
                crabSpawnSpeed = 0.55
                krakenAttackSpeedSpike = 10.5
            }
            if isPad {
                crabSpawnSpeed = 0.6
                krakenAttackSpeedSpike = 12.5
            }
        }else if phase % 10 == 0{
            krakenAttackSpeedSpike = 9.5
            whaleAttackSpeedKrill = 2.3
            whaleAttackSpeedWave = 9
            crabSpawnSpeed = 0.4
            crabAttackSpeed = 1.5
            buffSpawnSpeed = 7
            if is5 {
                crabSpawnSpeed = 0.55
                krakenAttackSpeedSpike = 10.5
            }
            if isPad {
                crabSpawnSpeed = 0.6
                krakenAttackSpeedSpike = 12.5
            }
        }
        }else{
            //if first level 51, say infinite level
            if firstEndless {
                let infText = SKSpriteNode(imageNamed: "Endless_Mode_Text")
                infText.position = CGPointMake(self.frame.midX, self.frame.midY)
                infText.setScale(0.28)
                infText.name = "infText"
                infText.run(SKAction.fadeOut(withDuration: 0))
                let wait = SKAction.wait(forDuration: 2)
                let wait2 = SKAction.wait(forDuration: 1)
                let fadeInAction = SKAction.fadeIn(withDuration: 1)
                _ = SKAction.run({infText.removeFromParent()})
                let runBlock = SKAction.run({infText.removeFromParent()})
                let sequence = SKAction.sequence([wait2, fadeInAction, wait, runBlock])
                infText.run(sequence)
                self.addChild(infText)
                firstEndless = false
            }
            //infinit level here
            krakenAttackSpeedSpike -= 0.1
            whaleAttackSpeedKrill -= 0.1
            whaleAttackSpeedWave -= 0.1
            crabSpawnSpeed -= 0.01
            crabAttackSpeed -= 0.02
            buffSpawnSpeed = 7
            
        }
        
        
        //Damages
        spikeDamage = CGFloat(4)
        waterWaveDamage = CGFloat(8)
        oilWaveDamage = CGFloat(150)
        krillDamage = CGFloat(1)
        crabDamage = CGFloat(2)
        lifeBuff = CGFloat(13)
        speedBuff = CGFloat(40)
        coinAmount = 1
        _ = false
        if phase > 10 {
            /*
            if test{
                theHero!.life = 16
                maxLife = 16
                theHero!.regeneration = 9
                heroSpeed = 160
            }*/
            spikeDamage = CGFloat(8)
            waterWaveDamage = CGFloat(10)
            oilWaveDamage = CGFloat(150)
            krillDamage = CGFloat(2)
            crabDamage = CGFloat(3)
            lifeBuff = CGFloat(16)
            speedBuff = CGFloat(50)
            coinAmount = 2
        }
        if phase > 20 {
            /*
            if test{
                theHero!.life = 32
                maxLife = 32
                theHero!.regeneration = 10
                heroSpeed = 168
            }*/
            spikeDamage = CGFloat(16)
            waterWaveDamage = CGFloat(20)
            oilWaveDamage = CGFloat(150)
            krillDamage = CGFloat(3)
            crabDamage = CGFloat(6)
            lifeBuff = CGFloat(32)
            speedBuff = CGFloat(60)
            coinAmount = 3
        }
        if phase > 30 {
            /*
            if test{
                theHero!.life = 64
                maxLife = 64
                theHero!.regeneration = 16
                heroSpeed = 180
            }*/
            spikeDamage = CGFloat(32)
            waterWaveDamage = CGFloat(40)
            oilWaveDamage = CGFloat(150)
            krillDamage = CGFloat(7)
            crabDamage = CGFloat(13)
            lifeBuff = CGFloat(64)
            speedBuff = CGFloat(70)
            coinAmount = 4
        }
        if phase > 40 {
            /*
            if test{
                theHero!.life = 130
                maxLife = 130
                theHero!.regeneration = 25
                heroSpeed = 200
                coinAmount = 5
            }*/
            spikeDamage = CGFloat(64)
            waterWaveDamage = CGFloat(80)
            oilWaveDamage = CGFloat(150)
            krillDamage = CGFloat(15)
            crabDamage = CGFloat(30)
            lifeBuff = CGFloat(150)
            speedBuff = CGFloat(80)
        }

        
    }
    
    func addRandomBuff(){
        //generate random position and type
        let randX = randomWithMin(min: 40, max: Int(self.frame.maxX - 40))
        let randY = randomWithMin(min: 40, max: Int(self.frame.maxY - 140))
        let type = randomWithMin(min: 1, max: 4)
        let buff = BuffSpawn.buffAtPos(position: CGPointMake(CGFloat(randX), CGFloat(randY)), type: type)
        let fadeInAction = SKAction.fadeIn(withDuration: 1)
        let waitAction = SKAction.wait(forDuration: 5)
        let removeBlock = SKAction.run({buff.removeFromParent()})
        self.addChild(buff)
        let sequence = SKAction.sequence([fadeInAction, waitAction, removeBlock])
        buff.run(sequence)
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.lastUpdatesTime = currentTime
            self.lastWaterWave = currentTime
            self.lastTentacle = currentTime
            self.lastWave = currentTime
            self.lastCoin = currentTime
            self.lastBuff = currentTime
        }
        if !droppedChest{
            self.totalGameTime += currentTime - self.lastUpdatesTime
        }
        
        if currentTime - lastWave  > 45 && !droppedChest{
            for node in self.children{
                if node as? SKEmitterNode != nil {
                    node.removeFromParent()
                }
                if let aNode = node as? SKSpriteNode{
                    if aNode.name == "safeSpot1" || aNode.name == "safeSpot2" || aNode.name == "crab" || aNode.name == "krill" || aNode.name == "wave" || aNode.name == "tentacle" || aNode.name == "bomb" || aNode.name == "coin" || aNode.name == "buff"{
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
        
        if inking && currentTime - inkingTimer > 5 && !droppedChest{
            inking = false
            for node in self.children{
                if let aNode = node as? SKSpriteNode{
                    if aNode.name == "safeSpot1" || aNode.name == "safeSpot2" {
                        aNode.removeFromParent()
                    }
                }
            }
        }
        
        if currentTime - lastTentacle  > krakenAttackSpeedSpike && !levelOver && !inking && ((phase % 10 == 5) || (phase % 10 == 6) || (phase % 10 == 7) || (phase % 10 == 8) || (phase % 10 == 9) || (phase % 10 == 0) || (phase == 51)) && !droppedChest{
            self.lastTentacle = currentTime
            theKraken!.throwTentacle()
        }
        
        if currentTime - lastBuff  > buffSpawnSpeed && !levelOver && !inking && !droppedChest{
            self.lastBuff = currentTime
            //if phase > 4{
                addRandomBuff()
            //}
        }
        
        if currentTime - lastKrill  > whaleAttackSpeedKrill && !levelOver && !inking && ((phase % 10 == 2) || (phase % 10 == 3)  || (phase % 10 == 4) || (phase % 10 == 5) || (phase % 10 == 6)  || (phase % 10 == 7) || (phase % 10 == 8) || (phase % 10 == 9)  || (phase % 10 == 0) || (phase == 51)) && !droppedChest{
            self.lastKrill = currentTime
            theWhale!.shootKrill()
        }
        
        if currentTime - lastBeachball  > crabAttackSpeed && !levelOver && !inking && ((phase % 10 == 4) || (phase % 10 == 5) || (phase % 10 == 6)  || (phase % 10 == 7) || (phase % 10 == 8) || (phase % 10 == 9)  || (phase % 10 == 0) || (phase == 51)) && !droppedChest{
            self.lastBeachball = currentTime
            theCrab!.throwBomb()
        }
        
        if currentTime - lastWaterWave  > whaleAttackSpeedWave && !levelOver && !inking  && ((phase % 10 == 3) || (phase % 10 == 4) || (phase % 10 == 5)  || (phase % 10 == 6) || (phase % 10 == 7) || (phase % 10 == 8)  || (phase % 10 == 9) || (phase % 10 == 0) || (phase == 51)) && !droppedChest{
            self.lastWaterWave = currentTime
            let yValue = randomWithMin(min: Int(self.frame.minY + 100), max: Int(self.frame.maxY - 175))
            let xBool = randomWithMin(min: 0, max: 10)
            var xValue = self.frame.maxX + 20
            if xBool < 5 {
                xValue = -20
            }
            theWhale!.throwWave(gapPosition: CGPointMake(xValue, CGFloat(yValue)))
        }
        
        
        if (currentTime - lastCrab > crabSpawnSpeed && !self.levelOver && !inking && !droppedChest) {
            let xMatch = CGFloat(randomWithMin(min: Int(10), max: Int(self.frame.maxX - 10)))
            self.addChild(MiniCrab.crabDash(startPos: CGPointMake(xMatch, self.frame.maxY + 30), endPosition: CGPointMake(xMatch, self.frame.minY)))
            
            
            self.lastCrab = currentTime
        }
        
        if (currentTime - lastCoin > coinSpawnSpeed && !self.levelOver && !inking && !droppedChest) {
            let xCoin = CGFloat(randomWithMin(min: Int(20), max: Int(self.frame.maxX - 20)))
            let yCoin = CGFloat(randomWithMin(min: Int(20), max: Int(self.frame.maxY - 50)))
            self.addChild(CoinNode.coinAtPos(position: CGPointMake(xCoin, yCoin)))
            
            
            self.lastCoin = currentTime
        }
        
        //add Timer if above level 50
        if phase == 51{
            if let timer = self.childNode(withName: "timer") as? SKLabelNode{
                if !droppedChest{
                    timer.text = "Time  \(Int(round(self.totalGameTime)))"
                }
            }else{
                self.totalGameTime = 0.0
                let aTimer = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
                aTimer.text = "Time: \(Int(round(self.totalGameTime)))"
                aTimer.name = "timer"
                aTimer.position = CGPointMake(self.frame.maxX - 70, 15)
                aTimer.fontSize = 20
                aTimer.fontColor = UIColor.black
                self.addChild(aTimer)
            }
        }
        
        
        //******REGEN CODE
        if currentTime - lastHeal  > healSpeed && theHero!.life! > 0{
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
        lifeNode!.text = "\(Int(floor(theHero!.life!)))"
        //***************
        
        //check for win condition
        if (theHero!.life! <= 0){
            if !splatted {
                
                if soundOn{
                    gauntletMusic!.stop()
                    let waitDuration = SKAction.wait(forDuration: 1)
                    let runBlock = SKAction.run({beachMusic!.play()})
                    let sequence = SKAction.sequence([waitDuration, runBlock])
                    self.run(sequence)
                }
                
                splatted = true
                let splat = SKSpriteNode(imageNamed: "Ink_Splat_2")
                splat.size = CGSizeMake(70, 70)
                splat.name = "deathSplat"
                splat.position = theHero!.position
                self.addChild(splat)
                theHero!.removeAction(forKey: "runAction")
                theHero!.removeAction(forKey: "repeatAction")
                theHero!.run(SKAction.fadeOut(withDuration: 0))
                theHero!.position = CGPointMake(self.frame.midX, 100)
                theHero!.run(SKAction.fadeIn(withDuration: 2))
            }
            if (self.childNode(withName: "item") == nil && self.childNode(withName: "gold") == nil && droppedItem && !levelOver){
                //ITEM DISPLAY***************
                let skTransition = SKTransition.fade(withDuration: 1.0)
                let itemDisplayScene = ItemDisplayScene(size: self.frame.size)
                if itemDropped != nil{
                    itemDisplayScene.itemName = itemDropped!.itemName!
                }else{
                    itemDisplayScene.itemName = "Booty_1"
                    itemDisplayScene.numBooty = 30
                }
                itemDisplayScene.userData = NSMutableDictionary()
                itemDisplayScene.userData?.setObject(self.userData?.object(forKey: "menu") as! MainMenuScene, forKey: "menu" as NSCopying)
                itemDisplayScene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                self.view?.presentScene(itemDisplayScene, transition: skTransition)
                //***************************
                levelOver = true
            }
            else if (self.childNode(withName: "item") == nil && self.childNode(withName: "gold") == nil && !levelOver){
                if droppedChest && (self.childNode(withName: "chest") as! TreasureChest).open{
                    dropLoot(level: "phase\(phase)", scene: self, position: CGPointMake(self.frame.midX, self.frame.midY), size: CGSizeMake(30, 30))
                    droppedItem = true
                    itemDropped = self.childNode(withName: "item") as? ItemClass
                }else if !droppedChest {
                    for node in self.children{
                        if (node as? SKEmitterNode != nil) && node.name != "inkAttack"{
                            node.removeFromParent()
                        }
                        if (node as? SKSpriteNode != nil) && node.name != "background" && node.name != "item" && node.name != "hero" && node.name != "bomber" && node.name != "kraken" && node.name != "wizard" && node.name != "whale" && node.name != "life" && node.name != "gold" && node.name != "chest" && node.name != "lifeheart" && node.name != "regenClock" && node.name != "deathSplat"{
                            node.removeFromParent()
                        }
                    }
                    self.childNode(withName: "lifeNumber")?.removeFromParent()
                    self.addChild(TreasureChest.chestAtPosition(position: CGPointMake(self.frame.midX, self.frame.midY)))
                    droppedChest = true
                    
                    //set the highest phase in data and main menu
                    if (self.userData?.object(forKey: "menu") as! MainMenuScene).highestLevel < (30 + phase){
                        (self.userData?.object(forKey: "menu") as! MainMenuScene).highestLevel = 30 + phase
                        let persistentData = UserDefaults.standard
                        persistentData.set(30 + phase, forKey: "highestLevel")
                    }
                    if phase == 51 {
                        if (self.userData?.object(forKey: "menu") as! MainMenuScene).highestTime < round(totalGameTime){
                            (self.userData?.object(forKey: "menu") as! MainMenuScene).highestTime = round(totalGameTime)
                            let persistentData = UserDefaults.standard
                            persistentData.set(round(totalGameTime), forKey: "highestTime")
                        }
                    }
                }
            
            }
        }
    }
}

