//
//  level5Scene.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 2/12/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit

class Level5Scene: SKScene, SKPhysicsContactDelegate  {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var levelOver = false
    let levelName = "level5"
    var theHero: HeroClass?
    var bombthrower: BomberClass?
    var droppedItem = false
    let bomberAttackSpeed = 1.0
    var lastBomb: Double = 0.0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let background = SKSpriteNode(imageNamed: "Beach_Background_1.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.physicsWorld.contactDelegate = self
        self.addChild(background)
        theHero = HeroClass.makeHero(CGPointMake(self.frame.midX, self.frame.maxY * 0.04))
        theHero!.setScale(0.6)
        self.addChild(theHero!)
        bombthrower = BomberClass.makeBomber(CGPointMake(self.frame.maxX * 0.25, self.frame.maxY * 0.75))
        for spot in generateMinePoints(){
            placeMine(spot)
        }
        self.addChild(bombthrower!)
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
                    //aHero.takeDamage(3)
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
    
    func generateMinePoints() -> [CGPoint]{
        //generate line from mid x to c
        var points: [CGPoint] = []
        var startY = self.frame.midY - 90
        while startY > self.frame.minY + 90{
            points.append(CGPointMake(self.frame.midX, startY))
            startY -= 25
        }
        var startX = self.frame.midX
        while startX > self.frame.minX{
            points.append(CGPointMake(startX, self.frame.minY + 90))
            startX -= 25
        }
        startX = self.frame.midX
        while startX > 0{
            points.append(CGPointMake(startX, self.frame.midY - 90))
            startX -= 25
        }
        startY = self.frame.minY + 90
        while startY < self.frame.midY{
            points.append(CGPointMake(self.frame.midX + 90, startY))
            startY += 25
        }
        startX = self.frame.midX + 90
        while startX < self.frame.maxX{
            points.append(CGPointMake(startX, self.frame.minY + 90))
            startX += 25
        }
        startX = self.frame.midX + 90
        while startX > 90{
            points.append(CGPointMake(startX, self.frame.midY))
            startX -= 25
        }
        return points
    }
    func placeMine(position: CGPoint) {
        _ = (self.childNodeWithName("MineThrower")) as? MineThrowerNode
        let mine = MineNode.mineAtPos(position) as MineNode
        mine.isArmed = true
        self.addChild(mine)
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //println("current time: \(currentTime)")
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.lastUpdatesTime = currentTime
            self.lastBomb = currentTime
        }
        self.totalGameTime += currentTime - self.lastUpdatesTime
        if currentTime - lastBomb  > bomberAttackSpeed{
            self.lastBomb = currentTime
            bombthrower!.throwBomb()
        }
        
        self.lastUpdatesTime = currentTime
        
        //check for win condition
        if (bombthrower!.isDead || theHero!.life <= 0) && !levelOver{
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
                if bombthrower!.isDead{
                    dropLoot("level5", scene: self, position: CGPointMake(self.frame.midX, self.frame.midY), size: CGSizeMake(30, 30))
                    droppedItem = true
                }
            }
        }
    }
}