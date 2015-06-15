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
    
    //var zonesMenu: ZoneScene?
   //var inventory: Inventory?
    var storeNode: SKSpriteNode?
    var inventoryNode: SKSpriteNode?
    var guideNode: SKSpriteNode?
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
    var world1level22node: SKSpriteNode?
    var world1level23node: SKSpriteNode?
    var world1level24node: SKSpriteNode?
    var world1level25node: SKSpriteNode?
    var world1level26node: SKSpriteNode?
    var world1level27node: SKSpriteNode?
    var world1level28node: SKSpriteNode?
    var world1level29node: SKSpriteNode?
    var world1level30node: SKSpriteNode?
    
    var highestLevel = 0
    var highestTime = 0.0
    
    
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
            let sandCastle = SKSpriteNode(imageNamed: "Sand_Castle_2.png")
            sandCastle.setScale(0.35)
            sandCastle.position = CGPointMake(self.frame.midX, self.frame.midY - 50)
            self.addChild(sandCastle)
        
            
            //zonesMenu = ZoneScene(size: self.frame.size)
            //zonesMenu!.userData = NSMutableDictionary()
            //zonesMenu!.userData?.setObject(self, forKey: "levelscene")
            //inventory = Inventory(size: self.frame.size)
            //zonesMenu!.userData?.setObject(inventory!, forKey: "inventory")
            //inventory!.userData = NSMutableDictionary()
            //inventory!.userData?.setObject(zonesMenu!, forKey: "menu")
            //inventory!.userData?.setObject(self, forKey: "levelscene")
            
            
           
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
            
            guideNode = SKSpriteNode(imageNamed: "Guide_Button_1")
            guideNode!.position = CGPointMake(self.frame.maxX - 30, 30)
            guideNode!.size = CGSizeMake(50, 50)
            self.addChild(guideNode!)
            
           
            
        
        world1level1node = SKSpriteNode(imageNamed: "World_1_Level_1_Text")
        if let Node = world1level1node {
            let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
            levelIcon.setScale(0.25)
            levelIcon.position = CGPointMake(self.frame.midX + 3, self.frame.midY - 5)
            self.addChild(levelIcon)
            Node.setScale(0.25)
            Node.position = CGPointMake(self.frame.midX + 3, self.frame.midY - 5)
            Node.name = "world1level1"
            self.addChild(Node)
        }

        world1level2node = SKSpriteNode(imageNamed: "World_1_Level_2_Text")
        if let Node = world1level2node {
            let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
            levelIcon.setScale(0.25)
            levelIcon.position = CGPointMake(self.frame.midX - 55, self.frame.midY - 25)
            self.addChild(levelIcon)
            Node.setScale(0.25)
            Node.position = CGPointMake(self.frame.midX - 55, self.frame.midY - 25)
            Node.name = "world1level2"
            self.addChild(Node)
        }
      
            world1level3node = SKSpriteNode(imageNamed: "World_1_Level_3_Text")
            if let Node = world1level3node {
            let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
            levelIcon.setScale(0.25)
            levelIcon.position = CGPointMake(self.frame.midX - 75, self.frame.midY - 115)
            self.addChild(levelIcon)
            Node.setScale(0.25)
            Node.position = CGPointMake(self.frame.midX - 75, self.frame.midY - 115)
            Node.name = "world1level3"
            self.addChild(Node)
        }
            
            world1level4node = SKSpriteNode(imageNamed: "World_1_Level_4_Text")
            if let Node = world1level4node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 110, self.frame.midY - 55)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 110, self.frame.midY - 55)
                Node.name = "world1level4"
                self.addChild(Node)
            }
            
            world1level5node = SKSpriteNode(imageNamed: "World_1_Level_5_Text")
            if let Node = world1level5node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 110, self.frame.midY + 15)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 110, self.frame.midY + 15)
                Node.name = "world1level5"
                self.addChild(Node)
            }
            
            world1level6node = SKSpriteNode(imageNamed: "World_1_Level_6_Text")
            if let Node = world1level6node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 110, self.frame.midY + 85)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 110, self.frame.midY + 85)
                Node.name = "world1level6"
                self.addChild(Node)
            }
            
            world1level7node = SKSpriteNode(imageNamed: "World_1_Level_7_Text")
            if let Node = world1level7node {
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 50, self.frame.midY + 130)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 50, self.frame.midY + 130)
                Node.name = "world1level7"
                self.addChild(Node)
            }
            world1level8node = SKSpriteNode(imageNamed: "World_1_Level_8_Text")
            if let Node = world1level8node {
                let levelIcon = SKSpriteNode(imageNamed: "Whale_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 50, self.frame.midY + 135)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 50, self.frame.midY + 135)
                Node.name = "world1level8"
                self.addChild(Node)
            }
            world1level9node = SKSpriteNode(imageNamed: "World_1_Level_9_Text")
            if let Node = world1level9node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 110, self.frame.midY + 85)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 110, self.frame.midY + 85)
                Node.name = "world1level9"
                self.addChild(Node)
            }
            world1level10node = SKSpriteNode(imageNamed: "World_1_Level_10_Text")
            if let Node = world1level10node {
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 110, self.frame.midY + 15)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 110, self.frame.midY + 15)
                Node.name = "world1level10"
                self.addChild(Node)
            }
            world1level11node = SKSpriteNode(imageNamed: "World_1_Level_11_Text")
            if let Node = world1level11node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 110, self.frame.midY - 55)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 110, self.frame.midY - 55)
                Node.name = "world1level11"
                self.addChild(Node)
            }
            world1level12node = SKSpriteNode(imageNamed: "World_1_Level_12_Text")
            if let Node = world1level12node {
                let levelIcon = SKSpriteNode(imageNamed: "Whale_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 75, self.frame.midY - 115)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 75, self.frame.midY - 115)
                Node.name = "world1level12"
                self.addChild(Node)
            }
            world1level13node = SKSpriteNode(imageNamed: "World_1_Level_13_Text")
            if let Node = world1level13node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX, self.frame.midY - 120)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX, self.frame.midY - 120)
                Node.name = "world1level13"
                self.addChild(Node)
            }
            world1level14node = SKSpriteNode(imageNamed: "World_1_Level_14_Text")
            if let Node = world1level14node {
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 35, self.frame.midY - 210)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 35, self.frame.midY - 210)
                Node.name = "world1level14"
                self.addChild(Node)
            }
            world1level15node = SKSpriteNode(imageNamed: "World_1_Level_15_Text")
            if let Node = world1level15node {
                let levelIcon = SKSpriteNode(imageNamed: "Whale_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 110, self.frame.midY - 210)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 110, self.frame.midY - 210)
                Node.name = "world1level15"
                self.addChild(Node)
            }
            world1level16node = SKSpriteNode(imageNamed: "World_1_Level_16_Text")
            if let Node = world1level16node {
                let levelIcon = SKSpriteNode(imageNamed: "Whale_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 155, self.frame.midY - 150)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 155, self.frame.midY - 150)
                Node.name = "world1level16"
                self.addChild(Node)
            }
            world1level17node = SKSpriteNode(imageNamed: "World_1_Level_17_Text")
            if let Node = world1level17node {
                let levelIcon = SKSpriteNode(imageNamed: "Kraken_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 155, self.frame.midY - 80)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 155, self.frame.midY - 80)
                Node.name = "world1level17"
                self.addChild(Node)
            }
            world1level18node = SKSpriteNode(imageNamed: "World_1_Level_18_Text")
            if let Node = world1level18node {
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 155, self.frame.midY - 10)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 155, self.frame.midY - 10)
                Node.name = "world1level18"
                self.addChild(Node)
            }
            world1level19node = SKSpriteNode(imageNamed: "World_1_Level_19_Text")
            if let Node = world1level19node {
                let levelIcon = SKSpriteNode(imageNamed: "Kraken_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 155, self.frame.midY + 60)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 155, self.frame.midY + 60)
                Node.name = "world1level19"
                self.addChild(Node)
            }
            world1level20node = SKSpriteNode(imageNamed: "World_1_Level_20_Text")
            if let Node = world1level20node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 155, self.frame.midY + 130)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 155, self.frame.midY + 130)
                Node.name = "world1level20"
                self.addChild(Node)
            }
            world1level21node = SKSpriteNode(imageNamed: "World_1_Level_21_Text")
            if let Node = world1level21node {
                let levelIcon = SKSpriteNode(imageNamed: "Kraken_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 110, self.frame.midY + 180)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 110, self.frame.midY + 180)
                Node.name = "world1level21"
                self.addChild(Node)
            }
            world1level22node = SKSpriteNode(imageNamed: "World_1_Level_22_Text")
            if let Node = world1level22node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 40, self.frame.midY + 180)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 40, self.frame.midY + 180)
                Node.name = "world1level22"
                self.addChild(Node)
            }
            world1level23node = SKSpriteNode(imageNamed: "World_1_Level_23_Text")
            if let Node = world1level23node {
                let levelIcon = SKSpriteNode(imageNamed: "Whale_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 40, self.frame.midY + 180)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 40, self.frame.midY + 180)
                Node.name = "world1level23"
                self.addChild(Node)
            }
            world1level24node = SKSpriteNode(imageNamed: "World_1_Level_24_Text")
            if let Node = world1level24node {
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 110, self.frame.midY + 180)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 110, self.frame.midY + 180)
                Node.name = "world1level24"
                self.addChild(Node)
            }
            world1level25node = SKSpriteNode(imageNamed: "World_1_Level_25_Text")
            if let Node = world1level25node {
                let levelIcon = SKSpriteNode(imageNamed: "Kraken_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 155, self.frame.midY + 130)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 155, self.frame.midY + 130)
                Node.name = "world1level25"
                self.addChild(Node)
            }
            world1level26node = SKSpriteNode(imageNamed: "World_1_Level_26_Text")
            if let Node = world1level26node {
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 155, self.frame.midY + 60)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 155, self.frame.midY + 60)
                Node.name = "world1level26"
                self.addChild(Node)
            }
            world1level27node = SKSpriteNode(imageNamed: "World_1_Level_27_Text")
            if let Node = world1level27node {
                let levelIcon = SKSpriteNode(imageNamed: "Kraken_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 155, self.frame.midY - 10)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 155, self.frame.midY - 10)
                Node.name = "world1level27"
                self.addChild(Node)
            }
            world1level28node = SKSpriteNode(imageNamed: "World_1_Level_28_Text")
            if let Node = world1level28node {
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 155, self.frame.midY - 80)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 155, self.frame.midY - 80)
                Node.name = "world1level28"
                self.addChild(Node)
            }
            world1level29node = SKSpriteNode(imageNamed: "World_1_Level_29_Text")
            if let Node = world1level29node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 155, self.frame.midY - 150)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 155, self.frame.midY - 150)
                Node.name = "world1level29"
                self.addChild(Node)
            }
            world1level30node = SKSpriteNode(imageNamed: "World_1_Gauntlet_Level_Text_1")
            if let Node = world1level30node {
                let levelIcon = SKSpriteNode(imageNamed: "Gauntlet_Level_Icon_1")
                levelIcon.setScale(0.35)
                levelIcon.position = CGPointMake(self.frame.midX - 110, self.frame.midY - 215)
                self.addChild(levelIcon)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 110, self.frame.midY - 215)
                Node.name = "world1level30"
                self.addChild(Node)
            }
            
            firstTimeLoaded = false
        
        
        }
        println("highestLevel = \(highestLevel)")
        println("highestTime = \(highestTime)")
        //ADD HIGHEST LEVEL - 30 IF IN GAUNTLET AND TIMER
        if let highLevel = self.childNodeWithName("highestLevel") as? SKSpriteNode{
            highLevel.removeFromParent()
        }
        if let highLevel = self.childNodeWithName("highestTime") as? SKSpriteNode{
            highLevel.removeFromParent()
        }
        if highestLevel > 30 {
            //highscore text
            let highscoreText = SKSpriteNode(imageNamed: "High_Score_Text")
            highscoreText.size = CGSizeMake(90, 20)
            highscoreText.position = CGPointMake(self.frame.midX - 10, 57)
            self.addChild(highscoreText)
            
            //endless text
            let endlessText = SKSpriteNode(imageNamed: "Endless_Mode_Text_2")
            endlessText.size = CGSizeMake(80, 30)
            endlessText.position = CGPointMake(self.frame.midX + 80, 55)
            self.addChild(endlessText)
            
            //highscore frame
            let highscoreFrame = SKSpriteNode(imageNamed: "High_Score_Frame")
            highscoreFrame.size = CGSizeMake(200, 60)
            highscoreFrame.position = CGPointMake(self.frame.midX + 30, 45)
            self.addChild(highscoreFrame)
            var highestLevelText: SKSpriteNode?
            if highestLevel - 30 < 51{
                highestLevelText = SKSpriteNode(imageNamed: "Phase_\(highestLevel - 30)_Text")
            }else{
                highestLevelText = SKSpriteNode(imageNamed: "Phase_\(highestLevel - 31)_Text")
            }
            highestLevelText!.position = CGPointMake(self.frame.midX - 10, 30)
            highestLevelText!.name = "highestLevel"
            highestLevelText!.size = CGSizeMake(150, 40)
            self.addChild(highestLevelText!)
            
            if highestLevel == 81 {
                let highestTimeText = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
                highestTimeText.text = "\(Int(highestTime))"
                highestTimeText.fontColor = UIColor.blackColor()
                highestTimeText.position = CGPointMake(self.frame.midX + 90, 20)
                highestTimeText.name = "highestTime"
                highestTimeText.fontSize = 20
                self.addChild(highestTimeText)
            }else {
                let highestTimeText = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
                highestTimeText.text = "0"
                highestTimeText.fontColor = UIColor.blackColor()
                highestTimeText.position = CGPointMake(self.frame.midX + 90, 20)
                highestTimeText.name = "highestTime"
                highestTimeText.fontSize = 20
                self.addChild(highestTimeText)
            }
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let skTransition = SKTransition.fadeWithDuration(1.0)
        for touch in touches{
                
            if world1level1node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level1scene = World1Level1(size: self.frame.size)
                world1level1scene.userData = NSMutableDictionary()
                world1level1scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level1scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level1scene, transition: skTransition)
                
            }else if world1level2node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level2scene = World1Level2(size: self.frame.size)
                world1level2scene.userData = NSMutableDictionary()
                world1level2scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level2scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level2scene, transition: skTransition)
                
            }else if world1level3node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level3scene = World1Level3(size: self.frame.size)
                world1level3scene.userData = NSMutableDictionary()
                world1level3scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level3scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level3scene, transition: skTransition)
                
            }else if world1level4node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level4scene = World1Level4(size: self.frame.size)
                world1level4scene.userData = NSMutableDictionary()
                world1level4scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level4scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level4scene, transition: skTransition)
                
            }else if world1level5node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level5scene = World1Level5(size: self.frame.size)
                world1level5scene.userData = NSMutableDictionary()
                world1level5scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level5scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level5scene, transition: skTransition)
                
            }else if world1level6node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level6scene = World1Level6(size: self.frame.size)
                world1level6scene.userData = NSMutableDictionary()
                world1level6scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level6scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level6scene, transition: skTransition)
                
            }else if world1level7node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level7scene = World1Level7(size: self.frame.size)
                world1level7scene.userData = NSMutableDictionary()
                world1level7scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level7scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level7scene, transition: skTransition)
                
            }else if world1level8node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level8scene = World1Level8(size: self.frame.size)
                world1level8scene.userData = NSMutableDictionary()
                world1level8scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level8scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level8scene, transition: skTransition)
                
            }else if world1level9node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level9scene = World1Level9(size: self.frame.size)
                world1level9scene.userData = NSMutableDictionary()
                world1level9scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level9scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level9scene, transition: skTransition)
                
            }else if world1level10node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level10scene = World1Level10(size: self.frame.size)
                world1level10scene.userData = NSMutableDictionary()
                world1level10scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level10scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level10scene, transition: skTransition)
                
            }else if world1level11node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level11scene = World1Level11(size: self.frame.size)
                world1level11scene.userData = NSMutableDictionary()
                world1level11scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level11scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level11scene, transition: skTransition)
                
            }else if world1level12node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level12scene = World1Level12(size: self.frame.size)
                world1level12scene.userData = NSMutableDictionary()
                world1level12scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level12scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level12scene, transition: skTransition)
                
            }else if world1level13node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level13scene = World1Level13(size: self.frame.size)
                world1level13scene.userData = NSMutableDictionary()
                world1level13scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level13scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level13scene, transition: skTransition)
                
            }else if world1level14node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level14scene = World1Level14(size: self.frame.size)
                world1level14scene.userData = NSMutableDictionary()
                world1level14scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level14scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level14scene, transition: skTransition)
                
            }else if world1level15node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level15scene = World1Level15(size: self.frame.size)
                world1level15scene.userData = NSMutableDictionary()
                world1level15scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level15scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level15scene, transition: skTransition)
                
            }else if world1level16node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level16scene = World1Level16(size: self.frame.size)
                world1level16scene.userData = NSMutableDictionary()
                world1level16scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level16scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level16scene, transition: skTransition)
                
            }else if world1level17node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level17scene = World1Level17(size: self.frame.size)
                world1level17scene.userData = NSMutableDictionary()
                world1level17scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level17scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level17scene, transition: skTransition)
                
            }else if world1level18node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level18scene = World1Level18(size: self.frame.size)
                world1level18scene.userData = NSMutableDictionary()
                world1level18scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level18scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level18scene, transition: skTransition)
                
            }else if world1level19node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level19scene = World1Level19(size: self.frame.size)
                world1level19scene.userData = NSMutableDictionary()
                world1level19scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level19scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level19scene, transition: skTransition)
                
            }else if world1level20node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level20scene = World1Level20(size: self.frame.size)
                world1level20scene.userData = NSMutableDictionary()
                world1level20scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level20scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level20scene, transition: skTransition)
                
            }else if world1level21node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level21scene = World1Level21(size: self.frame.size)
                world1level21scene.userData = NSMutableDictionary()
                world1level21scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level21scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level21scene, transition: skTransition)
                
            }else if world1level22node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level22scene = World1Level22(size: self.frame.size)
                world1level22scene.userData = NSMutableDictionary()
                world1level22scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level22scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level22scene, transition: skTransition)
                
            }else if world1level23node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level23scene = World1Level23(size: self.frame.size)
                world1level23scene.userData = NSMutableDictionary()
                world1level23scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level23scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level23scene, transition: skTransition)
                
            }else if world1level24node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level24scene = World1Level24(size: self.frame.size)
                world1level24scene.userData = NSMutableDictionary()
                world1level24scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level24scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level24scene, transition: skTransition)
                
            }else if world1level25node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level25scene = World1Level25(size: self.frame.size)
                world1level25scene.userData = NSMutableDictionary()
                world1level25scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level25scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level25scene, transition: skTransition)
                
            }else if world1level26node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level26scene = World1Level26(size: self.frame.size)
                world1level26scene.userData = NSMutableDictionary()
                world1level26scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level26scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level26scene, transition: skTransition)
                
            }else if world1level27node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level27scene = World1Level27(size: self.frame.size)
                world1level27scene.userData = NSMutableDictionary()
                world1level27scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level27scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level27scene, transition: skTransition)

                
            }else if world1level28node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level28scene = World1Level28(size: self.frame.size)
                world1level28scene.userData = NSMutableDictionary()
                world1level28scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level28scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level28scene, transition: skTransition)
                
            }else if world1level29node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level29scene = World1Level29(size: self.frame.size)
                world1level29scene.userData = NSMutableDictionary()
                world1level29scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level29scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level29scene, transition: skTransition)
                
            }else if world1level30node!.containsPoint((touch as! UITouch).locationInNode(self)){
                let world1level30scene = World1Level30(size: self.frame.size)
                world1level30scene.userData = NSMutableDictionary()
                world1level30scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level30scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level30scene, transition: skTransition)
                
                // ##### change this for new level #####
                
           /* }else if inventory!.containsPoint(touch.locationInNode(self)){
                //let inventoryScene = Inventory(size: self.frame.size)
                let skTransition = SKTransition.fadeWithDuration(1.0)
                (self.userData?.objectForKey("inventory") as Inventory).userData?.setObject(self, forKey: "menu")
                self.view?.presentScene(self.userData?.objectForKey("inventory") as Inventory, transition: skTransition)*/
                
            }else if inventoryNode!.containsPoint((touch as! UITouch).locationInNode(self)){
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(self.userData?.objectForKey("inventory") as! Inventory, transition: skTransition)
                
            }else if guideNode!.containsPoint((touch as! UITouch).locationInNode(self)){
                let skTransition = SKTransition.fadeWithDuration(1.0)
                let guideScene = GuideScene(size: self.frame.size)
                guideScene.userData = NSMutableDictionary()
                guideScene.userData?.setObject(self, forKey: "menu")
                self.view?.presentScene(guideScene, transition: skTransition)
                
            }else if storeNode!.containsPoint((touch as! UITouch).locationInNode(self)){
                let aStoreScene = StoreScene(size: self.frame.size)
                aStoreScene.userData = NSMutableDictionary()
                aStoreScene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                //aStoreScene.userData?.setObject(world1Menu!, forKey: "menu")
                aStoreScene.userData?.setObject(self.userData?.objectForKey("worldscene") as! ZoneScene, forKey: "worldscene")
                self.view?.presentScene(aStoreScene, transition: skTransition)
            
            } else if menu!.containsPoint((touch as! UITouch).locationInNode(self)){
                let aZoneScene = ZoneScene(size: self.frame.size)
                aZoneScene.userData = NSMutableDictionary()
                aZoneScene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                //aStoreScene.userData?.setObject(world1Menu!, forKey: "menu")
                aZoneScene.userData?.setObject(self, forKey: "worldscene")
                self.view?.presentScene(aZoneScene, transition: skTransition)
                
                    //menuScene.userData?.setValue(self.userData?.objectForKey("inventory"), forKey: "inventory")
                    //(self.userData?.objectForKey("menu") as MainMenuScene).userData?.setObject(self, forKey: "inventory")
                    let skTransition = SKTransition.fadeWithDuration(1.0)
                    //self.view?.presentScene(menuScene, transition: skTransition)
                    self.view?.presentScene(self.userData?.objectForKey("worldscene") as! ZoneScene, transition: skTransition)
                
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

