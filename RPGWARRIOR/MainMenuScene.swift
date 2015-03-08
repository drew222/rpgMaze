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
    var level4Node: SKLabelNode?
    var level5Node: SKLabelNode?
    var inventory: SKLabelNode?
    var world1level1node: SKLabelNode?
    var world1level2node: SKLabelNode?
    var world1level3node: SKLabelNode?
    var firstTimeLoaded = true
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        if firstTimeLoaded{
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
        
        level3Node = SKLabelNode.init(text: "Level 3")
        if let Node = level3Node {
            Node.position = CGPointMake(self.frame.midX, self.frame.midY - 110)
            Node.name = "level3"
            self.addChild(Node)
        }

        level4Node = SKLabelNode.init(text: "Level 4")
        if let Node = level4Node {
            Node.position = CGPointMake(self.frame.midX, self.frame.midY - 160)
            Node.name = "level4"
            self.addChild(Node)
        }
        level5Node = SKLabelNode.init(text: "Level 5")
        if let Node = level5Node {
            Node.position = CGPointMake(self.frame.midX, self.frame.midY - 210)
            Node.name = "level5"
            self.addChild(Node)
        }
        world1level1node = SKLabelNode.init(text: "World 1 : Level 1")
        resizeLabel(world1level1node!)
        if let Node = world1level1node {
            Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 300)
            Node.name = "world1level1"
            self.addChild(Node)
        }
            
        world1level2node = SKLabelNode.init(text: "World 1 : Level 2")
        resizeLabel(world1level2node!)
        if let Node = world1level2node {
            Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 250)
            Node.name = "world1level2"
            self.addChild(Node)
        }
            
        world1level3node = SKLabelNode.init(text: "World 1 : Level 3")
        resizeLabel(world1level3node!)
        if let Node = world1level3node {
            Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 200)
            Node.name = "world1level3"
            self.addChild(Node)
        }
        
        inventory = SKLabelNode.init(text: "Inventory")
        inventory!.position = CGPointMake(self.frame.maxX - 70, self.frame.minY + 40)
        inventory!.name = "inventory"
        self.addChild(inventory!)
        firstTimeLoaded = false
        }
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
                
            }else if level3Node!.containsPoint(touch.locationInNode(self)){
                let level3 = Level3Scene(size: self.frame.size)
                level3.userData = NSMutableDictionary()
                level3.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                level3.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(level3, transition: skTransition)
                
            }else if level4Node!.containsPoint(touch.locationInNode(self)){
                let level4 = Level4Scene(size: self.frame.size)
                level4.userData = NSMutableDictionary()
                level4.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                level4.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(level4, transition: skTransition)
                
            }else if level5Node!.containsPoint(touch.locationInNode(self)){
                let level5 = Level5Scene(size: self.frame.size)
                level5.userData = NSMutableDictionary()
                level5.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                level5.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(level5, transition: skTransition)
                
            }else if world1level1node!.containsPoint(touch.locationInNode(self)){
                let world1level1scene = World1Level1(size: self.frame.size)
                world1level1scene.userData = NSMutableDictionary()
                world1level1scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level1scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level1scene, transition: skTransition)
                
            }else if world1level2node!.containsPoint(touch.locationInNode(self)){
                let world1level2scene = World1Level2(size: self.frame.size)
                world1level2scene.userData = NSMutableDictionary()
                world1level2scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level2scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level2scene, transition: skTransition)
                
            }else if world1level3node!.containsPoint(touch.locationInNode(self)){
                let world1level3scene = World1Level3(size: self.frame.size)
                world1level3scene.userData = NSMutableDictionary()
                world1level3scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level3scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level3scene, transition: skTransition)
                
            }else if inventory!.containsPoint(touch.locationInNode(self)){
                println("clicked inventory")
                //let inventoryScene = Inventory(size: self.frame.size)
                let skTransition = SKTransition.fadeWithDuration(1.0)
                (self.userData?.objectForKey("inventory") as Inventory).userData?.setObject(self, forKey: "menu")
                println("got here111")
                self.view?.presentScene(self.userData?.objectForKey("inventory") as Inventory, transition: skTransition)
                }
            }
        }
    }


