//
//  MainMenuScene.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 2/8/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit


//import AVFoundation

class MainMenuScene: SKScene {
    var inventory: Inventory?
    var zonesMenu: ZoneScene?
    var theStore: StoreScene?
    var storeNode: SKSpriteNode?
    var inventoryNode: SKSpriteNode?
    var level1Node: SKSpriteNode?
    var level2Node: SKLabelNode?
    var level3Node: SKLabelNode?
    var level4Node: SKLabelNode?
    var level5Node: SKLabelNode?
    //var inventory: SKLabelNode?
    var mainScreen: SKLabelNode?
    var menu: SKSpriteNode?
    var world1level1node: SKSpriteNode?
    var world1level2node: SKSpriteNode?
    var world1level3node: SKSpriteNode?
    var world1level4node: SKSpriteNode?
    var world1level5node: SKSpriteNode?
    var world1level6node: SKSpriteNode?
    var world1level7node: SKSpriteNode?
    var world1level8node: SKSpriteNode?
    var world1level9node: SKSpriteNode?
    var world1level10node: SKSpriteNode?
    var world1level11node: SKSpriteNode?
    var world1level12node: SKSpriteNode?
    var world1level13node: SKSpriteNode?
    var world1level14node: SKSpriteNode?
    var world1level15node: SKSpriteNode?
    var world1level16node: SKSpriteNode?
    var world1level17node: SKSpriteNode?
    var world1level18node: SKSpriteNode?
    var world1level19node: SKSpriteNode?
    var world1level20node: SKSpriteNode?
    var world1level21node: SKSpriteNode?
    var world1level26node: SKSpriteNode?
    var world1level27node: SKSpriteNode?
    var world1level28node: SKSpriteNode?
    
    // ##### change this for new level#####
    
    var firstTimeLoaded = true
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        if firstTimeLoaded{
            let background = SKSpriteNode(imageNamed: "Beach_Background_1.png")
            background.size = self.frame.size
            background.position = CGPointMake(self.frame.midX, self.frame.midY)
            background.zPosition = -1
            self.addChild(background)
            let sandCastle = SKSpriteNode(imageNamed: "Sand_Castle_1.png")
            sandCastle.setScale(0.35)
            sandCastle.position = CGPointMake(self.frame.midX, self.frame.midY - 50)
            self.addChild(sandCastle)
            
            zonesMenu = ZoneScene(size: self.frame.size)
            zonesMenu!.userData = NSMutableDictionary()
            zonesMenu!.userData?.setObject(self, forKey: "worldscene")
            inventory = Inventory(size: self.frame.size)
            zonesMenu!.userData?.setObject(inventory!, forKey: "inventory")
            
            inventory!.userData = NSMutableDictionary()
            inventory!.userData?.setObject(zonesMenu!, forKey: "menu")
            inventory!.userData?.setObject(self, forKey: "worldscene")
            
            
            
            theStore = StoreScene(size:self.frame.size)
            theStore!.userData = NSMutableDictionary()
            theStore!.userData?.setObject(self, forKey: "worldscene")
            theStore!.userData?.setObject(zonesMenu!, forKey: "menu")
            
           
            inventoryNode = SKSpriteNode(imageNamed: "Fitting_Room__Button_1")
            //inventoryNode!.zPosition = -2
            inventoryNode!.size = CGSizeMake(100, 100)
            inventoryNode!.position = CGPointMake(self.frame.midX, self.frame.maxY - 55)
            self.addChild(inventoryNode!)
            storeNode = SKSpriteNode(imageNamed: "Store_Button_1")
            //storeNode!.zPosition = -2
            storeNode!.size = CGSizeMake(100, 100)
            storeNode!.position = CGPointMake(self.frame.maxX - 55, self.frame.maxY - 55)
            self.addChild(storeNode!)
            
            menu = SKSpriteNode(imageNamed: "Zones__Button_1")
            menu!.position = CGPointMake(self.frame.minX + 55, self.frame.maxY - 55)
            menu!.name = "zones"
            menu!.size = CGSizeMake(100, 100)
            self.addChild(menu!)
            /*
            inventory = SKLabelNode.init(text: "Inventory")
            inventory!.position = CGPointMake(self.frame.maxX - 70, self.frame.minY + 40)
            inventory!.name = "inventory"
            self.addChild(inventory!)
            firstTimeLoaded = false
            
            mainScreen = SKLabelNode.init(text: "Main Menu")
            mainScreen!.position = CGPointMake(self.frame.minX + 70, self.frame.minY + 40)
            mainScreen!.name = "inventory"
            self.addChild(mainScreen!)
            firstTimeLoaded = false */
            
        /*
        level1Node = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
        level1Node!.size = CGSizeMake(40, 40)
        level1Node!.position = CGPointMake(self.frame.midX + 120, self.frame.midY - 10)
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
        */
        world1level1node = SKSpriteNode(imageNamed: "World_1_Level_1_Text")
        if let Node = world1level1node {
            let levelIcon = SKSpriteNode(imageNamed: "Clam_Boss_Level_Icon_1")
            Node.setScale(0.4)
            levelIcon.position = CGPointMake(self.frame.midX, self.frame.midY)
            self.addChild(levelIcon)
            Node.setScale(0.4)
            Node.position = CGPointMake(self.frame.midX, self.frame.midY)
            Node.name = "world1level1"
            self.addChild(Node)
        }

        world1level2node = SKSpriteNode(imageNamed: "World_1_Level_2_Text")
        if let Node = world1level2node {
            Node.setScale(0.4)
            Node.position = CGPointMake(self.frame.midX - 45, self.frame.midY - 25)
            Node.name = "world1level2"
            self.addChild(Node)
        }
      
            world1level3node = SKSpriteNode(imageNamed: "World_1_Level_3_Text")
            if let Node = world1level3node {
                Node.setScale(0.4)
            Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 250)
            Node.name = "world1level3"
            self.addChild(Node)
        }
            
