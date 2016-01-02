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
    var mineSpawnTimer = 0.1
    var levelOver = false
    let levelName = "level3"
    var theHero: HeroClass?
    var minethrower: MineThrowerNode?
    var droppedItem = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let background = SKSpriteNode(imageNamed: "Beach_Background_1.png")
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
        theHero!.updateStats()
        
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
           secondBody.categoryBitMask == CollisionBitMasks.collisionCategorySeashell.rawValue){
            let mine = secondBody.node as? MineNode
            if mine!.isArmed{
                mine!.explode(secondBody.node!.position)//(theHero!.position)//secondBody.node!.position)
                //let aHero = self.childNodeWithName("hero") as HeroClass
                //aHero.takeDamage(1)
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        let aHero = self.childNodeWithName("hero") as! HeroClass
        for touch in touches{
            aHero.moveHelper((touch ).locationInNode(self))
        }
    }
    func throwMine(position: CGPoint) {
        let theMinethrower = (self.childNodeWithName("MineThrower")) as? MineThrowerNode
        let mine = MineNode.mineAtPos(CGPointMake(theMinethrower!.position.x, theMinethrower!.position.y + 10)) as MineNode
        self.addChild(mine)
        mine.throwMineToPos(position)
    }
    override func update(currentTime: NSTimeInterval) {
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.timeOfLastMine = currentTime
            self.lastUpdatesTime = currentTime
        }
        self.totalGameTime += currentTime - lastUpdatesTime
        if currentTime - timeOfLastMine > mineSpawnTimer{
            
            let frameX: UInt32 = UInt32(self.frame.width)
            let frameY: UInt32 = UInt32(self.frame.height)
            let randomPositionX = CGFloat(arc4random_uniform(frameX))
            let randomPositionY = CGFloat(arc4random_uniform(frameY))
            let randomPos = CGPointMake(randomPositionX, randomPositionY)
            if !droppedItem{
                self.throwMine(randomPos)
            }
            timeOfLastMine = currentTime
        }
        if (minethrower!.isDead || theHero!.life <= 0) && !levelOver{
            //parent of self is viewcontroller, has view, extends sknode
            //if (theHero!.life == 0){
            //   let deathNode = SKLabelNode.init(text: "You died, try again!")
            //   deathNode.position = CGPointMake(self.frame.midX, self.frame.midY)
            //   self.addChild(deathNode)
            // }else if (theBomber!.isDead){
            //   let winNode = SKLabelNode.init(text: "You win, congratulations!")
            //   winNode.position = CGPointMake(self.frame.midX, self.frame.midY)
            //   self.addChild(winNode)
            // }
            if (self.childNodeWithName("item") == nil && droppedItem) || theHero!.life <= 0{
                //let menuScene = MainMenuScene(size: self.frame.size)
                //println("got here111")
                //(self.userData?.objectForKey("menu") as MainMenuScene).userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                //println("got here222")
                //menuScene.userData?.setValue(self.userData?.objectForKey("inventory"), forKey: "inventory")
                let skTransition = SKTransition.fadeWithDuration(5.0)
                //let gameScene = self.userData?.objectForKey("menu") as MainMenuScene
                self.view?.presentScene(self.userData?.objectForKey("menu") as! MainMenuScene, transition: skTransition)
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil){
                if minethrower!.isDead{
                    dropLoot("level3", scene: self, position: CGPointMake(self.frame.midX, self.frame.midY), size: CGSizeMake(30, 30))
                    droppedItem = true
                }
            }
        }
    }
}
