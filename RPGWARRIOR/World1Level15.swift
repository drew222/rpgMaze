//
//  World1Level15.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/4/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//
import SpriteKit

//import AVFoundation

class World1Level15: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastWave: Double = 0.0
    var levelOver = false
    let levelName = "world1level15"
    var droppedItem = false
    //REGEN CODE******
    var lastHeal: Double = 0.0
    let healSpeed = 5.0
    var lifeNode: SKLabelNode?
    var maxLife: CGFloat = 0.0
    //*****************
    let whaleAttackSpeed = 2.0
    var whichWave = 0
    var wavePositions: [CGPoint]?
    
    
    var theWhale: WhaleBoss?
    var theHero: HeroClass?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, 30))
        theHero!.setScale(0.6)
        theHero!.name = "hero"
        self.addChild(theHero!)
        wavePositions = [
            CGPointMake(-20, 150),
            CGPointMake(self.frame.maxX + 20, 250),
            CGPointMake(-20, 150),
            CGPointMake(self.frame.maxX + 20, 250),
            CGPointMake(-20, 400),
            CGPointMake(self.frame.maxX + 20, 500),
            CGPointMake(-20, 400),
            CGPointMake(self.frame.maxX + 20, 500)]
        lifeNode = SKLabelNode(text: "\(Int(floor(theHero!.life!)))")
        lifeNode!.position = CGPointMake(self.frame.maxX - 20, self.frame.maxY - 20)
        lifeNode!.fontColor = UIColor.redColor()
        lifeNode!.fontSize = 20
        self.addChild(lifeNode!)
        theWhale = WhaleBoss.makeWhale(CGPointMake(self.frame.midX, self.frame.maxY - 50))
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
        
        //middle
        for (var i = 20; i < Int(self.frame.maxX) - 20; i += 40){
            self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(i), self.frame.midY)))
        }
        
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 50, 20)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 50, 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 50, 20)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 50, 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, 70)))
        
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 80, self.frame.maxY - 20)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 80, self.frame.maxY - 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 80, self.frame.maxY - 20)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 80, self.frame.maxY - 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 50, self.frame.maxY - 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 50, self.frame.maxY - 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 80, self.frame.maxY - 80)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 80, self.frame.maxY - 80)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, self.frame.maxY - 100)))
        
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(50, 200), endPosition: CGPointMake(self.frame.maxX - 50, 200)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(50, 450), endPosition: CGPointMake(self.frame.maxX - 50, 450)))
        
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
                mine!.explode(secondBody.node!.position)//(theHero!.position)//secondBody.node!.position)
        }
        //HERO VS CRAB
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryMiniCrab.rawValue){
                let mine = secondBody.node as? MiniCrab
                mine!.explode(secondBody.node!.position)//(theHero!.position)//secondBody.node!.position)
        }
        //HERO VS WAVE
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryWave.rawValue){
                theHero!.takeDamage(5)
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let aHero = self.childNodeWithName("hero") as! HeroClass
        let aWhale = self.childNodeWithName("whale") as! WhaleBoss
        for touch in touches{
            aHero.moveHelper((touch as! UITouch).locationInNode(self))
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.lastUpdatesTime = currentTime
            self.lastWave = currentTime
        }
        self.totalGameTime += currentTime - self.lastUpdatesTime
        
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
        
        if currentTime - lastWave  > whaleAttackSpeed && !levelOver{
            self.lastWave = currentTime
            if whichWave == wavePositions!.count {
                whichWave = 0
            }
            theWhale!.throwWave(wavePositions![whichWave])
            whichWave += 1
        }
        
        //win condition
        //check for win condition
        if (theWhale!.isDead || theHero!.life <= 0) && !levelOver{
            
            if (self.childNodeWithName("gold") == nil && self.childNodeWithName("item") == nil && droppedItem) || theHero!.life <= 0{
                
                let skTransition = SKTransition.fadeWithDuration(1.0)
                
                self.view?.presentScene(self.userData?.objectForKey("menu") as! MainMenuScene, transition: skTransition)
                
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil && self.childNodeWithName("gold") == nil){
                if theWhale!.isDead{
                    dropLoot("level15", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
                    droppedItem = true
                    for node in self.children{
                        if node.name != "background" && node.name != "item" && node.name != "hero" && node.name != "whale" && node.name != "life" && node.name != "gold"{
                            node.removeFromParent()
                        }
                    }
                }
            }
        }
    }
}







