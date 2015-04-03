//
//  World1Level20.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/2/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class World1Level20: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastWave: Double = 0.0
    var levelOver = false
    let levelName = "world1level20"
    var droppedItem = false
    //REGEN CODE******
    var lastHeal: Double = 0.0
    let healSpeed = 5.0
    var lifeNode: SKLabelNode?
    var maxLife: CGFloat = 0.0
    //*****************
    let whaleAttackSpeed = 3.0
    var whichWave = 0
    var wavePositions: [CGPoint]?
    
    
    var theWhale: WhaleBoss?
    var theHero: HeroClass?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, self.frame.maxY * 0.1))
        theHero!.setScale(0.6)
        self.addChild(theHero!)
        wavePositions = [CGPointMake(-20, self.frame.minY + 200), CGPointMake(self.frame.maxX + 20, self.frame.minY + 400), CGPointMake(-20, self.frame.minY + 600)]
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
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.addChild(background)
        self.physicsWorld.contactDelegate = self
        theHero!.updateStats()
        //*****REGENE CODE****
        maxLife = theHero!.life!
        //********************
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 50, self.frame.midY + 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 50, self.frame.midY - 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 100, self.frame.midY + 75)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 75, self.frame.midY - 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 200, self.frame.midY)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 200, self.frame.midY)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 200, self.frame.midY - 100)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 100, self.frame.midY - 150)))
        
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
        //HERO VS WAVE
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryWave.rawValue){
                theHero!.takeDamage(3)
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let aHero = self.childNodeWithName("hero") as HeroClass
        let aWhale = self.childNodeWithName("whale") as WhaleBoss
        for touch in touches{
            aHero.moveHelper(touch.locationInNode(self))
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
            }
        }
        
        if currentTime - lastWave  > whaleAttackSpeed{
            self.lastWave = currentTime
            theWhale!.throwWave(wavePositions![whichWave])
            if whichWave < 2{
                whichWave += 1
            }
        }
        
        self.lastUpdatesTime = currentTime
        lifeNode!.text = "\(Int(floor(theHero!.life!)))"
        //***************
        
        //check for win condition
        if (theWhale!.isDead || theHero!.life <= 0) && !levelOver{
            if (self.childNodeWithName("item") == nil && droppedItem) || theHero!.life <= 0{
                let skTransition = SKTransition.fadeWithDuration(5.0)
                self.view?.presentScene(self.userData?.objectForKey("menu") as MainMenuScene, transition: skTransition)
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil){
                if theWhale!.isDead{
                    dropLoot("world1level20", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
                    droppedItem = true
                }
            }
        }
    }
}

