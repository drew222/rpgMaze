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
    
    var timeSinceCrabAdded : NSTimeInterval = 0
    var addCrabTimeInterval : NSTimeInterval = 1.0
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var levelOver = false
    let levelName = "world1level20"
    var theHero: HeroClass?
    var bombthrower: BomberClass?
    var droppedItem = false
    //REGEN CODE******
    var lastHeal: Double = 0.0
    let healSpeed = 5.0
    var lifeNode: SKLabelNode?
    var maxLife: CGFloat = 0.0
    //*****************
    let bomberAttackSpeed = 1.5
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let background = SKSpriteNode(imageNamed: "Beach_Background_1.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        background.name = "background"
        self.physicsWorld.contactDelegate = self
        self.addChild(background)
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, self.frame.maxY * 0.04))
        theHero!.setScale(0.6)
        theHero!.name = "hero"
        self.addChild(theHero!)
        lifeNode = SKLabelNode(text: "\(Int(floor(theHero!.life!)))")
        lifeNode!.position = CGPointMake(self.frame.maxX - 20, self.frame.maxY - 20)
        lifeNode!.name = "life"
        lifeNode!.fontColor = UIColor.redColor()
        lifeNode!.fontSize = 20
        self.addChild(lifeNode!)
        bombthrower = BomberClass.makeBomber(CGPointMake(self.frame.midX, self.frame.maxY - 50))
        self.addChild(bombthrower!)
        theHero!.updateStats()
        //*****REGENE CODE****
        maxLife = theHero!.life!
        //********************
        
        //lower strafing crabs
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX, self.frame.midY - 100), endPosition: CGPointMake(self.frame.minX + 500, self.frame.midY - 100)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 150, self.frame.midY - 100), endPosition: CGPointMake(self.frame.minX + 650, self.frame.midY - 100)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 300, self.frame.midY - 100), endPosition: CGPointMake(self.frame.minX + 800, self.frame.midY - 100)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX - 150, self.frame.midY - 100), endPosition: CGPointMake(self.frame.minX + 350, self.frame.midY - 100)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX - 300, self.frame.midY - 100), endPosition: CGPointMake(self.frame.minX + 200, self.frame.midY - 100)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX - 450, self.frame.midY - 100), endPosition: CGPointMake(self.frame.minX + 50, self.frame.midY - 100)))
        //higher strafing crabs
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX, self.frame.midY + 100), endPosition: CGPointMake(self.frame.minX + 500, self.frame.midY + 100)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 150, self.frame.midY + 100), endPosition: CGPointMake(self.frame.minX + 650, self.frame.midY + 100)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX + 300, self.frame.midY + 100), endPosition: CGPointMake(self.frame.minX + 800, self.frame.midY + 100)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX - 150, self.frame.midY + 100), endPosition: CGPointMake(self.frame.minX + 350, self.frame.midY + 100)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX - 300, self.frame.midY + 100), endPosition: CGPointMake(self.frame.minX + 200, self.frame.midY + 100)))
        self.addChild(MiniCrab.crabAtPosition(CGPointMake(self.frame.minX - 450, self.frame.midY + 100), endPosition: CGPointMake(self.frame.minX + 50, self.frame.midY + 100)))
        
        
        //bottom row seashells
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 10, self.frame.midY - 250)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 40, self.frame.midY - 250)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 70, self.frame.midY - 250)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 100, self.frame.midY - 250)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 130, self.frame.midY - 250)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 160, self.frame.midY - 250)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 190, self.frame.midY - 250)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 220, self.frame.midY - 250)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 250, self.frame.midY - 250)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 280, self.frame.midY - 250)))
        //2nd from bottom
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 50, self.frame.midY - 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 80, self.frame.midY - 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 50, self.frame.midY - 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 80, self.frame.midY - 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 110, self.frame.midY - 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 110, self.frame.midY - 150)))
        //3rd from bottom
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, self.frame.midY - 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 30, self.frame.midY - 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 60, self.frame.midY - 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 90, self.frame.midY - 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 120, self.frame.midY - 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 30, self.frame.midY - 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 60, self.frame.midY - 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 90, self.frame.midY - 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 120, self.frame.midY - 50)))
        //top row
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 10, self.frame.midY + 230)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 40, self.frame.midY + 230)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 70, self.frame.midY + 230)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 100, self.frame.midY + 230)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 130, self.frame.midY + 230)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 160, self.frame.midY + 230)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 190, self.frame.midY + 230)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 220, self.frame.midY + 230)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 250, self.frame.midY + 230)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 280, self.frame.midY + 230)))
        //2nd from top
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 10, self.frame.midY + 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 40, self.frame.midY + 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 70, self.frame.midY + 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 100, self.frame.midY + 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 130, self.frame.midY + 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 160, self.frame.midY + 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 230, self.frame.midY + 150)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 260, self.frame.midY + 150)))
        
        //3rd from top
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX, self.frame.midY + 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX + 30, self.frame.midY + 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.midX - 30, self.frame.midY + 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 10, self.frame.midY + 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 40, self.frame.midY + 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.minX + 70, self.frame.midY + 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 10, self.frame.midY + 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 40, self.frame.midY + 50)))
        self.addChild(MineNode.mineAtPos(CGPointMake(self.frame.maxX - 70, self.frame.midY + 50)))
        
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
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryMiniCrab.rawValue){
                theHero!.takeDamage(3)
                let fadeOut = SKAction.fadeOutWithDuration(0.6)
                let codeBlock = SKAction.runBlock({secondBody.node?.removeFromParent()})
                let sequence = SKAction.sequence([fadeOut, codeBlock])
                secondBody.node?.runAction(sequence)
        }
        
        //HERO VS SEASHELL
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategorySeashell.rawValue){
                let mine = secondBody.node as? MineNode
                mine!.explode(secondBody.node!.position)
                theHero!.takeDamage(3)
        }
        
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let aHero = self.childNodeWithName("hero") as! HeroClass
        for touch in touches{
            aHero.moveHelper((touch as! UITouch).locationInNode(self))
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //println("current time: \(currentTime)")
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.lastUpdatesTime = currentTime
        }
        
        self.totalGameTime += currentTime - self.lastUpdatesTime
        
        //CRAB STAMPEDE
        
        self.timeSinceCrabAdded = self.timeSinceCrabAdded + currentTime - self.lastUpdatesTime
        
        
        if (self.timeSinceCrabAdded > self.addCrabTimeInterval && !self.levelOver) {
            self.addChild(MiniCrab.crabDash(CGPointMake(self.frame.minX, self.frame.midY ), endPosition: CGPointMake(self.frame.maxX, self.frame.midY)))
            self.addChild(MiniCrab.crabDash(CGPointMake(self.frame.maxX, self.frame.midY - 200 ), endPosition: CGPointMake(self.frame.minX, self.frame.midY - 200)))
            self.addChild(MiniCrab.crabDash(CGPointMake(self.frame.minX, self.frame.midY - 400), endPosition: CGPointMake(self.frame.maxX, self.frame.midY - 400)))
            self.addChild(MiniCrab.crabDash(CGPointMake(self.frame.maxX, self.frame.midY + 200), endPosition: CGPointMake(self.frame.minX, self.frame.midY + 200)))
            
            
            self.timeSinceCrabAdded = 0
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
        
        //win condition
        //check for win condition
        if (bombthrower!.isDead || theHero!.life <= 0) && !levelOver{
            
            if (self.childNodeWithName("gold") == nil && self.childNodeWithName("item") == nil && droppedItem) || theHero!.life <= 0{
                
                let skTransition = SKTransition.fadeWithDuration(1.0)
                
                self.view?.presentScene(self.userData?.objectForKey("menu") as! MainMenuScene, transition: skTransition)
                
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil && self.childNodeWithName("gold") == nil){
                if bombthrower!.isDead{
                    dropLoot("level20", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
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
