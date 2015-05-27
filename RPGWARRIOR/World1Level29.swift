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
    
    var timeSinceCrabAdded : NSTimeInterval = 0
    var addCrabTimeInterval : NSTimeInterval = 1.25
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
    var lifeNode: SKLabelNode?
    var maxLife: CGFloat = 0.0
    //*****************
    
    let bomberAttackSpeed = 9.0
    
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
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.name = "background"
        background.zPosition = -1
        self.physicsWorld.contactDelegate = self
        self.addChild(background)
        theHero!.updateStats()
        //crabs
        //inside square
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX + 100, self.frame.midY + 100), endPosition: CGPointMake(self.frame.midX - 100, self.frame.midY + 100)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX - 100, self.frame.midY + 100), endPosition: CGPointMake(self.frame.midX - 100, self.frame.midY - 100)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX - 100, self.frame.midY - 100), endPosition: CGPointMake(self.frame.midX + 100, self.frame.midY - 100)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX + 100, self.frame.midY - 100), endPosition: CGPointMake(self.frame.midX + 100, self.frame.midY + 100)))
        //outside square
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX + 150, self.frame.midY + 150), endPosition: CGPointMake(self.frame.midX - 150, self.frame.midY + 150)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX - 150, self.frame.midY + 150), endPosition: CGPointMake(self.frame.midX - 150, self.frame.midY - 150)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX - 150, self.frame.midY - 150), endPosition: CGPointMake(self.frame.midX + 150, self.frame.midY - 150)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.midX + 150, self.frame.midY - 150), endPosition: CGPointMake(self.frame.midX + 150, self.frame.midY + 150)))
        
        
        
        //shells i = y, k = x
        //inside square
        //right wall
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 60, self.frame.midY)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 60, self.frame.midY - 30)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 60, self.frame.midY - 60)))
        //left wall
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 60, self.frame.midY)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 60, self.frame.midY + 30)))
        //bottom wall
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, self.frame.midY - 60)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 30, self.frame.midY - 60)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 90, self.frame.midY - 60)))
    
        //top wall
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, self.frame.midY + 60)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 30, self.frame.midY + 60)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 60, self.frame.midY + 60)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 90, self.frame.midY + 60)))
        
        //top mid column
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, self.frame.midY + 90)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, self.frame.midY + 120)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, self.frame.midY + 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, self.frame.midY + 180)))
        //bottom mid column
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, self.frame.midY - 90)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, self.frame.midY - 120)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, self.frame.midY - 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, self.frame.midY - 180)))
        
        //bottom big wall
        for (var i = 20; i < Int(self.frame.maxX - 80); i += 30){
            self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(i),  self.frame.midY - 205)))
        }
        //top big wall
        for (var i = 90; i < Int(self.frame.maxX); i += 30){
            self.addChild(MineNode.mineAtPos(CGPointMake(CGFloat(i),  self.frame.midY + 205)))
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
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryMiniCrab.rawValue){
                let mine = secondBody.node as? MiniCrab
                mine!.explode(secondBody.node!.position)//(theHero!.position)//secondBody.node!.position)
        }else  if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategorySeashell.rawValue){
                let mine = secondBody.node as? MineNode
                mine!.explode(secondBody.node!.position)//(theHero!.position)//secondBody.node!.position)
        }
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let aHero = self.childNodeWithName("hero") as! HeroClass
        let aBomber = self.childNodeWithName("bomber") as! BomberClass
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
            aHero.moveHelper((touch as! UITouch).locationInNode(self))
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.lastUpdatesTime = currentTime
            self.lastBomb = currentTime
        }
        if currentTime - lastBomb  > bomberAttackSpeed{
            self.lastBomb = currentTime
            theBomber!.throwBomb()
        }
        
        self.lastUpdatesTime = currentTime
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
        lifeNode!.text = "\(Int(floor(theHero!.life!)))"
        //***************
        
        //win condition
        //check for win condition
        if (theBomber!.isDead || theHero!.life <= 0) && !levelOver{
            
            if (self.childNodeWithName("gold") == nil && self.childNodeWithName("item") == nil && droppedItem) || theHero!.life <= 0{
                
                let skTransition = SKTransition.fadeWithDuration(1.0)
                
                self.view?.presentScene(self.userData?.objectForKey("menu") as! MainMenuScene, transition: skTransition)
                
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil && self.childNodeWithName("gold") == nil){
                if theBomber!.isDead{
                    dropLoot("level29", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
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
