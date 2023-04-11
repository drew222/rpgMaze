//
//  Level2Scene.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 2/8/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class Level2Scene: SKScene, SKPhysicsContactDelegate {
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastBomb: Double = 0.0
    var levelOver = false
    let levelName = "level2"
    var droppedItem = false
    
    let bomberAttackSpeed = 0.5
    
    var theBomber: BomberClass?
    var theHero: HeroClass?
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(position: CGPointMake(self.frame.midX, self.frame.maxY * 0.1))
        theHero!.setScale(0.6)
        self.addChild(theHero!)
        theBomber = BomberClass.makeBomber(position: CGPointMake(self.frame.maxX * 0.25, self.frame.maxY * 0.75))
        self.addChild(theBomber!)
        //the below constraints did nothing
        //let distanceConstraint = SKConstraint.distance(SKRange(lowerLimit: 10), toNode: aWizard)
        //ourHero.constraints = [distanceConstraint]
        let background = SKSpriteNode(imageNamed: "Beach_Background_1.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.physicsWorld.contactDelegate = self
        self.addChild(background)
        theHero!.updateStats()
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        /*
        var firstBody: SKPhysicsBody!
        var secondBody: SKPhysicsBody!
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        */
        //HERO VS FIRE
       // if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
         //   secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryProjectile.rawValue){
         //       let aHero = self.childNodeWithName("hero") as HeroClass
          //      aHero.takeDamage(1)
        //}
        //HERO VS WIZARD
        //else if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
        //secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryWizard.rawValue){
        //let aHero = self.childNodeWithName("hero") as HeroClass
        //aHero.attack()
        //}
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        let aHero = self.childNode(withName: "hero") as! HeroClass
        for touch in touches{
            aHero.moveHelper(position: (touch ).location(in: self))
        }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
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
            theBomber!.throwBomb()
        }
        
        self.lastUpdatesTime = currentTime
        
        //check for win condition
        if (theBomber!.isDead || theHero!.life ?? <#default value#> <= 0) && !levelOver{
            if (self.childNode(withName: "item") == nil && droppedItem) || theHero!.life ?? <#default value#> <= 0{
                let skTransition = SKTransition.fade(withDuration: 5.0)
                self.view?.presentScene(self.userData?.object(forKey: "menu") as! MainMenuScene, transition: skTransition)
                levelOver = true
            }
            else if (self.childNode(withName: "item") == nil){
                if theBomber!.isDead{
                    dropLoot(level: "level2", scene: self, position: CGPointMake(self.frame.midX, self.frame.midY), size: CGSizeMake(30, 30))
                    droppedItem = true
                }
            }
        }
    }
}
