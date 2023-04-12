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
    var gauntletButton: SKSpriteNode?
    var clickedGauntlet = false
    
    var highestLevel = 0
    var highestTime = 0.0
    
    
    // ##### change this for new level#####
    
    var firstTimeLoaded = true
    var beatGame = false
    
    let persistentData = UserDefaults.standard
    
    
    
    override func didMove(to view: SKView) {
        //test
        //highestLevel = 30
        /* Setup your scene here */
        //MUSIC
        if !happyMusic!.isPlaying && soundOn{
            happyMusic!.numberOfLoops = -1
            happyMusic!.prepareToPlay()
            happyMusic!.play()
        }
        
        if highestLevel  == 29 && beatGame == false {
            let gameCompleteNode = SKSpriteNode(imageNamed: "Congrats_1")
            gameCompleteNode.name = "gameComplete"
            gameCompleteNode.size = CGSizeMake(300, 300)
            gameCompleteNode.zPosition = 5
            gameCompleteNode.position = CGPointMake(self.frame.midX, self.frame.midY)
            let waitAction = SKAction.wait(forDuration: 10)
            let runBlock = SKAction.run({gameCompleteNode.removeFromParent()})
            let fadeOutAction = SKAction.fadeOut(withDuration: 2)
            let sequence = SKAction.sequence([waitAction, fadeOutAction, runBlock])
            gameCompleteNode.run(sequence)
            self.addChild(gameCompleteNode)
            beatGame = true
            persistentData.set(true, forKey: "beatgame")
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
            guideNode!.zPosition = 3
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
            Node.zPosition = 3
            let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
            levelIcon.setScale(0.25)
            levelIcon.zPosition = 2
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
            if self.childNode(withName: "world1level1") == nil{
                self.addChild(Node)
            }
        }

        world1level2node = SKSpriteNode(imageNamed: "World_1_Level_2_Text")
        if let Node = world1level2node {
            Node.zPosition = 3
            let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
            levelIcon.zPosition = 2
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
            if self.childNode(withName: "world1level2") == nil && highestLevel >= 1{
                self.addChild(levelIcon)
                self.addChild(Node)
            }
        }
      
            world1level3node = SKSpriteNode(imageNamed: "World_1_Level_3_Text")
            if let Node = world1level3node {
                Node.zPosition = 3
            let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.zPosition = 2
            levelIcon.setScale(0.25)
            levelIcon.position = CGPointMake(self.frame.midX - 75, self.frame.midY - 115)
            Node.setScale(0.25)
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
                if self.childNode(withName: "world1level3") == nil && highestLevel >= 2{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
        }
            
            world1level4node = SKSpriteNode(imageNamed: "World_1_Level_4_Text")
            if let Node = world1level4node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level4") == nil && highestLevel >= 3{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            
            world1level5node = SKSpriteNode(imageNamed: "World_1_Level_5_Text")
            if let Node = world1level5node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level5") == nil && highestLevel >= 4{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            
            world1level6node = SKSpriteNode(imageNamed: "World_1_Level_6_Text")
            if let Node = world1level6node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level6") == nil && highestLevel >= 5{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            
            world1level7node = SKSpriteNode(imageNamed: "World_1_Level_7_Text")
            if let Node = world1level7node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level7") == nil && highestLevel >= 6{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level8node = SKSpriteNode(imageNamed: "World_1_Level_8_Text")
            if let Node = world1level8node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Whale_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level8") == nil && highestLevel >= 7{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level9node = SKSpriteNode(imageNamed: "World_1_Level_9_Text")
            if let Node = world1level9node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level9") == nil && highestLevel >= 8{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level10node = SKSpriteNode(imageNamed: "World_1_Level_10_Text")
            if let Node = world1level10node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level10") == nil && highestLevel >= 9{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level11node = SKSpriteNode(imageNamed: "World_1_Level_11_Text")
            if let Node = world1level11node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level11") == nil && highestLevel >= 10{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level12node = SKSpriteNode(imageNamed: "World_1_Level_12_Text")
            if let Node = world1level12node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Whale_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level12") == nil && highestLevel >= 11{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level13node = SKSpriteNode(imageNamed: "World_1_Level_13_Text")
            if let Node = world1level13node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level13") == nil && highestLevel >= 12{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level14node = SKSpriteNode(imageNamed: "World_1_Level_14_Text")
            if let Node = world1level14node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level14") == nil && highestLevel >= 13{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level15node = SKSpriteNode(imageNamed: "World_1_Level_15_Text")
            if let Node = world1level15node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Whale_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level15") == nil && highestLevel >= 14{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level16node = SKSpriteNode(imageNamed: "World_1_Level_16_Text")
            if let Node = world1level16node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Whale_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level16") == nil && highestLevel >= 15{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level17node = SKSpriteNode(imageNamed: "World_1_Level_17_Text")
            if let Node = world1level17node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Kraken_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level17") == nil && highestLevel >= 16{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level18node = SKSpriteNode(imageNamed: "World_1_Level_18_Text")
            if let Node = world1level18node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level18") == nil && highestLevel >= 17{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level19node = SKSpriteNode(imageNamed: "World_1_Level_19_Text")
            if let Node = world1level19node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Kraken_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level19") == nil && highestLevel >= 18{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level20node = SKSpriteNode(imageNamed: "World_1_Level_20_Text")
            if let Node = world1level20node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level20") == nil && highestLevel >= 19{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level21node = SKSpriteNode(imageNamed: "World_1_Level_21_Text")
            if let Node = world1level21node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Kraken_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level21") == nil && highestLevel >= 20{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level22node = SKSpriteNode(imageNamed: "World_1_Level_22_Text")
            if let Node = world1level22node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level22") == nil && highestLevel >= 21{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level23node = SKSpriteNode(imageNamed: "World_1_Level_23_Text")
            if let Node = world1level23node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Whale_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level23") == nil && highestLevel >= 22{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level24node = SKSpriteNode(imageNamed: "World_1_Level_24_Text")
            if let Node = world1level24node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level24") == nil && highestLevel >= 23{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level25node = SKSpriteNode(imageNamed: "World_1_Level_25_Text")
            if let Node = world1level25node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Kraken_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level25") == nil && highestLevel >= 24{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level26node = SKSpriteNode(imageNamed: "World_1_Level_26_Text")
            if let Node = world1level26node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level26") == nil && highestLevel >= 25{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level27node = SKSpriteNode(imageNamed: "World_1_Level_27_Text")
            if let Node = world1level27node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Kraken_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level27") == nil && highestLevel >= 26{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level28node = SKSpriteNode(imageNamed: "World_1_Level_28_Text")
            if let Node = world1level28node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Clam_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level28") == nil && highestLevel >= 27{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level29node = SKSpriteNode(imageNamed: "World_1_Level_29_Text")
            if let Node = world1level29node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Crab_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level29") == nil && highestLevel >= 28{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            world1level30node = SKSpriteNode(imageNamed: "World_1_Gauntlet_Level_Text_1")
            if let Node = world1level30node {
                Node.zPosition = 3
                let levelIcon = SKSpriteNode(imageNamed: "Gauntlet_Level_Icon_1")
                levelIcon.zPosition = 2
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
                if self.childNode(withName: "world1level30") == nil && highestLevel >= 29{
                    self.addChild(levelIcon)
                    self.addChild(Node)
                }
            }
            
        //ADD HIGHEST LEVEL - 30 IF IN GAUNTLET AND TIMER
        if let highLevel = self.childNode(withName: "highestLevel") as? SKSpriteNode{
            highLevel.removeFromParent()
        }
        if let highLevel = self.childNode(withName: "highestTime") as? SKSpriteNode{
            highLevel.removeFromParent()
        }
        if highestLevel >= 30 {
            //highscore text
            let highscoreText = SKSpriteNode(imageNamed: "High_Score_Text")
            highscoreText.zPosition = 5
            highscoreText.setScale(0.35)
            highscoreText.position = CGPointMake(self.frame.midX - 5, self.frame.midY - 250)
            if is5{
                highscoreText.position = CGPointMake(self.frame.midX - 5, self.frame.midY - 210)
            } else if isPad{
                highscoreText.position = CGPointMake(self.frame.midX - 5, self.frame.midY - 170)
            }
            highscoreText.zPosition = 4
            self.addChild(highscoreText)
            
            //endless text
            let endlessText = SKSpriteNode(imageNamed: "Endless_Mode_Text_2")
            endlessText.setScale(0.5)
            endlessText.zPosition = 5
            endlessText.position = CGPointMake(self.frame.midX + 35, self.frame.midY - 283)
            if is5{
                endlessText.position = CGPointMake(self.frame.midX + 35, self.frame.midY - 243)
            } else if isPad{
                endlessText.position = CGPointMake(self.frame.midX + 35, self.frame.midY - 203)
            }
            self.addChild(endlessText)
            
            //highscore frame
            let highscoreFrame = SKSpriteNode(imageNamed: "High_Score_Frame")
            highscoreFrame.zPosition = 5
            highscoreFrame.size = CGSizeMake(160, 60)
            highscoreFrame.position = CGPointMake(self.frame.midX - 5, self.frame.midY - 290)
            if is5{
                highscoreFrame.position = CGPointMake(self.frame.midX - 5, self.frame.midY - 250)
            } else if isPad{
                highscoreFrame.position = CGPointMake(self.frame.midX - 5, self.frame.midY - 210)
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
                highestLevelText!.position = CGPointMake(self.frame.midX - 40, self.frame.midY - 210)
            }
            highestLevelText!.zPosition = 5
            highestLevelText!.name = "highestLevel"
            highestLevelText!.setScale(0.125)
            self.addChild(highestLevelText!)
            
            if highestLevel == 81 {
                let highestTimeText = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
                highestTimeText.text = "\(Int(highestTime))"
                highestTimeText.zPosition = 5
                highestTimeText.fontColor = UIColor.black
                highestTimeText.position = CGPointMake(self.frame.midX + 40, self.frame.midY - 315)
                if is5{
                    highestTimeText.position = CGPointMake(self.frame.midX + 40, self.frame.midY - 275)
                } else if isPad{
                    highestTimeText.position = CGPointMake(self.frame.midX + 40, self.frame.midY - 235)
                }
                highestTimeText.name = "highestTime"
                highestTimeText.fontSize = 20
                self.addChild(highestTimeText)
            }else {
                let highestTimeText = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
                highestTimeText.text = "0"
                highestTimeText.fontColor = UIColor.black
                highestTimeText.position = CGPointMake(self.frame.midX + 40, self.frame.midY - 315)
                if is5{
                    highestTimeText.position = CGPointMake(self.frame.midX + 40, self.frame.midY - 275)
                } else if isPad{
                    highestTimeText.position = CGPointMake(self.frame.midX + 40, self.frame.midY - 235)
                }
                highestTimeText.name = "highestTime"
                highestTimeText.fontSize = 20
                self.addChild(highestTimeText)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let skTransition = SKTransition.fade(withDuration: 1.0)
        for touch in touches{
                
            if world1level1node!.contains((touch).location(in: self)){
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level1scene = World1Level1(size: self.frame.size)
                world1level1scene.userData = NSMutableDictionary()
                world1level1scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level1scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level1scene, transition: skTransition)
                
            }else if world1level2node!.contains((touch ).location(in: self)) && highestLevel >= 1{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level2scene = World1Level2(size: self.frame.size)
                world1level2scene.userData = NSMutableDictionary()
                world1level2scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level2scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level2scene, transition: skTransition)
                
            }else if world1level3node!.contains((touch ).location(in: self)) && highestLevel >= 2{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level3scene = World1Level3(size: self.frame.size)
                world1level3scene.userData = NSMutableDictionary()
                world1level3scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level3scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level3scene, transition: skTransition)
                
            }else if world1level4node!.contains((touch ).location(in: self)) && highestLevel >= 3{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level4scene = World1Level4(size: self.frame.size)
                world1level4scene.userData = NSMutableDictionary()
                world1level4scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level4scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level4scene, transition: skTransition)
                
            }else if world1level5node!.contains((touch.location(in: self))) && highestLevel >= 4{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level5scene = World1Level5(size: self.frame.size)
                world1level5scene.userData = NSMutableDictionary()
                world1level5scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level5scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level5scene, transition: skTransition)
                
            }else if world1level6node!.contains((touch ).location(in: self)) && highestLevel >= 5{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level6scene = World1Level6(size: self.frame.size)
                world1level6scene.userData = NSMutableDictionary()
                world1level6scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level6scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level6scene, transition: skTransition)
                
            }else if world1level7node!.contains((touch ).location(in: self)) && highestLevel >= 6{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level7scene = World1Level7(size: self.frame.size)
                world1level7scene.userData = NSMutableDictionary()
                world1level7scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level7scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level7scene, transition: skTransition)
                
            }else if world1level8node!.contains((touch ).location(in: self)) && highestLevel >= 7{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level8scene = World1Level8(size: self.frame.size)
                world1level8scene.userData = NSMutableDictionary()
                world1level8scene.userData?.setObject(self.userData?.object(forKey: objectforKey,: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level8scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: fadewithDuration,: 1.0)
                self.view?.presentScene(world1level8scene, transition: skTransition)
                
            }else if world1level9node!.contains((touch ).location(in: self)) && highestLevel >= 8{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level9scene = World1Level9(size: self.frame.size)
                world1level9scene.userData = NSMutableDictionary()
                world1level9scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level9scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level9scene, transition: skTransition)
                
            }else if world1level10node!.contains((touch ).location(in: self)) && highestLevel >= 9{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level10scene = World1Level10(size: self.frame.size)
                world1level10scene.userData = NSMutableDictionary()
                world1level10scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level10scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level10scene, transition: skTransition)
                
            }else if world1level11node!.contains((touch ).location(in: self)) && highestLevel >= 10{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level11scene = World1Level11(size: self.frame.size)
                world1level11scene.userData = NSMutableDictionary()
                world1level11scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level11scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level11scene, transition: skTransition)
                
            }else if world1level12node!.contains((touch ).location(in: self)) && highestLevel >= 11{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level12scene = World1Level12(size: self.frame.size)
                world1level12scene.userData = NSMutableDictionary()
                world1level12scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level12scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level12scene, transition: skTransition)
                
            }else if world1level13node!.contains((touch ).location(in: self)) && highestLevel >= 12{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level13scene = World1Level13(size: self.frame.size)
                world1level13scene.userData = NSMutableDictionary()
                world1level13scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level13scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level13scene, transition: skTransition)
                
            }else if world1level14node!.contains((touch ).location(in: self)) && highestLevel >= 13{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level14scene = World1Level14(size: self.frame.size)
                world1level14scene.userData = NSMutableDictionary()
                world1level14scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level14scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level14scene, transition: skTransition)
                
            }else if world1level15node!.contains((touch ).location(in: self)) && highestLevel >= 14{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level15scene = World1Level15(size: self.frame.size)
                world1level15scene.userData = NSMutableDictionary()
                world1level15scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level15scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level15scene, transition: skTransition)
                
            }else if world1level16node!.contains((touch ).location(in: self)) && highestLevel >= 15{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level16scene = World1Level16(size: self.frame.size)
                world1level16scene.userData = NSMutableDictionary()
                world1level16scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level16scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level16scene, transition: skTransition)
                
            }else if world1level17node!.contains((touch ).location(in: self)) && highestLevel >= 16{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level17scene = World1Level17(size: self.frame.size)
                world1level17scene.userData = NSMutableDictionary()
                world1level17scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level17scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level17scene, transition: skTransition)
                
            }else if world1level18node!.contains((touch ).location(in: self)) && highestLevel >= 17{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level18scene = World1Level18(size: self.frame.size)
                world1level18scene.userData = NSMutableDictionary()
                world1level18scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level18scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level18scene, transition: skTransition)
                
            }else if world1level19node!.contains((touch ).location(in: self)) && highestLevel >= 18{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level19scene = World1Level19(size: self.frame.size)
                world1level19scene.userData = NSMutableDictionary()
                world1level19scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level19scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level19scene, transition: skTransition)
                
            }else if world1level20node!.contains((touch ).location(in: self)) && highestLevel >= 19{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level20scene = World1Level20(size: self.frame.size)
                world1level20scene.userData = NSMutableDictionary()
                world1level20scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level20scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level20scene, transition: skTransition)
                
            }else if world1level21node!.contains((touch ).location(in: self)) && highestLevel >= 20{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level21scene = World1Level21(size: self.frame.size)
                world1level21scene.userData = NSMutableDictionary()
                world1level21scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level21scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level21scene, transition: skTransition)
                
            }else if world1level22node!.contains((touch ).location(in: self)) && highestLevel >= 21{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level22scene = World1Level22(size: self.frame.size)
                world1level22scene.userData = NSMutableDictionary()
                world1level22scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level22scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level22scene, transition: skTransition)
                
            }else if world1level23node!.contains((touch ).location(in: self)) && highestLevel >= 22{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level23scene = World1Level23(size: self.frame.size)
                world1level23scene.userData = NSMutableDictionary()
                world1level23scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level23scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level23scene, transition: skTransition)
                
            }else if world1level24node!.contains((touch ).location(in: self)) && highestLevel >= 23{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level24scene = World1Level24(size: self.frame.size)
                world1level24scene.userData = NSMutableDictionary()
                world1level24scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level24scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level24scene, transition: skTransition)
                
            }else if world1level25node!.contains((touch ).location(in: self)) && highestLevel >= 24{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level25scene = World1Level25(size: self.frame.size)
                world1level25scene.userData = NSMutableDictionary()
                world1level25scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level25scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level25scene, transition: skTransition)
                
            }else if world1level26node!.contains((touch ).location(in: self)) && highestLevel >= 25{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level26scene = World1Level26(size: self.frame.size)
                world1level26scene.userData = NSMutableDictionary()
                world1level26scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level26scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level26scene, transition: skTransition)
                
            }else if world1level27node!.contains((touch ).location(in: self)) && highestLevel >= 26{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level27scene = World1Level27(size: self.frame.size)
                world1level27scene.userData = NSMutableDictionary()
                world1level27scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level27scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level27scene, transition: skTransition)

                
            }else if world1level28node!.contains((touch ).location(in: self)) && highestLevel >= 27{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level28scene = World1Level28(size: self.frame.size)
                world1level28scene.userData = NSMutableDictionary()
                world1level28scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level28scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level28scene, transition: skTransition)
                
            }else if world1level29node!.contains((touch ).location(in: self)) && highestLevel >= 28{
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                    levelMusic!.play()
                }
                happyMusic!.stop()
                let world1level29scene = World1Level29(size: self.frame.size)
                world1level29scene.userData = NSMutableDictionary()
                world1level29scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                world1level29scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(world1level29scene, transition: skTransition)
                
            }else if world1level30node!.contains((touch ).location(in: self)) && highestLevel >= 29{
                if soundOn {
                    self.run(clickSound)
                }
                
                //add enter the gauntlet button
                gauntletButton = SKSpriteNode(imageNamed: "Enter_Text_1")
                gauntletButton!.zPosition = 5
                if is5{
                    gauntletButton!.position = CGPointMake(world1level30node!.position.x + 65, world1level30node!.position.y + 15)
                    gauntletButton!.name = "gauntletButton"
                    gauntletButton!.setScale(0.3)
                } else if isPad{
                    gauntletButton!.position = CGPointMake(world1level30node!.position.x + 65, world1level30node!.position.y + 25)
                    gauntletButton!.name = "gauntletButton"
                    gauntletButton!.setScale(0.3)
                } else if isPlus{
                    gauntletButton!.position = CGPointMake(world1level30node!.position.x + 70, world1level30node!.position.y + 15)
                    gauntletButton!.name = "gauntletButton"
                    gauntletButton!.setScale(0.32)
                } else {
                    gauntletButton!.position = CGPointMake(world1level30node!.position.x + 70, world1level30node!.position.y + 15)
                    gauntletButton!.name = "gauntletButton"
                    gauntletButton!.setScale(0.32)
                }
                self.addChild(gauntletButton!)
                let bootyImage = SKSpriteNode(imageNamed: "Booty_1")
                bootyImage.zPosition = 5
                if is5{
                    bootyImage.position = CGPointMake(world1level30node!.position.x + 80, world1level30node!.position.y - 15)
                    bootyImage.name = "bootyImage"
                    bootyImage.setScale(0.07)
                } else if isPlus{
                    bootyImage.position = CGPointMake(world1level30node!.position.x + 90, world1level30node!.position.y - 15)
                    bootyImage.name = "bootyImage"
                    bootyImage.setScale(0.07)
                }else if isPad{
                    bootyImage.position = CGPointMake(world1level30node!.position.x + 85, world1level30node!.position.y - 0)
                    bootyImage.name = "bootyImage"
                    bootyImage.setScale(0.05)
                }else {
                bootyImage.position = CGPointMake(world1level30node!.position.x + 90, world1level30node!.position.y - 15)
                bootyImage.name = "bootyImage"
                bootyImage.setScale(0.07)
                }
                self.addChild(bootyImage)
                
                let text50 = SKLabelNode()
                text50.zPosition = 5
                text50.text = "50"
                
                if is5{
                    text50.position = CGPointMake(world1level30node!.position.x + 45 , world1level30node!.position.y - 25)
                    text50.fontSize = 26
                } else if isPlus{
                    text50.position = CGPointMake(world1level30node!.position.x + 55 , world1level30node!.position.y - 25)
                    text50.fontSize = 26
                } else if isPad{
                    text50.position = CGPointMake(world1level30node!.position.x + 55 , world1level30node!.position.y - 10)
                    text50.fontSize = 23
                }
                else {
                    text50.position = CGPointMake(world1level30node!.position.x + 55 , world1level30node!.position.y - 25)
                    text50.fontSize = 26
                }
                text50.name = "text50"
                text50.fontName = "ChalkboardSE-Bold"
                text50.fontColor = UIColor.black
                self.addChild(text50)
                clickedGauntlet = true
                
                
                
                // ##### change this for new level #####
                
           /* }else if inventory!.containsPoint(touch.locationInNode(self)){
                //let inventoryScene = Inventory(size: self.frame.size)
                let skTransition = SKTransition.fadeWithDuration(1.0)
                (self.userData?.objectForKey("inventory") as Inventory).userData?.setObject(self, forKey: "menu")
                self.view?.presentScene(self.userData?.objectForKey("inventory") as Inventory, transition: skTransition)*/
                
            }else if gauntletButton != nil && gauntletButton!.contains((touch ).location(in: self)) && clickedGauntlet{
                if (self.userData?.object(forKey: "inventory") as! Inventory).gold >= 50 {
                        //remove gauntletNodes
                        if clickedGauntlet {
                            self.childNode(withName: "gauntletButton")?.removeFromParent()
                            self.childNode(withName: "bootyImage")?.removeFromParent()
                            self.childNode(withName: "text50")?.removeFromParent()
                            clickedGauntlet = false
                        }
                        if soundOn {
                            self.run(bootySound)
                        }
                        (self.userData?.object(forKey: "inventory") as! Inventory).gold -= 50
                        persistentData.set((self.userData?.object(forKey: "inventory") as! Inventory).gold, forKey: "gold")
                        happyMusic!.stop()
                        let world1level30scene = World1Level30(size: self.frame.size)
                        world1level30scene.userData = NSMutableDictionary()
                    world1level30scene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                        world1level30scene.userData?.setObject(self, forKey: "menu" as NSCopying)
                        //level2.userData? = ["menu" : self, "inventory" : self.userData?.objectForKey("inventory") as Inventory]
                    let skTransition = SKTransition.fade(withDuration: 1.0)
                        self.view?.presentScene(world1level30scene, transition: skTransition)
                }
            }else if inventoryNode!.contains((touch ).location(in: self)){
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                }
                let skTransition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(self.userData?.object(forKey: "inventory") as! Inventory, transition: skTransition)
                
            }else if guideNode!.contains((touch ).location(in: self)){
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                }
                let skTransition = SKTransition.fade(withDuration: 1.0)
                let guideScene = GuideScene(size: self.frame.size)
                guideScene.userData = NSMutableDictionary()
                guideScene.userData?.setObject(self, forKey: "menu" as NSCopying)
                self.view?.presentScene(guideScene, transition: skTransition)
                
            }else if storeNode!.contains((touch ).location(in: self)){
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                }
                let aStoreScene = StoreScene(size: self.frame.size)
                aStoreScene.userData = NSMutableDictionary()
                aStoreScene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                //aStoreScene.userData?.setObject(world1Menu!, forKey: "menu")
                aStoreScene.userData?.setObject(self.userData?.object(forKey: "worldscene") as! ZoneScene, forKey: "worldscene" as NSCopying)
                self.view?.presentScene(aStoreScene, transition: skTransition)
            
            } else if menu!.contains((touch ).location(in: self)){
                //remove gauntletNodes
                if clickedGauntlet {
                    self.childNode(withName: "gauntletButton")?.removeFromParent()
                    self.childNode(withName: "bootyImage")?.removeFromParent()
                    self.childNode(withName: "text50")?.removeFromParent()
                    clickedGauntlet = false
                }
                if soundOn {
                    self.run(clickSound)
                }
                
                
                
                let aZoneScene = ZoneScene(size: self.frame.size)
                aZoneScene.userData = NSMutableDictionary()
                aZoneScene.userData?.setObject(self.userData?.object(forKey: "inventory") as! Inventory, forKey: "inventory" as NSCopying)
                //aStoreScene.userData?.setObject(world1Menu!, forKey: "menu")
                aZoneScene.userData?.setObject(self, forKey: "worldscene" as NSCopying)
                //self.view?.presentScene(aZoneScene, transition: skTransition)
                
                    //menuScene.userData?.setValue(self.userData?.objectForKey("inventory"), forKey: "inventory")
                    //(self.userData?.objectForKey("menu") as MainMenuScene).userData?.setObject(self, forKey: "inventory")
                let skTransition = SKTransition.fade(withDuration: 1.0)
                    //self.view?.presentScene(menuScene, transition: skTransition)
                self.view?.presentScene(self.userData?.object(forKey: "worldscene") as! ZoneScene, transition: skTransition)
                
                }
            
        }
    }
}

