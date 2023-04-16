//
//  Level4Scene.swift
//  RPGWARRIOR
//
//  Created by Tyler Mullins on 2/15/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit

class Level4Scene: SKScene, SKPhysicsContactDelegate {
    
    
    var gameStartTime = 0.0
    var totalGameTime = 0.0
    var lastUpdatesTime = 0.0
    var lastFireball: Double = 0.0
    var levelOver = false
    let levelName = "level1"
    var droppedItem = false
    var lastBlizz = 0.0

    let wizardAttackSpeed = 1.0
    
    var theWizard: WizardClass?
    var theHero: HeroClass?
    
    var blizzInContact: BlizzNode?
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        theHero = HeroClass.makeHero(position: CGPointMake(self.frame.midX, self.frame.maxY * 0.1))
        theHero!.setScale(0.6)
        self.addChild(theHero!)
        theWizard = WizardClass.makeWizard(position: CGPointMake(self.frame.maxX * 0.25, self.frame.maxY * 0.75))
        self.addChild(theWizard!)
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
        var firstBody: SKPhysicsBody!
        var secondBody: SKPhysicsBody!
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        //HERO VS FIRE
        if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryProjectile.rawValue){
            let aHero = self.childNode(withName: "hero") as! HeroClass
            aHero.takeDamage(damage: 1)
                secondBody.node!.removeFromParent()
        }/* else if (firstBody.categoryBitMask == CollisionBitMasks.collisionCategoryHero.rawValue &&
            secondBody.categoryBitMask == CollisionBitMasks.collisionCategoryBlizzard.rawValue){
            let aHero = self.childNodeWithName("hero") as HeroClass
            if (blizzInContact == nil) {
                if heroSpeed >= theHero!.baseSpeed{
                    println("slowing!!!!!!")
                    (secondBody.node as BlizzNode).slow()
                    blizzInContact = secondBody.node as BlizzNode?
                }
            }
        }
        */
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        let aHero = self.childNode(withName: "hero") as! HeroClass
        _ = self.childNode(withName: "wizard") as! WizardClass
        for touch in touches{
            aHero.moveHelper(position: (touch ).location(in: self))
        }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        let hero = self.childNode(withName: "hero")
        
        if self.gameStartTime == 0 {
            self.gameStartTime = currentTime
            self.lastUpdatesTime = currentTime
            self.lastFireball = currentTime
            self.lastBlizz = currentTime
        }
        self.totalGameTime += currentTime - self.lastUpdatesTime
        if currentTime - lastFireball  > wizardAttackSpeed{
            self.lastFireball = currentTime
            theWizard!.shootFireball(aPosition: theHero!.position)
        }
        if currentTime - lastBlizz > (3 * wizardAttackSpeed) {
            theWizard!.createBlizz(position: theWizard!.getBlizzLocation(heroPosition: theHero!.position))
            self.lastBlizz = currentTime
        }
        //loop through all the blizzards and check if position is in them
        var blizzFound = false
        for node in self.children{
            if (node as? BlizzNode != nil){
                //println("found blizzNode")
                if node.name == "blizz"{
                    if node.contains(hero!.position){
                        blizzFound = true
                        if !theHero!.isSlowed{
                            theHero!.changeSpeed(change: -60)
                            theHero!.isSlowed = true
                        }
                        blizzInContact = node as? BlizzNode
                    }
                }
            }
        }
        if !blizzFound && blizzInContact != nil{
            if theHero!.isSlowed{
                theHero!.changeSpeed(change: 60)
                theHero!.isSlowed = false
            }
        }
        
        self.lastUpdatesTime = currentTime
        
        
        
        //check for win condition
        if (theWizard!.isDead || theHero!.life! <= 0) && !levelOver{
            if (self.childNode(withName: "item") == nil && droppedItem) || theHero!.life! <= 0{
                let skTransition = SKTransition.fade(withDuration: 5.0)
                self.view?.presentScene(self.userData?.object(forKey: "menu") as! MainMenuScene, transition: skTransition)
                levelOver = true
            }
            else if (self.childNode(withName: "item") == nil){
                if theWizard!.isDead{
                    dropLoot(level: "level4", scene: self, position: CGPointMake(self.frame.midX, self.frame.midY), size: CGSizeMake(30, 30))
                    droppedItem = true
                }
            }
        }
    }
}
