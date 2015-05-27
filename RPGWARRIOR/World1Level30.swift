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
    
    var levelOver = false
    let levelName = "world1level30"
    var droppedItem = false
    //REGEN CODE******
    var lastHeal: Double = 0.0
    let healSpeed = 5.0
    var lifeNode: SKLabelNode?
    var maxLife: CGFloat = 0.0
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
    
    
    var theKraken: KrakenBoss?
    var theHero: HeroClass?
    var theWhale: WhaleBoss?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, 30))
        theHero!.setScale(0.6)
        self.addChild(theHero!)
        lifeNode = SKLabelNode(text: "\(Int(floor(theHero!.life!)))")
        lifeNode!.position = CGPointMake(self.frame.maxX - 20, self.frame.maxY - 20)
        lifeNode!.fontColor = UIColor.redColor()
        lifeNode!.fontSize = 20
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
        let background = SKSpriteNode(imageNamed: "Beach_Background_1.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.addChild(background)
        self.physicsWorld.contactDelegate = self
        theHero!.updateStats()
        //*****REGENE CODE****
        maxLife = theHero!.life!
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
                println("got here")
                theHero!.takeDamage(spikeDamage)
                secondBody.node?.removeFromParent()
                println("got here2")
        }
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryMiniCrab.rawValue){
                theHero!.takeDamage(crabDamage)
                secondBody.node?.removeFromParent()
        }
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryKrill.rawValue){
                theHero!.takeDamage(krillDamage)
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
            phase += 1
            updateLevel()
        }
        
        if currentTime - lastTentacle  > krakenAttackSpeedSpike && !levelOver{
            self.lastTentacle = currentTime
            theKraken!.throwTentacle()
        }
        
        if currentTime - lastKrill  > whaleAttackSpeedKrill && !levelOver{
            self.lastKrill = currentTime
            theWhale!.shootKrill()
        }
        
        if currentTime - lastWaterWave  > whaleAttackSpeedWave && !levelOver{
            self.lastWaterWave = currentTime
            let yValue = randomWithMin(Int(self.frame.minY + 100), Int(self.frame.maxY - 175))
            let xBool = randomWithMin(0, 10)
            var xValue = self.frame.maxX + 20
            if xBool < 5 {
                xValue = -20
            }
            theWhale!.throwWave(CGPointMake(xValue, CGFloat(yValue)))
        }
        
        
        if (currentTime - lastCrab > crabSpawnSpeed && !self.levelOver) {
            var xMatch = CGFloat(randomWithMin(Int(self.frame.minX + 80), Int(self.frame.maxX - 80)))
            self.addChild(MiniCrab.crabDash(CGPointMake(xMatch, self.frame.maxY + 30), endPosition: CGPointMake(xMatch, self.frame.minY)))
            
            
            self.lastCrab = currentTime
        }
        
        
        //******REGEN CODE
        if currentTime - lastHeal  > healSpeed{
            self.lastHeal = currentTime
            if theHero!.life < maxLife{
                theHero!.life! += theHero!.regeneration!
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

