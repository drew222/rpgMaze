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
    var beatGame = false
    
    let persistentData = NSUserDefaults.standardUserDefaults()
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //MUSIC
        if !happyMusic.playing && soundOn{
            happyMusic.numberOfLoops = -1
            happyMusic.prepareToPlay()
            happyMusic.play()
        }
        
        if highestLevel  == 29 && beatGame == false {
            let gameCompleteNode = SKSpriteNode(imageNamed: "Congrats_1")
            gameCompleteNode.name = "gameComplete"
            gameCompleteNode.size = CGSizeMake(300, 300)
            gameCompleteNode.zPosition = 3
            gameCompleteNode.position = CGPointMake(self.frame.midX, self.frame.midY)
            let waitAction = SKAction.waitForDuration(10)
            let runBlock = SKAction.runBlock({gameCompleteNode.removeFromParent()})
            let fadeOutAction = SKAction.fadeOutWithDuration(2)
            let sequence = SKAction.sequence([waitAction, fadeOutAction, runBlock])
            gameCompleteNode.runAction(sequence)
            self.addChild(gameCompleteNode)
            beatGame = true
            persistentData.setBool(true, forKey: "beatgame")
        }
        
        if firstTimeLoaded{
            
            let background = SKSpriteNode(imageNamed: "Beach_Background_1.png")
            background.size = self.frame.size
            background.position = CGPointMake(self.frame.midX, self.frame.midY)
            background.zPosition = -1
            self.addChild(background)
            let sandCastle = SKSpriteNode(imageNamed: "Sand_Castle_2.png")
            sandCastle.setScale(0.35)
            sandCastle.position = CGPointMake(self.frame.midX, self.frame.midY - 50)
            if is5{
                sandCastle.setScale(0.3)
                sandCastle.position = CGPointMake(self.frame.midX, self.frame.midY - 36)
            } else if isPad{
                sandCastle.setScale(0.26)
                sandCastle.position = CGPointMake(self.frame.midX, self.frame.midY - 25)
            }
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
            if is5{
                inventoryNode!.size = CGSizeMake(80, 80)
                inventoryNode!.position = CGPointMake(self.frame.midX, self.frame.maxY - 45)
            } else if isPad{
                inventoryNode!.size = CGSizeMake(70, 70)
                inventoryNode!.position = CGPointMake(self.frame.midX, self.frame.maxY - 40)
                inventoryNode!.zPosition = 3
            }
            self.addChild(inventoryNode!)
            storeNode = SKSpriteNode(imageNamed: "Store_Button_1")
            //storeNode!.zPosition = -2
            storeNode!.size = CGSizeMake(100, 100)
            storeNode!.position = CGPointMake(self.frame.maxX - 55, self.frame.maxY - 55)
            if is5{
                storeNode!.size = CGSizeMake(80, 80)
                storeNode!.position = CGPointMake(self.frame.maxX - 45, self.frame.maxY - 45)
            } else if isPad{
                storeNode!.size = CGSizeMake(70, 70)
                storeNode!.position = CGPointMake(self.frame.maxX - 40, self.frame.maxY - 40)
                storeNode!.zPosition = 3
            }
            self.addChild(storeNode!)
            
            menu = SKSpriteNode(imageNamed: "Zones__Button_1")
            menu!.position = CGPointMake(self.frame.minX + 55, self.frame.maxY - 55)
            menu!.name = "zones"
            menu!.size = CGSizeMake(100, 100)
            if is5{
                menu!.position = CGPointMake(self.frame.minX + 45, self.frame.maxY - 45)
                menu!.size = CGSizeMake(80, 80)
            } else if isPad{
                menu!.position = CGPointMake(self.frame.minX + 40, self.frame.maxY - 40)
                menu!.size = CGSizeMake(70, 70)
                menu!.zPosition = 3
            }
            self.addChild(menu!)
            
            guideNode = SKSpriteNode(imageNamed: "Guide_Button_1")
            guideNode!.position = CGPointMake(self.frame.maxX - 55, self.frame.minX + 55)
            guideNode!.size = CGSizeMake(100, 100)
            if is5{
                guideNode!.position = CGPointMake(self.frame.maxX - 45, self.frame.minX + 45)
                guideNode!.size = CGSizeMake(80, 80)
            } else if isPad{
                guideNode!.position = CGPointMake(self.frame.maxX - 40, self.frame.minX + 40)
                guideNode!.size = CGSizeMake(70, 70)
                guideNode!.zPosition = 3
            }
            self.addChild(guideNode!)
            
           
            firstTimeLoaded = false
            
            
        }
        
        world1level1node = SKSpriteNode(imageNamed: "World_1_Level_1_Text")
        if let Node = world1level1node {
            let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
            levelIcon.setScale(0.25)
            levelIcon.position = CGPointMake(self.frame.midX + 3, self.frame.midY - 5)
            if isPad{
                levelIcon.setScale(0.2)
                levelIcon.position = CGPointMake(self.frame.midX + 1, self.frame.midY - 2)
            }
            self.addChild(levelIcon)
            Node.setScale(0.25)
            Node.position = CGPointMake(self.frame.midX + 3, self.frame.midY - 5)
            if isPad{
                Node.setScale(0.2)
                Node.position = CGPointMake(self.frame.midX + 1, self.frame.midY - 2)
            }
            Node.name = "world1level1"
            if self.childNodeWithName("world1level1") == nil{
                self.addChild(Node)
            }
        }

        world1level2node = SKSpriteNode(imageNamed: "World_1_Level_2_Text")
        if let Node = world1level2node {
            let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
            levelIcon.setScale(0.25)
            levelIcon.position = CGPointMake(self.frame.midX - 55, self.frame.midY - 25)
            Node.setScale(0.25)
            Node.position = CGPointMake(self.frame.midX - 55, self.frame.midY - 25)
            if is5{
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 45, self.frame.midY - 15)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 45, self.frame.midY - 15)

            } else if isPad{
                levelIcon.setScale(0.2)
                levelIcon.position = CGPointMake(self.frame.midX - 40, self.frame.midY - 10)
                Node.setScale(0.2)
                Node.position = CGPointMake(self.frame.midX - 40, self.frame.midY - 10)

            }
            Node.name = "world1level2"
            if self.childNodeWithName("world1level2") == nil && highestLevel >= 1{
                self.addChild(levelIcon)
                self.addChild(Node)
            }
        }
      
            world1level3node = SKSpriteNode(imageNamed: "World_1_Level_3_Text")
            if let Node = world1level3node {
            let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
            levelIcon.setScale(0.2)
            levelIcon.position = CGPointMake(self.frame.midX - 75, self.frame.midY - 115)
            Node.setScale(0.2)
            Node.position = CGPointMake(self.frame.midX - 75, self.frame.midY - 115)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX - 55, self.frame.midY - 95)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX - 55, self.frame.midY - 95)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX - 60, self.frame.midY - 70)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX - 60, self.frame.midY - 70)
                }
            Node.name = "world1level3"
                if self.childNodeWithName("world1level3") == nil && highestLevel >= 2{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
        }
            
            world1level4node = SKSpriteNode(imageNamed: "World_1_Level_4_Text")
            if let Node = world1level4node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 110, self.frame.midY - 55)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX - 95, self.frame.midY - 55)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX - 80, self.frame.midY - 20)
                }
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 110, self.frame.midY - 55)
                if is5{
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX - 95, self.frame.midY - 55)
                }else if isPad{
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX - 80, self.frame.midY - 20)
                }
                Node.name = "world1level4"
                if self.childNodeWithName("world1level4") == nil && highestLevel >= 3{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            
            world1level5node = SKSpriteNode(imageNamed: "World_1_Level_5_Text")
            if let Node = world1level5node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 110, self.frame.midY + 15)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 110, self.frame.midY + 15)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX - 95, self.frame.midY + 15)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX - 95, self.frame.midY + 15)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX - 80, self.frame.midY + 30)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX - 80, self.frame.midY + 30)
                }
                Node.name = "world1level5"
                if self.childNodeWithName("world1level5") == nil && highestLevel >= 4{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            
            world1level6node = SKSpriteNode(imageNamed: "World_1_Level_6_Text")
            if let Node = world1level6node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 110, self.frame.midY + 85)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 110, self.frame.midY + 85)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX - 95, self.frame.midY + 85)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX - 95, self.frame.midY + 85)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX - 80, self.frame.midY + 80)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX - 80, self.frame.midY + 80)
                }
                Node.name = "world1level6"
                if self.childNodeWithName("world1level6") == nil && highestLevel >= 5{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            
            world1level7node = SKSpriteNode(imageNamed: "World_1_Level_7_Text")
            if let Node = world1level7node {
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 50, self.frame.midY + 130)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 50, self.frame.midY + 130)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX - 50, self.frame.midY + 120)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX - 50, self.frame.midY + 120)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX - 40, self.frame.midY + 110)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX - 40, self.frame.midY + 110)
                }
                Node.name = "world1level7"
                if self.childNodeWithName("world1level7") == nil && highestLevel >= 6{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level8node = SKSpriteNode(imageNamed: "World_1_Level_8_Text")
            if let Node = world1level8node {
                let levelIcon = SKSpriteNode(imageNamed: "Whale_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 50, self.frame.midY + 135)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 50, self.frame.midY + 135)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX + 50, self.frame.midY + 120)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX + 50, self.frame.midY + 120)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX + 40, self.frame.midY + 110)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX + 40, self.frame.midY + 110)
                }
                Node.name = "world1level8"
                if self.childNodeWithName("world1level8") == nil && highestLevel >= 7{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level9node = SKSpriteNode(imageNamed: "World_1_Level_9_Text")
            if let Node = world1level9node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 110, self.frame.midY + 85)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 110, self.frame.midY + 85)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX + 95, self.frame.midY + 85)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX + 95, self.frame.midY + 85)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX + 80, self.frame.midY + 80)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX + 80, self.frame.midY + 80)
                }
                Node.name = "world1level9"
                if self.childNodeWithName("world1level9") == nil && highestLevel >= 8{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level10node = SKSpriteNode(imageNamed: "World_1_Level_10_Text")
            if let Node = world1level10node {
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 110, self.frame.midY + 15)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 110, self.frame.midY + 15)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX + 95, self.frame.midY + 15)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX + 95, self.frame.midY + 15)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX + 80, self.frame.midY + 30)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX + 80, self.frame.midY + 30)
                }
                Node.name = "world1level10"
                if self.childNodeWithName("world1level10") == nil && highestLevel >= 9{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level11node = SKSpriteNode(imageNamed: "World_1_Level_11_Text")
            if let Node = world1level11node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 110, self.frame.midY - 55)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 110, self.frame.midY - 55)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX + 95, self.frame.midY - 55)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX + 95, self.frame.midY - 55)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX + 80, self.frame.midY - 20)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX + 80, self.frame.midY - 20)
                }
                Node.name = "world1level11"
                if self.childNodeWithName("world1level11") == nil && highestLevel >= 10{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level12node = SKSpriteNode(imageNamed: "World_1_Level_12_Text")
            if let Node = world1level12node {
                let levelIcon = SKSpriteNode(imageNamed: "Whale_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 75, self.frame.midY - 115)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 75, self.frame.midY - 115)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX + 55, self.frame.midY - 95)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX + 55, self.frame.midY - 95)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX + 60, self.frame.midY - 70)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX + 60, self.frame.midY - 70)
                }
                Node.name = "world1level12"
                if self.childNodeWithName("world1level12") == nil && highestLevel >= 11{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level13node = SKSpriteNode(imageNamed: "World_1_Level_13_Text")
            if let Node = world1level13node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX, self.frame.midY - 120)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX, self.frame.midY - 120)
                if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX + 10, self.frame.midY - 75)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX + 10, self.frame.midY - 75)
                }
                Node.name = "world1level13"
                if self.childNodeWithName("world1level13") == nil && highestLevel >= 12{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level14node = SKSpriteNode(imageNamed: "World_1_Level_14_Text")
            if let Node = world1level14node {
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 35, self.frame.midY - 210)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 35, self.frame.midY - 210)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX + 30, self.frame.midY - 175)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX + 30, self.frame.midY - 175)
                }else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX + 35, self.frame.midY - 145)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX + 35, self.frame.midY - 145)
                }
                Node.name = "world1level14"
                if self.childNodeWithName("world1level14") == nil && highestLevel >= 13{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level15node = SKSpriteNode(imageNamed: "World_1_Level_15_Text")
            if let Node = world1level15node {
                let levelIcon = SKSpriteNode(imageNamed: "Whale_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 110, self.frame.midY - 210)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 110, self.frame.midY - 210)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX + 90, self.frame.midY - 175)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX + 90, self.frame.midY - 175)
                }else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX + 90, self.frame.midY - 145)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX + 90, self.frame.midY - 145)
                }
                Node.name = "world1level15"
                if self.childNodeWithName("world1level15") == nil && highestLevel >= 14{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level16node = SKSpriteNode(imageNamed: "World_1_Level_16_Text")
            if let Node = world1level16node {
                let levelIcon = SKSpriteNode(imageNamed: "Whale_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 155, self.frame.midY - 150)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 155, self.frame.midY - 150)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX + 135, self.frame.midY - 130)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX + 135, self.frame.midY - 130)
                }else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX + 115, self.frame.midY - 100)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX + 115, self.frame.midY - 100)
                }
                Node.name = "world1level16"
                if self.childNodeWithName("world1level16") == nil && highestLevel >= 15{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level17node = SKSpriteNode(imageNamed: "World_1_Level_17_Text")
            if let Node = world1level17node {
                let levelIcon = SKSpriteNode(imageNamed: "Kraken_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 155, self.frame.midY - 80)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 155, self.frame.midY - 80)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX + 135, self.frame.midY - 70)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX + 135, self.frame.midY - 70)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX + 115, self.frame.midY - 45)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX + 115, self.frame.midY - 45)
                }
                Node.name = "world1level17"
                if self.childNodeWithName("world1level17") == nil && highestLevel >= 16{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level18node = SKSpriteNode(imageNamed: "World_1_Level_18_Text")
            if let Node = world1level18node {
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 155, self.frame.midY - 10)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 155, self.frame.midY - 10)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX + 135, self.frame.midY - 10)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX + 135, self.frame.midY - 10)
                }else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX + 115, self.frame.midY + 5)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX + 115, self.frame.midY + 5)
                }
                Node.name = "world1level18"
                if self.childNodeWithName("world1level18") == nil && highestLevel >= 17{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level19node = SKSpriteNode(imageNamed: "World_1_Level_19_Text")
            if let Node = world1level19node {
                let levelIcon = SKSpriteNode(imageNamed: "Kraken_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 155, self.frame.midY + 60)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 155, self.frame.midY + 60)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX + 135, self.frame.midY + 50)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX + 135, self.frame.midY + 50)

                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX + 115, self.frame.midY + 55)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX + 115, self.frame.midY + 55)

                }
                Node.name = "world1level19"
                if self.childNodeWithName("world1level19") == nil && highestLevel >= 18{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level20node = SKSpriteNode(imageNamed: "World_1_Level_20_Text")
            if let Node = world1level20node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 155, self.frame.midY + 130)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 155, self.frame.midY + 130)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX + 135, self.frame.midY + 110)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX + 135, self.frame.midY + 110)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX + 115, self.frame.midY + 105)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX + 115, self.frame.midY + 105)
                }
                Node.name = "world1level20"
                if self.childNodeWithName("world1level20") == nil && highestLevel >= 19{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level21node = SKSpriteNode(imageNamed: "World_1_Level_21_Text")
            if let Node = world1level21node {
                let levelIcon = SKSpriteNode(imageNamed: "Kraken_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 110, self.frame.midY + 180)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 110, self.frame.midY + 180)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX + 110, self.frame.midY + 160)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX + 110, self.frame.midY + 160)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX + 90, self.frame.midY + 145)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX + 90, self.frame.midY + 145)
                }
                Node.name = "world1level21"
                if self.childNodeWithName("world1level21") == nil && highestLevel >= 20{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level22node = SKSpriteNode(imageNamed: "World_1_Level_22_Text")
            if let Node = world1level22node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX + 40, self.frame.midY + 180)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX + 40, self.frame.midY + 180)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX + 40, self.frame.midY + 160)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX + 40, self.frame.midY + 160)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX + 30, self.frame.midY + 145)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX + 30, self.frame.midY + 145)
                }
                Node.name = "world1level22"
                if self.childNodeWithName("world1level22") == nil && highestLevel >= 21{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level23node = SKSpriteNode(imageNamed: "World_1_Level_23_Text")
            if let Node = world1level23node {
                let levelIcon = SKSpriteNode(imageNamed: "Whale_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 40, self.frame.midY + 180)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 40, self.frame.midY + 180)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX - 40, self.frame.midY + 160)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX - 40, self.frame.midY + 160)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX - 30, self.frame.midY + 145)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX - 30, self.frame.midY + 145)
                }
                Node.name = "world1level23"
                if self.childNodeWithName("world1level23") == nil && highestLevel >= 22{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level24node = SKSpriteNode(imageNamed: "World_1_Level_24_Text")
            if let Node = world1level24node {
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 110, self.frame.midY + 180)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 110, self.frame.midY + 180)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX - 110, self.frame.midY + 160)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX - 110, self.frame.midY + 160)
                }else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX - 90, self.frame.midY + 145)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX - 90, self.frame.midY + 145)
                }
                Node.name = "world1level24"
                if self.childNodeWithName("world1level24") == nil && highestLevel >= 23{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level25node = SKSpriteNode(imageNamed: "World_1_Level_25_Text")
            if let Node = world1level25node {
                let levelIcon = SKSpriteNode(imageNamed: "Kraken_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 155, self.frame.midY + 130)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 155, self.frame.midY + 130)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX - 135, self.frame.midY + 110)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX - 135, self.frame.midY + 110)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX - 115, self.frame.midY + 105)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX - 115, self.frame.midY + 105)
                }

                Node.name = "world1level25"
                if self.childNodeWithName("world1level25") == nil && highestLevel >= 24{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level26node = SKSpriteNode(imageNamed: "World_1_Level_26_Text")
            if let Node = world1level26node {
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 155, self.frame.midY + 60)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 155, self.frame.midY + 60)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX - 135, self.frame.midY + 50)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX - 135, self.frame.midY + 50)
                    
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX - 115, self.frame.midY + 55)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX - 115, self.frame.midY + 55)
                    
                }

                Node.name = "world1level26"
                if self.childNodeWithName("world1level26") == nil && highestLevel >= 25{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level27node = SKSpriteNode(imageNamed: "World_1_Level_27_Text")
            if let Node = world1level27node {
                let levelIcon = SKSpriteNode(imageNamed: "Kraken_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 155, self.frame.midY - 10)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 155, self.frame.midY - 10)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX - 135, self.frame.midY - 10)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX - 135, self.frame.midY - 10)
                }else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX - 115, self.frame.midY + 5)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX - 115, self.frame.midY + 5)
                }

                Node.name = "world1level27"
                if self.childNodeWithName("world1level27") == nil && highestLevel >= 26{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level28node = SKSpriteNode(imageNamed: "World_1_Level_28_Text")
            if let Node = world1level28node {
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 155, self.frame.midY - 80)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 155, self.frame.midY - 80)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX - 135, self.frame.midY - 70)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX - 135, self.frame.midY - 70)
                } else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX - 115, self.frame.midY - 45)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX - 115, self.frame.midY - 45)
                }

                Node.name = "world1level28"
                if self.childNodeWithName("world1level28") == nil && highestLevel >= 27{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level29node = SKSpriteNode(imageNamed: "World_1_Level_29_Text")
            if let Node = world1level29node {
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.setScale(0.25)
                levelIcon.position = CGPointMake(self.frame.midX - 155, self.frame.midY - 150)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 155, self.frame.midY - 150)
                if is5{
                    levelIcon.setScale(0.25)
                    levelIcon.position = CGPointMake(self.frame.midX - 135, self.frame.midY - 130)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX - 135, self.frame.midY - 130)
                }else if isPad{
                    levelIcon.setScale(0.2)
                    levelIcon.position = CGPointMake(self.frame.midX - 115, self.frame.midY - 100)
                    Node.setScale(0.2)
                    Node.position = CGPointMake(self.frame.midX - 115, self.frame.midY - 100)
                }
                Node.name = "world1level29"
                if self.childNodeWithName("world1level29") == nil && highestLevel >= 28{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level30node = SKSpriteNode(imageNamed: "World_1_Gauntlet_Level_Text_1")
            if let Node = world1level30node {
                let levelIcon = SKSpriteNode(imageNamed: "Gauntlet_Level_Icon_1")
                levelIcon.setScale(0.35)
                levelIcon.position = CGPointMake(self.frame.midX - 110, self.frame.midY - 215)
                Node.setScale(0.25)
                Node.position = CGPointMake(self.frame.midX - 110, self.frame.midY - 215)
                if is5{
                    levelIcon.setScale(0.35)
                    levelIcon.position = CGPointMake(self.frame.midX - 95, self.frame.midY - 175)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX - 95, self.frame.midY - 175)
                } else if isPad{
                    levelIcon.setScale(0.35)
                    levelIcon.position = CGPointMake(self.frame.midX - 90, self.frame.midY - 145)
                    Node.setScale(0.25)
                    Node.position = CGPointMake(self.frame.midX - 90, self.frame.midY - 145)

                }
                Node.name = "world1level30"
                if self.childNodeWithName("world1level30") == nil && highestLevel >= 29{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
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
            highscoreText.setScale(0.35)
            highscoreText.position = CGPointMake(self.frame.midX - 5, self.frame.midY - 250)
            if is5{
                highscoreText.position = CGPointMake(self.frame.midX - 5, self.frame.midY - 210)
            } else if isPad{
                highscoreText.position = CGPointMake(self.frame.midX - 5, self.frame.midY - 250)
            }
            highscoreText.zPosition = 4
            self.addChild(highscoreText)
            
            //endless text
            let endlessText = SKSpriteNode(imageNamed: "Endless_Mode_Text_2")
            endlessText.setScale(0.5)
            endlessText.position = CGPointMake(self.frame.midX + 35, self.frame.midY - 283)
            if is5{
                endlessText.position = CGPointMake(self.frame.midX + 35, self.frame.midY - 243)
            } else if isPad{
                endlessText.position = CGPointMake(self.frame.midX + 35, self.frame.midY - 283)
            }
            self.addChild(endlessText)
            
            //highscore frame
            let highscoreFrame = SKSpriteNode(imageNamed: "High_Score_Frame")
            highscoreFrame.size = CGSizeMake(160, 60)
            highscoreFrame.position = CGPointMake(self.frame.midX - 5, self.frame.midY - 290)
            if is5{
                highscoreFrame.position = CGPointMake(self.frame.midX - 5, self.frame.midY - 250)
            } else if isPad{
                highscoreFrame.position = CGPointMake(self.frame.midX - 5, self.frame.midY - 290)
            }
            self.addChild(highscoreFrame)
            var highestLevelText: SKSpriteNode?
            if highestLevel - 30 < 51{
                highestLevelText = SKSpriteNode(imageNamed: "Phase_\(highestLevel - 30)_Text")
            }else{
                highestLevelText = SKSpriteNode(imageNamed: "Phase_\(highestLevel - 31)_Text")
            }
            highestLevelText!.position = CGPointMake(self.frame.midX - 40, self.frame.midY - 290)
            if is5{
                highestLevelText!.position = CGPointMake(self.frame.midX - 40, self.frame.midY - 250)
            } else if isPad{
                highestLevelText!.position = CGPointMake(self.frame.midX - 40, self.frame.midY - 290)
            }
            highestLevelText!.name = "highestLevel"
            highestLevelText!.setScale(0.125)
            self.addChild(highestLevelText!)
            
            if highestLevel == 81 {
                let highestTimeText = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
                highestTimeText.text = "\(Int(highestTime))"
                highestTimeText.fontColor = UIColor.blackColor()
                highestTimeText.position = CGPointMake(self.frame.midX + 40, self.frame.midY - 315)
                if is5{
                    highestTimeText.position = CGPointMake(self.frame.midX + 40, self.frame.midY - 275)
                } else if isPad{
                    highestTimeText.position = CGPointMake(self.frame.midX + 40, self.frame.midY - 315)
                }
                highestTimeText.name = "highestTime"
                highestTimeText.fontSize = 20
                self.addChild(highestTimeText)
            }else {
                let highestTimeText = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
                highestTimeText.text = "0"
                highestTimeText.fontColor = UIColor.blackColor()
                highestTimeText.position = CGPointMake(self.frame.midX + 40, self.frame.midY - 315)
                if is5{
                    highestTimeText.position = CGPointMake(self.frame.midX + 40, self.frame.midY - 275)
                } else if isPad{
                    highestTimeText.position = CGPointMake(self.frame.midX + 40, self.frame.midY - 315)
                }
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
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level1scene = World1Level1(size: self.frame.size)
                world1level1scene.userData = NSMutableDictionary()
                world1level1scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level1scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level1scene, transition: skTransition)
                
            }else if world1level2node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 1{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level2scene = World1Level2(size: self.frame.size)
                world1level2scene.userData = NSMutableDictionary()
                world1level2scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level2scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level2scene, transition: skTransition)
                
            }else if world1level3node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 2{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level3scene = World1Level3(size: self.frame.size)
                world1level3scene.userData = NSMutableDictionary()
                world1level3scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level3scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level3scene, transition: skTransition)
                
            }else if world1level4node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 3{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level4scene = World1Level4(size: self.frame.size)
                world1level4scene.userData = NSMutableDictionary()
                world1level4scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level4scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level4scene, transition: skTransition)
                
            }else if world1level5node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 4{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level5scene = World1Level5(size: self.frame.size)
                world1level5scene.userData = NSMutableDictionary()
                world1level5scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level5scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level5scene, transition: skTransition)
                
            }else if world1level6node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 5{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level6scene = World1Level6(size: self.frame.size)
                world1level6scene.userData = NSMutableDictionary()
                world1level6scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level6scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level6scene, transition: skTransition)
                
            }else if world1level7node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 6{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level7scene = World1Level7(size: self.frame.size)
                world1level7scene.userData = NSMutableDictionary()
                world1level7scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level7scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level7scene, transition: skTransition)
                
            }else if world1level8node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 7{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level8scene = World1Level8(size: self.frame.size)
                world1level8scene.userData = NSMutableDictionary()
                world1level8scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level8scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level8scene, transition: skTransition)
                
            }else if world1level9node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 8{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level9scene = World1Level9(size: self.frame.size)
                world1level9scene.userData = NSMutableDictionary()
                world1level9scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level9scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level9scene, transition: skTransition)
                
            }else if world1level10node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 9{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level10scene = World1Level10(size: self.frame.size)
                world1level10scene.userData = NSMutableDictionary()
                world1level10scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level10scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level10scene, transition: skTransition)
                
            }else if world1level11node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 10{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level11scene = World1Level11(size: self.frame.size)
                world1level11scene.userData = NSMutableDictionary()
                world1level11scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level11scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level11scene, transition: skTransition)
                
            }else if world1level12node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 11{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level12scene = World1Level12(size: self.frame.size)
                world1level12scene.userData = NSMutableDictionary()
                world1level12scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level12scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level12scene, transition: skTransition)
                
            }else if world1level13node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 12{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level13scene = World1Level13(size: self.frame.size)
                world1level13scene.userData = NSMutableDictionary()
                world1level13scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level13scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level13scene, transition: skTransition)
                
            }else if world1level14node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 13{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level14scene = World1Level14(size: self.frame.size)
                world1level14scene.userData = NSMutableDictionary()
                world1level14scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level14scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level14scene, transition: skTransition)
                
            }else if world1level15node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 14{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level15scene = World1Level15(size: self.frame.size)
                world1level15scene.userData = NSMutableDictionary()
                world1level15scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level15scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level15scene, transition: skTransition)
                
            }else if world1level16node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 15{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level16scene = World1Level16(size: self.frame.size)
                world1level16scene.userData = NSMutableDictionary()
                world1level16scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level16scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level16scene, transition: skTransition)
                
            }else if world1level17node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 16{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level17scene = World1Level17(size: self.frame.size)
                world1level17scene.userData = NSMutableDictionary()
                world1level17scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level17scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level17scene, transition: skTransition)
                
            }else if world1level18node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 17{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level18scene = World1Level18(size: self.frame.size)
                world1level18scene.userData = NSMutableDictionary()
                world1level18scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level18scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level18scene, transition: skTransition)
                
            }else if world1level19node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 18{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level19scene = World1Level19(size: self.frame.size)
                world1level19scene.userData = NSMutableDictionary()
                world1level19scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level19scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level19scene, transition: skTransition)
                
            }else if world1level20node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 19{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level20scene = World1Level20(size: self.frame.size)
                world1level20scene.userData = NSMutableDictionary()
                world1level20scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level20scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level20scene, transition: skTransition)
                
            }else if world1level21node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 20{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level21scene = World1Level21(size: self.frame.size)
                world1level21scene.userData = NSMutableDictionary()
                world1level21scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level21scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level21scene, transition: skTransition)
                
            }else if world1level22node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 21{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level22scene = World1Level22(size: self.frame.size)
                world1level22scene.userData = NSMutableDictionary()
                world1level22scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level22scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level22scene, transition: skTransition)
                
            }else if world1level23node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 22{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level23scene = World1Level23(size: self.frame.size)
                world1level23scene.userData = NSMutableDictionary()
                world1level23scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level23scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level23scene, transition: skTransition)
                
            }else if world1level24node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 23{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level24scene = World1Level24(size: self.frame.size)
                world1level24scene.userData = NSMutableDictionary()
                world1level24scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level24scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level24scene, transition: skTransition)
                
            }else if world1level25node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 24{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level25scene = World1Level25(size: self.frame.size)
                world1level25scene.userData = NSMutableDictionary()
                world1level25scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level25scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level25scene, transition: skTransition)
                
            }else if world1level26node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 25{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level26scene = World1Level26(size: self.frame.size)
                world1level26scene.userData = NSMutableDictionary()
                world1level26scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level26scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level26scene, transition: skTransition)
                
            }else if world1level27node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 26{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level27scene = World1Level27(size: self.frame.size)
                world1level27scene.userData = NSMutableDictionary()
                world1level27scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level27scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level27scene, transition: skTransition)

                
            }else if world1level28node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 27{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level28scene = World1Level28(size: self.frame.size)
                world1level28scene.userData = NSMutableDictionary()
                world1level28scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level28scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level28scene, transition: skTransition)
                
            }else if world1level29node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 28{
                if soundOn {
                    self.runAction(clickSound)
                    levelMusic.play()
                }
                happyMusic.stop()
                let world1level29scene = World1Level29(size: self.frame.size)
                world1level29scene.userData = NSMutableDictionary()
                world1level29scene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                world1level29scene.userData?.setObject(self, forKey: "menu")
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(world1level29scene, transition: skTransition)
                
            }else if world1level30node!.containsPoint((touch as! UITouch).locationInNode(self)) && highestLevel >= 29{
                if soundOn {
                    self.runAction(clickSound)
                }
                happyMusic.stop()
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
                if soundOn {
                    self.runAction(clickSound)
                }
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(self.userData?.objectForKey("inventory") as! Inventory, transition: skTransition)
                
            }else if guideNode!.containsPoint((touch as! UITouch).locationInNode(self)){
                if soundOn {
                    self.runAction(clickSound)
                }
                let skTransition = SKTransition.fadeWithDuration(1.0)
                let guideScene = GuideScene(size: self.frame.size)
                guideScene.userData = NSMutableDictionary()
                guideScene.userData?.setObject(self, forKey: "menu")
                self.view?.presentScene(guideScene, transition: skTransition)
                
            }else if storeNode!.containsPoint((touch as! UITouch).locationInNode(self)){
                if soundOn {
                    self.runAction(clickSound)
                }
                let aStoreScene = StoreScene(size: self.frame.size)
                aStoreScene.userData = NSMutableDictionary()
                aStoreScene.userData?.setObject(self.userData?.objectForKey("inventory") as! Inventory, forKey: "inventory")
                //aStoreScene.userData?.setObject(world1Menu!, forKey: "menu")
                aStoreScene.userData?.setObject(self.userData?.objectForKey("worldscene") as! ZoneScene, forKey: "worldscene")
                self.view?.presentScene(aStoreScene, transition: skTransition)
            
            } else if menu!.containsPoint((touch as! UITouch).locationInNode(self)){
                if soundOn {
                    self.runAction(clickSound)
                }
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
            
        }
    }
}

