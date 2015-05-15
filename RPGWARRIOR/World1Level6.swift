//
//  World1Level6.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 3/14/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//



import SpriteKit

//import AVFoundation

class World1Level6: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastFireball: Double = 0.0
    var levelOver = false
    let levelName = "world1level6"
    var droppedItem = false
    //REGEN CODE******
    var lastHeal: Double = 0.0
    let healSpeed = 5.0
    var lifeNode: SKLabelNode?
    var maxLife: CGFloat = 0.0
    //*****************
    let wizardAttackSpeed = 1.0
    
    var theBomber: BomberClass?
    var theHero: HeroClass?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, 30))
        theHero!.setScale(0.6)
        theHero!.name = "hero"
        self.addChild(theHero!)
        lifeNode = SKLabelNode(text: "\(Int(floor(theHero!.life!)))")
        lifeNode!.position = CGPointMake(self.frame.maxX - 20, self.frame.maxY - 20)
        lifeNode!.name = "life"
        lifeNode!.fontColor = UIColor.redColor()
        lifeNode!.fontSize = 20
        self.addChild(lifeNode!)
        theBomber = BomberClass.makeBomber(CGPointMake(self.frame.midX, self.frame.maxY - 50))
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
        
        //crabs
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX - 40, self.frame.maxY - 200), endPosition: CGPointMake(self.frame.midX - 40, self.frame.maxY - 360)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX + 40, self.frame.maxY - 360), endPosition: CGPointMake(self.frame.midX + 40, self.frame.maxY - 200)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(65, self.frame.maxY - 250), endPosition: CGPointMake(65, 130)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.maxX - 50, 140), endPosition: CGPointMake(self.frame.midX - 50, 140)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX - 50, 220), endPosition: CGPointMake(self.frame.maxX - 50, 220)))
        //shells i = y, k = x
        for (var i = 100; i < Int(self.frame.maxY - 100); i += 80){
            for (var k = 30; k < Int(self.frame.maxX - 20); k += 80){
                self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(k), CGFloat(i))))
            }
        }
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 65, 260)))
        
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
                let mine = secondBody.node as? MiniCrab
                mine!.explode(secondBody.node!.position)//(theHero!.position)//secondBody.node!.position)
        }else  if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategorySeashell.rawValue){
                let mine = secondBody.node as? MineNode
                mine!.explode(secondBody.node!.position)//(theHero!.position)//secondBody.node!.position)
        }
        //HERO VS WIZARD
        //else if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
        //secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryWizard.rawValue){
        //let aHero = self.childNodeWithName("hero") as HeroClass
        //aHero.attack()
        //}
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let aHero = self.childNodeWithName("hero") as HeroClass
        let aBomber = self.childNodeWithName("bomber") as BomberClass
        for touch in touches{
            //stop when mouse comes in contact hero
            //let theSpot = spotToStop(aHero, touch.locationInNode(self))
            //if theSpot != aHero.position{
            //aHero.moveTo(theSpot)
            // if (aWizard.containsPoint(touch.locationInNode(self))){
            //  if (distanceBetween(aWizard.position, aHero.position) < 10){
            //      aHero.attack()
            //  }
            //}
            aHero.moveHelper(touch.locationInNode(self))
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
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
        
        //win condition
        //check for win condition
        if (theBomber!.isDead || theHero!.life <= 0) && !levelOver{
            
            if (self.childNodeWithName("gold") == nil && self.childNodeWithName("item") == nil && droppedItem) || theHero!.life <= 0{
                
                let skTransition = SKTransition.fadeWithDuration(5.0)
                
                self.view?.presentScene(self.userData?.objectForKey("menu") as MainMenuScene, transition: skTransition)
                
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil && self.childNodeWithName("gold") == nil){
                if theBomber!.isDead{
                    dropLoot("level6", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
                    droppedItem = true
                    for node in self.children{
                        if node.name != "background" && node.name != "item" && node.name != "hero" && node.name != "bomber" && node.name != "life" && node.name != "gold"{
                            node.removeFromParent()
                        }
                    }
                }
            }
        }
    }
}

