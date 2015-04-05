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
    var mainScreen: SKLabelNode?
    var world1level1node: SKLabelNode?
    var world1level2node: SKLabelNode?
    var world1level3node: SKLabelNode?
    var world1level4node: SKLabelNode?
    var world1level5node: SKLabelNode?
    var world1level6node: SKLabelNode?
    var world1level7node: SKLabelNode?
    var world1level8node: SKLabelNode?
    var world1level9node: SKLabelNode?
    var world1level10node: SKLabelNode?
    var world1level11node: SKLabelNode?
    var world1level12node: SKLabelNode?
    var world1level13node: SKLabelNode?
    var world1level14node: SKLabelNode?
    var world1level20node: SKLabelNode?
    var world1level21node: SKLabelNode?
    
    // ##### change this for new level#####
    var firstTimeLoaded = true
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        if firstTimeLoaded{
        self.backgroundColor = UIColor.blueColor()
            let background = SKSpriteNode(imageNamed: "Zone_Screen_2")
            background.size = self.frame.size
            background.position = CGPointMake(self.frame.midX, self.frame.midY)
            background.zPosition = -1
            self.addChild(background)
        level1Node = SKLabelNode.init(text: "Level 1")
        level1Node!.position = CGPointMake(self.frame.midX + 50, self.frame.midY - 10)
        level1Node!.name = "level1"
        self.addChild(level1Node!)
        
        level2Node = SKLabelNode.init(text: "Level 2")
        level2Node!.position = CGPointMake(self.frame.midX + 50, self.frame.midY - 60)
        level2Node!.name = "level2"
        self.addChild(level2Node!)
        if self.userData?.objectForKey("inventory") == nil{
            println("inventorydata was nil")
            //self.userData = NSMutableDictionary()
            let theInventory = Inventory(size: self.frame.size)
            theInventory.userData = NSMutableDictionary()
            self.userData?.setObject(theInventory, forKey: "inventory")
        }
        
        level3Node = SKLabelNode.init(text: "Level 3")
        if let Node = level3Node {
            Node.position = CGPointMake(self.frame.midX + 50, self.frame.midY - 110)
            Node.name = "level3"
            self.addChild(Node)
        }

        level4Node = SKLabelNode.init(text: "Level 4")
        if let Node = level4Node {
            Node.position = CGPointMake(self.frame.midX + 50, self.frame.midY - 160)
            Node.name = "level4"
            self.addChild(Node)
        }
        level5Node = SKLabelNode.init(text: "Level 5")
        if let Node = level5Node {
            Node.position = CGPointMake(self.frame.midX + 50, self.frame.midY - 210)
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
            Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 275)
            Node.name = "world1level2"
            self.addChild(Node)
        }
            
        world1level3node = SKLabelNode.init(text: "World 1 : Level 3")
        resizeLabel(world1level3node!)
        if let Node = world1level3node {
            Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 250)
            Node.name = "world1level3"
            self.addChild(Node)
        }
            
            world1level4node = SKLabelNode.init(text: "World 1 : Level 4")
            resizeLabel(world1level4node!)
            if let Node = world1level4node {
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 225)
                Node.name = "world1level4"
                self.addChild(Node)
            }
            
            world1level5node = SKLabelNode.init(text: "World 1 : Level 5")
            resizeLabel(world1level5node!)
            if let Node = world1level5node {
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 200)
                Node.name = "world1level5"
                self.addChild(Node)
            }
            
            world1level6node = SKLabelNode.init(text: "World 1 : Level 6")
            resizeLabel(world1level6node!)
            if let Node = world1level6node {
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 175)
                Node.name = "world1level6"
                self.addChild(Node)
            }
            
            world1level7node = SKLabelNode.init(text: "World 1 : Level 7")
            resizeLabel(world1level7node!)
            if let Node = world1level7node {
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 150)
                Node.name = "world1level7"
                self.addChild(Node)
            }
            world1level8node = SKLabelNode.init(text: "World 1 : Level 8")
            resizeLabel(world1level8node!)
            if let Node = world1level8node {
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 125)
                Node.name = "world1level8"
                self.addChild(Node)
            }
            world1level9node = SKLabelNode.init(text: "World 1 : Level 9")
            resizeLabel(world1level9node!)
            if let Node = world1level9node {
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 100)
                Node.name = "world1level9"
                self.addChild(Node)
            }
            world1level10node = SKLabelNode.init(text: "World 1 : Level 10")
            resizeLabel(world1level10node!)
            if let Node = world1level10node {
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 75)
                Node.name = "world1level10"
                self.addChild(Node)
            }
            world1level11node = SKLabelNode.init(text: "World 1 : Level 11")
            resizeLabel(world1level11node!)
            if let Node = world1level11node {
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 50)
                Node.name = "world1level11"
                self.addChild(Node)
            }
            world1level12node = SKLabelNode.init(text: "World 1 : Level 12")
            resizeLabel(world1level12node!)
            if let Node = world1level12node {
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 25)
                Node.name = "world1level12"
                self.addChild(Node)
            }
            world1level13node = SKLabelNode.init(text: "World 1 : Level 13")
            resizeLabel(world1level13node!)
            if let Node = world1level13node {
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY)
                Node.name = "world1level13"
                self.addChild(Node)
            }
            world1level14node = SKLabelNode.init(text: "World 1 : Level 14")
            resizeLabel(world1level14node!)
            if let Node = world1level14node {
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY - 25)
                Node.name = "world1level14"
                self.addChild(Node)
            }
            world1level20node = SKLabelNode.init(text: "World 1 : Level 20")
            resizeLabel(world1level20node!)
            if let Node = world1level20node {
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY - 50)
                Node.name = "world1level20"
                self.addChild(Node)
            }
            world1level21node = SKLabelNode.init(text: "World 1 : Level 21")
            resizeLabel(world1level21node!)
            if let Node = world1level21node {
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY - 75)
                Node.name = "world1level21"
                self.addChild(Node)
            }
            // #####change this for new level#####
        
        inventory = SKLabelNode.init(text: "Inventory")
        inventory!.position = CGPointMake(self.frame.maxX - 70, self.frame.minY + 40)
        inventory!.name = "inventory"
        self.addChild(inventory!)
        firstTimeLoaded = false
            
            mainScreen = SKLabelNode.init(text: "Main Menu")
            mainScreen!.position = CGPointMake(self.frame.minX + 70, self.frame.minY + 40)
            mainScreen!.name = "inventory"
            self.addChild(mainScreen!)
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
                
            }else if world1level4node!.containsPoint(touch.locationInNode(self)){
                let world1level4scene = World1Level4(size: self.frame.size)
                world1level4scene.userData = NSMutableDictionary()
                world1level4scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level4scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level4scene, transition: skTransition)
                
            }else if world1level5node!.containsPoint(touch.locationInNode(self)){
                let world1level5scene = World1Level5(size: self.frame.size)
                world1level5scene.userData = NSMutableDictionary()
                world1level5scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level5scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level5scene, transition: skTransition)
                
            }else if world1level6node!.containsPoint(touch.locationInNode(self)){
                let world1level6scene = World1Level6(size: self.frame.size)
                world1level6scene.userData = NSMutableDictionary()
                world1level6scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level6scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level6scene, transition: skTransition)
                
            }else if world1level7node!.containsPoint(touch.locationInNode(self)){
                let world1level7scene = World1Level7(size: self.frame.size)
                world1level7scene.userData = NSMutableDictionary()
                world1level7scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level7scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level7scene, transition: skTransition)
                
            }else if world1level8node!.containsPoint(touch.locationInNode(self)){
                let world1level8scene = World1Level8(size: self.frame.size)
                world1level8scene.userData = NSMutableDictionary()
                world1level8scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level8scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level8scene, transition: skTransition)
                
            }else if world1level9node!.containsPoint(touch.locationInNode(self)){
                let world1level9scene = World1Level9(size: self.frame.size)
                world1level9scene.userData = NSMutableDictionary()
                world1level9scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level9scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level9scene, transition: skTransition)
                
            }else if world1level10node!.containsPoint(touch.locationInNode(self)){
                let world1level10scene = World1Level10(size: self.frame.size)
                world1level10scene.userData = NSMutableDictionary()
                world1level10scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level10scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level10scene, transition: skTransition)
                
            }else if world1level11node!.containsPoint(touch.locationInNode(self)){
                let world1level11scene = World1Level11(size: self.frame.size)
                world1level11scene.userData = NSMutableDictionary()
                world1level11scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level11scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level11scene, transition: skTransition)
                
            }else if world1level12node!.containsPoint(touch.locationInNode(self)){
                let world1level12scene = World1Level12(size: self.frame.size)
                world1level12scene.userData = NSMutableDictionary()
                world1level12scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level12scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level12scene, transition: skTransition)
                
            }else if world1level13node!.containsPoint(touch.locationInNode(self)){
                let world1level13scene = World1Level13(size: self.frame.size)
                world1level13scene.userData = NSMutableDictionary()
                world1level13scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level13scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level13scene, transition: skTransition)
                
            }else if world1level14node!.containsPoint(touch.locationInNode(self)){
                let world1level14scene = World1Level14(size: self.frame.size)
                world1level14scene.userData = NSMutableDictionary()
                world1level14scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level14scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level14scene, transition: skTransition)
                
            }else if world1level20node!.containsPoint(touch.locationInNode(self)){
                let world1level20scene = World1Level20(size: self.frame.size)
                world1level20scene.userData = NSMutableDictionary()
                world1level20scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level20scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level20scene, transition: skTransition)
                
            }else if world1level21node!.containsPoint(touch.locationInNode(self)){
                let world1level21scene = World1Level21(size: self.frame.size)
                world1level21scene.userData = NSMutableDictionary()
                world1level21scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level21scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level21scene, transition: skTransition)
                
                // ##### change this for new level #####
                
            }else if inventory!.containsPoint(touch.locationInNode(self)){
                //let inventoryScene = Inventory(size: self.frame.size)
                let skTransition = SKTransition.fadeWithDuration(1.0)
                (self.userData?.objectForKey("inventory") as Inventory).userData?.setObject(self, forKey: "menu")
                self.view?.presentScene(self.userData?.objectForKey("inventory") as Inventory, transition: skTransition)
                
            }else if mainScreen!.containsPoint(touch.locationInNode(self)){
                //let inventoryScene = Inventory(size: self.frame.size)
                let skTransition = SKTransition.fadeWithDuration(1.0)
                //(self.userData?.objectForKey("worldScene") as Inventory).userData?.setObject(self, forKey: "worldScene")
                self.view?.presentScene(self.userData?.objectForKey("worldscene") as ZoneScene, transition: skTransition)
            }
        }
    }
}


