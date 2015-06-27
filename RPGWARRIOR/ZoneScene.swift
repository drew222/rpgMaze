//
//  ZoneScene.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 3/9/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation
import iAd


class ZoneScene: SKScene, ADBannerViewDelegate {
    
    var world1Menu: MainMenuScene?
    var inventory: Inventory?
    var firstLoad = true
    var world1Node: SKSpriteNode?
    var inventoryNode: SKSpriteNode?
    var storeNode: SKSpriteNode?
    var zonesTextNode: SKSpriteNode?
    var tutorialButton: SKSpriteNode?
    var soundOnButton: SKSpriteNode?
    let defaults = NSUserDefaults.standardUserDefaults()
    var backgroundMusic: AVAudioPlayer?
    var mediumRectAdView: ADBannerView?
    var addLoaded = false
    
    override func didMoveToView(view: SKView) {
        if addLoaded {
            addLoaded = false
        }
        mediumRectAdView = ADBannerView(adType: ADAdType.Banner)
        mediumRectAdView!.delegate = self
        /* Setup your scene here */
        //MUSIC
        //check for saved data on sound off/on, set spritenode to this and set soundOn
        if firstLoad{
        if (defaults.objectForKey("sound") as! Bool) {
            soundOn = true
            soundOnButton = SKSpriteNode(imageNamed: "Sound_On_Button_1")
        }else {
            soundOn = false
            soundOnButton = SKSpriteNode(imageNamed: "Sound_Off_Button_1")
        }
        soundOnButton!.size = CGSizeMake(100, 100)
            soundOnButton!.position = CGPointMake(self.frame.minX + 55, self.frame.minY + 110)
            if is5{
                soundOnButton!.size = CGSizeMake(80, 80)
                soundOnButton!.position = CGPointMake(self.frame.minX + 45, self.frame.minY + 90)
            } else if isPad {
                soundOnButton!.size = CGSizeMake(70, 70)
                soundOnButton!.position = CGPointMake(self.frame.minX + 40, self.frame.minY + 85)
            }
        
        soundOnButton!.name = "soundButton"
        soundOnButton!.zPosition = 3
        self.addChild(soundOnButton!)
        }
        if (!happyMusic.playing) && soundOn{
            happyMusic.numberOfLoops = -1
            happyMusic.prepareToPlay()
            happyMusic.play()
        }
        
        let background = SKSpriteNode(imageNamed: "Zone_Screen_2")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.addChild(background)
        if firstLoad{
            var beatGame2: Bool?
            if defaults.objectForKey("beatgame") as! Bool {
                beatGame2 = true
            }else{
                beatGame2 = false
            }
            
            world1Menu = MainMenuScene(size: self.frame.size)
            world1Menu!.beatGame = beatGame2!
            world1Menu!.userData = NSMutableDictionary()
            world1Menu!.userData?.setObject(self, forKey: "worldscene")
            inventory = Inventory.createInventory(self.frame.size)
            world1Menu!.userData?.setObject(inventory!, forKey: "inventory")
            inventory!.userData = NSMutableDictionary()
            inventory!.userData?.setObject(world1Menu!, forKey: "menu")
            inventory!.userData?.setObject(self, forKey: "worldscene")
            
            //******SETUP SAVED DATA FOR INVENTORY AND MainMenuScene HERE********
            if let bestLevel = defaults.objectForKey("highestLevel") as? Int{
                world1Menu!.highestLevel = bestLevel
            }
            if let bestTime = defaults.objectForKey("highestTime") as? Double{
                world1Menu!.highestTime = bestTime
            }
            if let gold = defaults.objectForKey("gold") as? CGFloat{
                inventory!.gold = gold
            }
            if let head = defaults.objectForKey("headSpace") as? String{
                if head != "" {
                    let item = ItemClass.itemInSpace("\(head)")
                    (inventory!.childNodeWithName("weapon") as! ItemSpaceNode).insertItem(item)
                    inventory!.displayItem(item, spot: "weapon")
                    inventory!.weapon = item
                }
            }
            if let neck = defaults.objectForKey("neckSpace") as? String{
                if neck != "" {
                    let item = ItemClass.itemInSpace("\(neck)")
                    (inventory!.childNodeWithName("neck") as! ItemSpaceNode).insertItem(item)
                    inventory!.displayItem(item, spot: "neck")
                    inventory!.neck = item
                }
            }
            if let left = defaults.objectForKey("leftSpace") as? String{
                if left != "" {
                    let item = ItemClass.itemInSpace("\(left)")
                    (inventory!.childNodeWithName("body") as! ItemSpaceNode).insertItem(item)
                    inventory!.displayItem(item, spot: "body")
                    inventory!.body = item
                }
            }
            if let right = defaults.objectForKey("rightSpace") as? String{
                if right != "" {
                    let item = ItemClass.itemInSpace("\(right)")
                    (inventory!.childNodeWithName("feet") as! ItemSpaceNode).insertItem(item)
                    inventory!.displayItem(item, spot: "feet")
                    inventory!.feet = item
                }
            }
            if let spot1 = defaults.objectForKey("packSpace1") as? String{
                if spot1 != "" {
                    let item = ItemClass.itemInSpace("\(spot1)")
                    (inventory!.childNodeWithName("1") as! ItemSpaceNode).insertItem(item)
                    inventory!.backPackSpaces--
                }
            }
            if let spot2 = defaults.objectForKey("packSpace2") as? String{
                if spot2 != "" {
                    let item = ItemClass.itemInSpace("\(spot2)")
                    (inventory!.childNodeWithName("2") as! ItemSpaceNode).insertItem(item)
                    inventory!.backPackSpaces--
                }
            }
            if let spot3 = defaults.objectForKey("packSpace3") as? String{
                if spot3 != "" {
                    let item = ItemClass.itemInSpace("\(spot3)")
                    (inventory!.childNodeWithName("3") as! ItemSpaceNode).insertItem(item)
                    inventory!.backPackSpaces--
                }
            }
            if let spot4 = defaults.objectForKey("packSpace4") as? String{
                if spot4 != "" {
                    let item = ItemClass.itemInSpace("\(spot4)")
                    (inventory!.childNodeWithName("4") as! ItemSpaceNode).insertItem(item)
                    inventory!.backPackSpaces--
                }
            }
            if let spot5 = defaults.objectForKey("packSpace5") as? String{
                if spot5 != "" {
                    let item = ItemClass.itemInSpace("\(spot5)")
                    (inventory!.childNodeWithName("5") as! ItemSpaceNode).insertItem(item)
                    inventory!.backPackSpaces--
                }
            }
            if let spot6 = defaults.objectForKey("packSpace6") as? String{
                if spot6 != "" {
                    let item = ItemClass.itemInSpace("\(spot6)")
                    (inventory!.childNodeWithName("6") as! ItemSpaceNode).insertItem(item)
                    inventory!.backPackSpaces--
                }
            }
            if let spot7 = defaults.objectForKey("packSpace7") as? String{
                if spot7 != "" {
                    let item = ItemClass.itemInSpace("\(spot7)")
                    (inventory!.childNodeWithName("7") as! ItemSpaceNode).insertItem(item)
                    inventory!.backPackSpaces--
                }
            }
            if let spot8 = defaults.objectForKey("packSpace8") as? String{
                if spot8 != "" {
                    let item = ItemClass.itemInSpace("\(spot8)")
                    (inventory!.childNodeWithName("8") as! ItemSpaceNode).insertItem(item)
                    inventory!.backPackSpaces--
                }
            }
            if let spot9 = defaults.objectForKey("packSpace9") as? String{
                if spot9 != "" {
                    let item = ItemClass.itemInSpace("\(spot9)")
                    (inventory!.childNodeWithName("9") as! ItemSpaceNode).insertItem(item)
                    inventory!.backPackSpaces--
                }
            }
            if let spot10 = defaults.objectForKey("packSpace10") as? String{
                if spot10 != "" {
                    let item = ItemClass.itemInSpace("\(spot10)")
                    (inventory!.childNodeWithName("10") as! ItemSpaceNode).insertItem(item)
                    inventory!.backPackSpaces--
                }
            }
            if let spot11 = defaults.objectForKey("packSpace11") as? String{
                if spot11 != "" {
                    let item = ItemClass.itemInSpace("\(spot11)")
                    (inventory!.childNodeWithName("11") as! ItemSpaceNode).insertItem(item)
                    inventory!.backPackSpaces--
                }
            }
            if let spot12 = defaults.objectForKey("packSpace12") as? String{
                if spot12 != "" {
                    let item = ItemClass.itemInSpace("\(spot12)")
                    (inventory!.childNodeWithName("12") as! ItemSpaceNode).insertItem(item)
                    inventory!.backPackSpaces--
                }
            }
            if let spot13 = defaults.objectForKey("packSpace13") as? String{
                if spot13 != "" {
                    let item = ItemClass.itemInSpace("\(spot13)")
                    (inventory!.childNodeWithName("13") as! ItemSpaceNode).insertItem(item)
                    inventory!.backPackSpaces--
                }
            }
            if let spot14 = defaults.objectForKey("packSpace14") as? String{
                if spot14 != "" {
                    let item = ItemClass.itemInSpace("\(spot14)")
                    (inventory!.childNodeWithName("14") as! ItemSpaceNode).insertItem(item)
                    inventory!.backPackSpaces--
                }
            }
            if let spot15 = defaults.objectForKey("packSpace15") as? String{
                if spot15 != "" {
                    let item = ItemClass.itemInSpace("\(spot15)")
                    (inventory!.childNodeWithName("15") as! ItemSpaceNode).insertItem(item)
                    inventory!.backPackSpaces--
                }
            }
            
            
            
            //*******************************************************************
            
            
            world1Node = SKSpriteNode(imageNamed: "The_Beach_Zone_Button_1")
            world1Node!.size = CGSizeMake(350, 80)
            world1Node!.position = CGPointMake(self.frame.midX, self.frame.maxY - 150)

            if is5 {
                world1Node!.size = CGSizeMake(300, 80)
                world1Node!.position = CGPointMake(self.frame.midX, self.frame.maxY - 130)

            } else if isPad {
                world1Node!.size = CGSizeMake(270, 65)
                world1Node!.position = CGPointMake(self.frame.midX, self.frame.maxY - 115)

            }
            self.addChild(world1Node!)
            let comingSoon = SKSpriteNode(imageNamed: "World_Coming_Soon_Button_1")
            comingSoon.size = CGSizeMake(350, 80)
            comingSoon.position = CGPointMake(self.frame.midX, self.frame.maxY - 250)
            if is5 {
                comingSoon.size = CGSizeMake(300, 80)
                comingSoon.position = CGPointMake(self.frame.midX, self.frame.maxY - 220)
            } else if isPad {
                comingSoon.size = CGSizeMake(270, 65)
                comingSoon.position = CGPointMake(self.frame.midX, self.frame.maxY - 190)
            }
            self.addChild(comingSoon)
            let comingSoon2 = SKSpriteNode(imageNamed: "World_Coming_Soon_Button_1")
            comingSoon2.size = CGSizeMake(350, 80)
            comingSoon2.position = CGPointMake(self.frame.midX, self.frame.maxY - 350)
            if is5 {
                comingSoon2.size = CGSizeMake(300, 80)
                comingSoon2.position = CGPointMake(self.frame.midX, self.frame.maxY - 310)
            } else if isPad {
                comingSoon2.size = CGSizeMake(270, 65)
                comingSoon2.position = CGPointMake(self.frame.midX, self.frame.maxY - 265)
            }
            self.addChild(comingSoon2)
            let revealingTide = SKSpriteNode(imageNamed: "Level_Revealing_Tide_1")
            revealingTide.size = CGSizeMake(self.frame.maxX, self.frame.maxY - 170)
            revealingTide.anchorPoint = CGPointMake(0.5, 0)
            revealingTide.position = CGPointMake(self.frame.midX, 0)
            self.addChild(revealingTide)
            tutorialButton = SKSpriteNode(imageNamed: "Tutorial_Button_1")
            tutorialButton!.size = CGSizeMake(100, 100)
            tutorialButton!.position = CGPointMake(self.frame.maxX - 55, self.frame.minX + 110)
            if is5{
                tutorialButton!.size = CGSizeMake(80, 80)
                tutorialButton!.position = CGPointMake(self.frame.maxX - 45, self.frame.minX + 90)
            } else if isPad {
                tutorialButton!.size = CGSizeMake(70, 70)
                tutorialButton!.position = CGPointMake(self.frame.maxX - 40, self.frame.minX + 85)
            }
            
            tutorialButton!.name = "tutorial"
            self.addChild(tutorialButton!)
            inventoryNode = SKSpriteNode(imageNamed: "Fitting_Room__Button_1")
            //inventoryNode!.zPosition = -2
            inventoryNode!.size = CGSizeMake(100, 100)
            inventoryNode!.position = CGPointMake(self.frame.minX + 55, self.frame.maxY - 55)
            if is5{
                inventoryNode!.size = CGSizeMake(80, 80)
                inventoryNode!.position = CGPointMake(self.frame.minX + 45, self.frame.maxY - 45)
            } else if isPad{
                inventoryNode!.size = CGSizeMake(70, 70)
                inventoryNode!.position = CGPointMake(self.frame.minX + 40, self.frame.maxY - 40)
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
            }
            self.addChild(storeNode!)
            zonesTextNode = SKSpriteNode(imageNamed: "Zones_Text_1")
            //zonesTextNode!.zPosition = -2
            zonesTextNode!.size = CGSizeMake(150, 40)
            zonesTextNode!.position = CGPointMake(self.frame.midX, self.frame.maxY - 53)
            if is5{
                 zonesTextNode!.size = CGSizeMake(130, 33)
                zonesTextNode!.position = CGPointMake(self.frame.midX, self.frame.maxY - 48)
            } else if isPad{
                 zonesTextNode!.size = CGSizeMake(130, 33)
                zonesTextNode!.position = CGPointMake(self.frame.midX, self.frame.maxY - 43)
            }
            
            self.addChild(zonesTextNode!)
            firstLoad = false
        }
        
    }
    
