//
//  GameScene.swift
//  ThrowMine
//
//  Created by Tyler Mullins on 2/2/15.
//  Copyright (c) 2015 Tyler Mullins. All rights reserved.
//
import Foundation
import SpriteKit

class Level3Scene: SKScene, SKPhysicsContactDelegate  {
    
    var timeOfLastMine = 0.0
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var mineSpawnTimer = 0.2
    var levelOver = false
    let levelName = "level3"
    var theHero: HeroClass?
    var minethrower: MineThrowerNode?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let background = SKSpriteNode(imageNamed: "valgrind_desert_forest1.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.physicsWorld.contactDelegate = self
        self.addChild(background)
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, self.frame.maxY * 0.1))
        theHero!.setScale(0.6)
        self.addChild(theHero!)
        minethrower = MineThrowerNode.mineThrowerAtPos(CGPointMake(self.frame.maxX * 0.25, self.frame.maxY * 0.75))
        minethrower!.setScale(0.3)
        self.addChild(minethrower!)
        
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
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let aHero = self.childNodeWithName("hero") as HeroClass
        for touch in touches{
            aHero.moveHelper(touch.locationInNode(self))
        }
    }
    override func update(currentTime: NSTimeInterval) {
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.timeOfLastMine = currentTime
            self.lastUpdatesTime = currentTime
        }
        self.totalGameTime += currentTime - lastUpdatesTime
        if currentTime - timeOfLastMine > mineSpawnTimer{
            
            let randomPositionX = CGFloat(arc4random_uniform(300))
            let randomPositionY = CGFloat(arc4random_uniform(500))
            let randomPos = CGPointMake(randomPositionX, randomPositionY)
            let mine = MineNode.mineAtPos(randomPos)
            self.addChild(mine)
            timeOfLastMine = currentTime
        }
        if (minethrower!.isDead || theHero!.life == 0) && !levelOver{
            if minethrower!.isDead{
                dropLoot("level3", self, minethrower!.position, CGSizeMake(30, 30))
            }
            //parent of self is viewcontroller, has view, extends sknode
            let menuScene = MainMenuScene(size: self.frame.size)
            let skTransition = SKTransition.fadeWithDuration(5.0)
            if (theHero!.life == 0){
                let deathNode = SKLabelNode.init(text: "You died, try again!")
                deathNode.position = CGPointMake(self.frame.midX, self.frame.midY)
                self.addChild(deathNode)
            }else if (minethrower!.isDead){
                let winNode = SKLabelNode.init(text: "You win, congratulations!")
                winNode.position = CGPointMake(self.frame.midX, self.frame.midY)
                self.addChild(winNode)
            }
            if (self.childNodeWithName("item") == nil){
                self.view?.presentScene(menuScene, transition: skTransition)
                levelOver = true
            }
        }
    }
}
