//
//  World1Level8.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 4/3/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit

class World1Level8: SKScene, SKPhysicsContactDelegate  {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var levelOver = false
    let levelName = "world1level8"
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
    var lastBomb: Double = 0.0
    
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
        for spot in generateMinePoints(){
            placeMine(spot)
        }
        self.addChild(bombthrower!)
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
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategorySeashell.rawValue){
                let mine = secondBody.node as? MineNode
                if mine!.isArmed{
                    mine!.explode(secondBody.node!.position)//(theHero!.position)//secondBody.node!.position)
                    //let aHero = self.childNodeWithName("hero") as HeroClass
                    //aHero.takeDamage(3)
                }
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let aHero = self.childNodeWithName("hero") as! HeroClass
        for touch in touches{
            aHero.moveHelper((touch as! UITouch).locationInNode(self))
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
        startX = self.frame.minX + 20
        while startX < self.frame.maxX - 90{
            points.append(CGPointMake(startX, self.frame.midY + 90))
            startX += 25
        }
        startY = self.frame.midY + 120
        while startY < self.frame.maxY - 100{
            points.append(CGPointMake(self.frame.maxX - 105, startY))
            startY += 25
        }
        return points
    }
    func placeMine(position: CGPoint) {
        let theMinethrower = (self.childNodeWithName("MineThrower")) as? MineThrowerNode
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
        if (bombthrower!.isDead || theHero!.life <= 0) && !levelOver{
            
            if (self.childNodeWithName("gold") == nil && self.childNodeWithName("item") == nil && droppedItem) || theHero!.life <= 0{
                
                let skTransition = SKTransition.fadeWithDuration(5.0)
                
                self.view?.presentScene(self.userData?.objectForKey("menu") as! MainMenuScene, transition: skTransition)
                
                levelOver = true
            }
            else if (self.childNodeWithName("item") == nil && self.childNodeWithName("gold") == nil){
                if bombthrower!.isDead{
                    dropLoot("level8", self, CGPointMake(self.frame.midX, self.frame.midY), CGSizeMake(30, 30))
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