    //Delegate methods for AdBannerView
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        println("add success")
        banner.sizeThatFits(CGSizeMake(self.frame.maxX, 1000))
        banner.frame.origin.y = self.frame.maxY - 50
        if self.view?.scene == self{
            addLoaded = true
            self.view?.addSubview(banner) //Add banner to view (Ad loaded)
        }
    }
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError
        error: NSError!) {
            addLoaded = false
            println("add fail")
            banner.removeFromSuperview() //Remove the banner (No ad)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let skTransition = SKTransition.fadeWithDuration(1.0)
        for touch in touches{
            if world1Node!.containsPoint((touch as! UITouch).locationInNode(self)){
                //remove add
                if addLoaded {
                    addLoaded = true
                    mediumRectAdView!.delegate = nil
                mediumRectAdView!.removeFromSuperview()
                }
                if soundOn {
                    self.runAction(clickSound)
                }
                self.view?.presentScene(world1Menu, transition: skTransition)
            }else if inventoryNode!.containsPoint((touch as! UITouch).locationInNode(self)){
                if addLoaded {
                    addLoaded = true
                    mediumRectAdView!.delegate = nil
                mediumRectAdView!.removeFromSuperview()
                }
                if soundOn {
                    self.runAction(clickSound)
                }
                self.view?.presentScene(inventory, transition: skTransition)
            }else if storeNode!.containsPoint((touch as! UITouch).locationInNode(self)){
                if addLoaded {
                    addLoaded = true
                    mediumRectAdView!.delegate = nil
                mediumRectAdView!.removeFromSuperview()
                }
                if soundOn {
                    self.runAction(clickSound)
                }
                let aStoreScene = StoreScene(size: self.frame.size)
                aStoreScene.userData = NSMutableDictionary()
                aStoreScene.userData?.setObject(inventory!, forKey: "inventory")
                //aStoreScene.userData?.setObject(world1Menu!, forKey: "menu")
                aStoreScene.userData?.setObject(self, forKey: "worldscene")
                self.view?.presentScene(aStoreScene, transition: skTransition)
            }else if tutorialButton!.containsPoint((touch as! UITouch).locationInNode(self)){
                if addLoaded {
                    addLoaded = true
                    mediumRectAdView!.delegate = nil
                mediumRectAdView!.removeFromSuperview()
                }
                if soundOn {
                    self.runAction(clickSound)
                }
                let aTutorialScene = TutorialScene(size: self.frame.size)
                aTutorialScene.userData = NSMutableDictionary()
                aTutorialScene.userData?.setObject(self, forKey: "zoneScene")
                self.view?.presentScene(aTutorialScene, transition: skTransition)
            }else if soundOnButton!.containsPoint((touch as! UITouch).locationInNode(self)){
                if soundOn {
                    soundOnButton!.texture = SKTexture(imageNamed: "Sound_Off_Button_1")
                    soundOn = false
                    defaults.setBool(false, forKey: "sound")
                    happyMusic.stop()
                }else {
                    self.runAction(clickSound)
                    soundOnButton!.texture = SKTexture(imageNamed: "Sound_On_Button_1")
                    soundOn = true
                    defaults.setBool(true, forKey: "sound")
                    happyMusic.play()
                }
            }
        }
    }
}