            world1level4node = SKSpriteNode(imageNamed: "World_1_Level_4_Text")
            if let Node = world1level4node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 225)
                Node.name = "world1level4"
                self.addChild(Node)
            }
            
            world1level5node = SKSpriteNode(imageNamed: "World_1_Level_5_Text")
            if let Node = world1level5node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 200)
                Node.name = "world1level5"
                self.addChild(Node)
            }
            
            world1level6node = SKSpriteNode(imageNamed: "World_1_Level_6_Text")
            if let Node = world1level6node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 175)
                Node.name = "world1level6"
                self.addChild(Node)
            }
            
            world1level7node = SKSpriteNode(imageNamed: "World_1_Level_7_Text")
            if let Node = world1level7node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 150)
                Node.name = "world1level7"
                self.addChild(Node)
            }
            world1level8node = SKSpriteNode(imageNamed: "World_1_Level_8_Text")
            if let Node = world1level8node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 125)
                Node.name = "world1level8"
                self.addChild(Node)
            }
            world1level9node = SKSpriteNode(imageNamed: "World_1_Level_9_Text")
            if let Node = world1level9node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 100)
                Node.name = "world1level9"
                self.addChild(Node)
            }
            world1level10node = SKSpriteNode(imageNamed: "World_1_Level_10_Text")
            if let Node = world1level10node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 75)
                Node.name = "world1level10"
                self.addChild(Node)
            }
            world1level11node = SKSpriteNode(imageNamed: "World_1_Level_11_Text")
            if let Node = world1level11node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 50)
                Node.name = "world1level11"
                self.addChild(Node)
            }
            world1level12node = SKSpriteNode(imageNamed: "World_1_Level_12_Text")
            if let Node = world1level12node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY + 25)
                Node.name = "world1level12"
                self.addChild(Node)
            }
            world1level13node = SKSpriteNode(imageNamed: "World_1_Level_13_Text")
            if let Node = world1level13node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY)
                Node.name = "world1level13"
                self.addChild(Node)
            }
            world1level14node = SKSpriteNode(imageNamed: "World_1_Level_14_Text")
            if let Node = world1level14node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY - 25)
                Node.name = "world1level14"
                self.addChild(Node)
            }
            world1level15node = SKSpriteNode(imageNamed: "World_1_Level_15_Text")
            if let Node = world1level15node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY - 50)
                Node.name = "world1level15"
                self.addChild(Node)
            }
            world1level16node = SKSpriteNode(imageNamed: "World_1_Level_16_Text")
            if let Node = world1level16node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY - 75)
                Node.name = "world1level16"
                self.addChild(Node)
            }
            world1level17node = SKSpriteNode(imageNamed: "World_1_Level_17_Text")
            if let Node = world1level17node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY - 100)
                Node.name = "world1level17"
                self.addChild(Node)
            }
            world1level18node = SKSpriteNode(imageNamed: "World_1_Level_18_Text")
            if let Node = world1level18node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX + 100, self.frame.midY + 300)
                Node.name = "world1level18"
                self.addChild(Node)
            }
            world1level19node = SKSpriteNode(imageNamed: "World_1_Level_19_Text")
            if let Node = world1level19node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY - 125)
                Node.name = "world1level19"
                self.addChild(Node)
            }
            world1level20node = SKSpriteNode(imageNamed: "World_1_Level_20_Text")
            if let Node = world1level20node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY - 150)
                Node.name = "world1level20"
                self.addChild(Node)
            }
            world1level21node = SKSpriteNode(imageNamed: "World_1_Level_21_Text")
            if let Node = world1level21node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY - 175)
                Node.name = "world1level21"
                self.addChild(Node)
            }
            world1level26node = SKSpriteNode(imageNamed: "World_1_Level_26_Text")
            if let Node = world1level26node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY - 200)
                Node.name = "world1level26"
                self.addChild(Node)
            }
            world1level27node = SKSpriteNode(imageNamed: "World_1_Level_27_Text")
            if let Node = world1level27node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY - 225)
                Node.name = "world1level27"
                self.addChild(Node)
            }
            world1level28node = SKSpriteNode(imageNamed: "World_1_Level_28_Text")
            if let Node = world1level28node {
                Node.setScale(0.4)
                Node.position = CGPointMake(self.frame.midX - 100, self.frame.midY - 250)
                Node.name = "world1level28"
                self.addChild(Node)
            }

            // #####change this for new level#####
        
        
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let skTransition = SKTransition.fadeWithDuration(1.0)
        for touch in touches{
            
            /*
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
                */
                
            if world1level1node!.containsPoint(touch.locationInNode(self)){
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
                
            }else if world1level15node!.containsPoint(touch.locationInNode(self)){
                let world1level15scene = World1Level15(size: self.frame.size)
                world1level15scene.userData = NSMutableDictionary()
                world1level15scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level15scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level15scene, transition: skTransition)
                
            }else if world1level16node!.containsPoint(touch.locationInNode(self)){
                let world1level16scene = World1Level16(size: self.frame.size)
                world1level16scene.userData = NSMutableDictionary()
                world1level16scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level16scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level16scene, transition: skTransition)
                
            }else if world1level17node!.containsPoint(touch.locationInNode(self)){
                let world1level17scene = World1Level17(size: self.frame.size)
                world1level17scene.userData = NSMutableDictionary()
                world1level17scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level17scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level17scene, transition: skTransition)
                
            }else if world1level18node!.containsPoint(touch.locationInNode(self)){
                let world1level18scene = World1Level18(size: self.frame.size)
                world1level18scene.userData = NSMutableDictionary()
                world1level18scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level18scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level18scene, transition: skTransition)
                
            }else if world1level19node!.containsPoint(touch.locationInNode(self)){
                let world1level19scene = World1Level19(size: self.frame.size)
                world1level19scene.userData = NSMutableDictionary()
                world1level19scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level19scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level19scene, transition: skTransition)
                
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
                
            }else if world1level26node!.containsPoint(touch.locationInNode(self)){
                let world1level26scene = World1Level26(size: self.frame.size)
                world1level26scene.userData = NSMutableDictionary()
                world1level26scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level26scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level26scene, transition: skTransition)
                
            }else if world1level27node!.containsPoint(touch.locationInNode(self)){
                let world1level27scene = World1Level27(size: self.frame.size)
                world1level27scene.userData = NSMutableDictionary()
                world1level27scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level27scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level27scene, transition: skTransition)

                
            }else if world1level28node!.containsPoint(touch.locationInNode(self)){
                let world1level28scene = World1Level28(size: self.frame.size)
                world1level28scene.userData = NSMutableDictionary()
                world1level28scene.userData?.setObject(self.userData?.objectForKey("inventory") as Inventory, forKey: "inventory")
                world1level28scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level28scene, transition: skTransition)
                
                // ##### change this for new level #####
                
           /* }else if inventory!.containsPoint(touch.locationInNode(self)){
                //let inventoryScene = Inventory(size: self.frame.size)
                let skTransition = SKTransition.fadeWithDuration(1.0)
                (self.userData?.objectForKey("inventory") as Inventory).userData?.setObject(self, forKey: "menu")
                self.view?.presentScene(self.userData?.objectForKey("inventory") as Inventory, transition: skTransition)*/
                
            }else if inventoryNode!.containsPoint(touch.locationInNode(self)){
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(inventory, transition: skTransition)
                
            }else if storeNode!.containsPoint(touch.locationInNode(self)){
                let aStoreScene = StoreScene(size: self.frame.size)
                aStoreScene.userData = NSMutableDictionary()
                aStoreScene.userData?.setObject(inventory!, forKey: "inventory")
                //aStoreScene.userData?.setObject(world1Menu!, forKey: "menu")
                aStoreScene.userData?.setObject(self, forKey: "worldscene")
                self.view?.presentScene(aStoreScene, transition: skTransition)
            
            } else if menu!.containsPoint(touch.locationInNode(self)){
                    //let menuScene = MainMenuScene(size: self.frame.size)
                    //menuScene.userData?.setValue(self.userData?.objectForKey("inventory"), forKey: "inventory")
                    //(self.userData?.objectForKey("menu") as MainMenuScene).userData?.setObject(self, forKey: "inventory")
                    let skTransition = SKTransition.fadeWithDuration(1.0)
                    //self.view?.presentScene(menuScene, transition: skTransition)
                    self.view?.presentScene(self.userData?.objectForKey("worldscene") as ZoneScene, transition: skTransition)
                
                }
             /*
            
            }else if inventoryNode!.containsPoint(touch.locationInNode(self)){
            self.view?.presentScene(inventory, transition: skTransition)
            }else if storeNode!.containsPoint(touch.locationInNode(self)){
            let aStoreScene = StoreScene(size: self.frame.size)
            aStoreScene.userData = NSMutableDictionary()
            aStoreScene.userData?.setObject(inventory!, forKey: "inventory")
            //aStoreScene.userData?.setObject(world1Menu!, forKey: "menu")
            aStoreScene.userData?.setObject(self, forKey: "worldscene")
            self.view?.presentScene(aStoreScene, transition: skTransition)
            
            
            
            
            
            
            }else if mainScreen!.containsPoint(touch.locationInNode(self)){
                //let inventoryScene = Inventory(size: self.frame.size)
                let skTransition = SKTransition.fadeWithDuration(1.0)
                //(self.userData?.objectForKey("worldScene") as Inventory).userData?.setObject(self, forKey: "worldScene")
                self.view?.presentScene(self.userData?.objectForKey("worldscene") as ZoneScene, transition: skTransition)
            }
                        */
        }
    }
}

