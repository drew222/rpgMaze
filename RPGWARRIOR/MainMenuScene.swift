//
//  MainMenuScene.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 2/8/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class MainMenuScene: SKScene {
    var level1Node: SKLabelNode?
    var level2Node: SKLabelNode?
    var level3Node: SKLabelNode?
    var inventory: SKLabelNode?
    var menuCounter = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = UIColor.blueColor()
        level1Node = SKLabelNode.init(text: "Level 1")
        level1Node!.position = CGPointMake(self.frame.midX, self.frame.midY - 10)
        level1Node!.name = "level1"
        self.addChild(level1Node!)
        
        level2Node = SKLabelNode.init(text: "Level 2")
        level2Node!.position = CGPointMake(self.frame.midX, self.frame.midY - 60)
        level2Node!.name = "level2"
        self.addChild(level2Node!)
        if self.userData?.objectForKey("inventory") == nil{
            println("inventorydata was nil")
            self.userData = NSMutableDictionary()
            let theInventory = Inventory(size: self.frame.size)
            theInventory.userData = NSMutableDictionary()
            self.userData?.setObject(theInventory, forKey: "inventory")
        }
        menuCounter++
        println("menuCounter = \(menuCounter)")
        
        level3Node = SKLabelNode.init(text: "Level 3")
        if let Node = level3Node {
            Node.position = CGPointMake(self.frame.midX, self.frame.midY - 110)
            Node.name = "level3"
            self.addChild(Node)
        }
        
        inventory = SKLabelNode.init(text: "Inventory")
        inventory!.position = CGPointMake(self.frame.maxX - 60, self.frame.minY + 40)
        inventory!.name = "inventory"
        self.addChild(inventory!)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches{
            if level1Node!.containsPoint(touch.locationInNode(self)){
                let gameplayScene = GameScene(size: self.frame.size)
                gameplayScene.userData = NSMutableDictionary()
                gameplayScene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                gameplayScene.userData?.setObject(self, forKey: "menu")
                //gameplayScene.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(gameplayScene, transition: skTransition)
            }else if level2Node!.containsPoint(touch.locationInNode(self)){
                let level2 = Level2Scene(size: self.frame.size)
                level2.userData = NSMutableDictionary()
                level2.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                level2.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(level2, transition: skTransition)
<<<<<<< Updated upstream
            }else if inventory!.containsPoint(touch.locationInNode(self)){
                println("clicked inventory")
                //let inventoryScene = Inventory(size: self.frame.size)
                let skTransition = SKTransition.fadeWithDuration(1.0)
                (self.userData?.objectForKey("inventory") as Inventory).userData?.setObject(self, forKey: "menu")
                println("got here111")
                self.view?.presentScene(self.userData?.objectForKey("inventory") as Inventory, transition: skTransition)
=======
            }else if level3Node!.containsPoint(touch.locationInNode(self)){
                let level3 = Level3Scene(size: self.frame.size)
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(level3, transition: skTransition)
            }else if inventory!.containsPoint(touch.locationInNode(self)){
            let inv = Inventory(size: self.frame.size)
            let skTransition = SKTransition.fadeWithDuration(1.0)
            self.view?.presentScene(inv, transition: skTransition)
>>>>>>> Stashed changes
            }
        }
    }
}