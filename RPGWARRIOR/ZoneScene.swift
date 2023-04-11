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
    let defaults = UserDefaults.standard
    var backgroundMusic: AVAudioPlayer?
    var mediumRectAdView: ADBannerView?
    var addLoaded = false
    
    override func didMove(to view: SKView) {
        if addLoaded {
            addLoaded = false
        }
        mediumRectAdView = ADBannerView(adType: ADAdType.Banner)
        mediumRectAdView!.delegate = self
        /* Setup your scene here */
        //MUSIC
        //check for saved data on sound off/on, set spritenode to this and set soundOn
        if firstLoad{
            if (defaults.object(forKey: "sound") as! Bool) {
            soundOn = true
            soundOnButton = SKSpriteNode(imageNamed: "Sound_On_Button_1")
        }else {
            soundOn = false
            soundOnButton = SKSpriteNode(imageNamed: "Sound_Off_Button_1")
        }
        soundOnButton!.size = CGSizeMake(100, 100)
            soundOnButton!.position = CGPointMake(self.frame.minX + 55, self.frame.minY + 60)
            if is5{
                soundOnButton!.size = CGSizeMake(80, 80)
                soundOnButton!.position = CGPointMake(self.frame.minX + 45, self.frame.minY + 40)
            } else if isPad {
                soundOnButton!.size = CGSizeMake(70, 70)
                soundOnButton!.position = CGPointMake(self.frame.minX + 40, self.frame.minY + 35)
            }
        
        soundOnButton!.name = "soundButton"
        soundOnButton!.zPosition = 4
        self.addChild(soundOnButton!)
        }
        if (!happyMusic!.isPlaying) && soundOn{
            happyMusic!.numberOfLoops = -1
            happyMusic!.prepareToPlay()
            happyMusic!.play()
        }
        
        let background = SKSpriteNode(imageNamed: "Zone_Screen_2")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.addChild(background)
        if firstLoad{
            var beatGame2: Bool?
            if defaults.object(forKey: "beatgame") as! Bool {
                beatGame2 = true
            }else{
                beatGame2 = false
            }
            
            world1Menu = MainMenuScene(size: self.frame.size)
            world1Menu!.beatGame = beatGame2!
            world1Menu!.userData = NSMutableDictionary()
            world1Menu!.userData?.setObject(self, forKey: "worldscene" as NSCopying)
            inventory = Inventory.createInventory(size: self.frame.size)
            world1Menu!.userData?.setObject(inventory!, forKey: "inventory" as NSCopying)
            inventory!.userData = NSMutableDictionary()
            inventory!.userData?.setObject(world1Menu!, forKey: "menu" as NSCopying)
            inventory!.userData?.setObject(self, forKey: "worldscene" as NSCopying)
            
            //******SETUP SAVED DATA FOR INVENTORY AND MainMenuScene HERE********
            if let bestLevel = defaults.object(forKey: "highestLevel") as? Int{
                world1Menu!.highestLevel = bestLevel
            }
            if let bestTime = defaults.object(forKey: "highestTime") as? Double{
                world1Menu!.highestTime = bestTime
            }
            if let gold = defaults.object(forKey: "gold") as? CGFloat{
                inventory!.gold = gold
            }
            if let head = defaults.object(forKey: "headSpace") as? String{
                if head != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(head)")
                    (inventory!.childNode(withName: "weapon") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.displayItem(item: item, spot: "weapon")
                    inventory!.weapon = item
                }
            }
            if let neck = defaults.object(forKey: "neckSpace") as? String{
                if neck != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(neck)")
                    (inventory!.childNode(withName: "neck") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.displayItem(item: item, spot: "neck")
                    inventory!.neck = item
                }
            }
            if let left = defaults.object(forKey: "leftSpace") as? String{
                if left != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(left)")
                    (inventory!.childNode(withName: "body") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.displayItem(item: item, spot: "body")
                    inventory!.body = item
                }
            }
            if let right = defaults.object(forKey: "rightSpace") as? String{
                if right != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(right)")
                    (inventory!.childNode(withName: "feet") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.displayItem(item: item, spot: "feet")
                    inventory!.feet = item
                }
            }
            if let spot1 = defaults.object(forKey: "packSpace1") as? String{
                if spot1 != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(spot1)")
                    (inventory!.childNode(withName: "1") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.backPackSpaces-=1
                }
            }
            if let spot2 = defaults.object(forKey: "packSpace2") as? String{
                if spot2 != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(spot2)")
                    (inventory!.childNode(withName: "2") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.backPackSpaces-=1
                }
            }
            if let spot3 = defaults.object(forKey: "packSpace3") as? String{
                if spot3 != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(spot3)")
                    (inventory!.childNode(withName: "3") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.backPackSpaces-=1
                }
            }
            if let spot4 = defaults.object(forKey: "packSpace4") as? String{
                if spot4 != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(spot4)")
                    (inventory!.childNode(withName: "4") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.backPackSpaces-=1
                }
            }
            if let spot5 = defaults.object(forKey: "packSpace5") as? String{
                if spot5 != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(spot5)")
                    (inventory!.childNode(withName: "5") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.backPackSpaces-=1
                }
            }
            if let spot6 = defaults.object(forKey: "packSpace6") as? String{
                if spot6 != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(spot6)")
                    (inventory!.childNode(withName: "6") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.backPackSpaces-=1
                }
            }
            if let spot7 = defaults.object(forKey: "packSpace7") as? String{
                if spot7 != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(spot7)")
                    (inventory!.childNode(withName: "7") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.backPackSpaces-=1
                }
            }
            if let spot8 = defaults.object(forKey: "packSpace8") as? String{
                if spot8 != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(spot8)")
                    (inventory!.childNode(withName: "8") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.backPackSpaces-=1
                }
            }
            if let spot9 = defaults.object(forKey: "packSpace9") as? String{
                if spot9 != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(spot9)")
                    (inventory!.childNode(withName: "9") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.backPackSpaces-=1
                }
            }
            if let spot10 = defaults.object(forKey: "packSpace10") as? String{
                if spot10 != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(spot10)")
                    (inventory!.childNode(withName: "10") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.backPackSpaces-=1
                }
            }
            if let spot11 = defaults.object(forKey: "packSpace11") as? String{
                if spot11 != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(spot11)")
                    (inventory!.childNode(withName: "11") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.backPackSpaces-=1
                }
            }
            if let spot12 = defaults.object(forKey: "packSpace12") as? String{
                if spot12 != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(spot12)")
                    (inventory!.childNode(withName: "12") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.backPackSpaces-=1
                }
            }
            if let spot13 = defaults.object(forKey: "packSpace13") as? String{
                if spot13 != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(spot13)")
                    (inventory!.childNode(withName: "13") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.backPackSpaces-=1
                }
            }
            if let spot14 = defaults.object(forKey: "packSpace14") as? String{
                if spot14 != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(spot14)")
                    (inventory!.childNode(withName: "14") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.backPackSpaces-=1
                }
            }
            if let spot15 = defaults.object(forKey: "packSpace15") as? String{
                if spot15 != "" {
                    let item = ItemClass.itemInSpace(nameOfTexture: "\(spot15)")
                    (inventory!.childNode(withName: "15") as! ItemSpaceNode).insertItem(anItem: item)
                    inventory!.backPackSpaces-=1
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
            revealingTide.zPosition = 3
            revealingTide.size = CGSizeMake(self.frame.maxX, self.frame.maxY - 170)
            revealingTide.anchorPoint = CGPointMake(0.5, 0)
            revealingTide.position = CGPointMake(self.frame.midX, 0)
            self.addChild(revealingTide)
            tutorialButton = SKSpriteNode(imageNamed: "Tutorial_Button_1")
            tutorialButton!.size = CGSizeMake(100, 100)
            tutorialButton!.zPosition = 4
            tutorialButton!.position = CGPointMake(self.frame.maxX - 55, self.frame.minX + 60)
            if is5{
                tutorialButton!.size = CGSizeMake(80, 80)
                tutorialButton!.position = CGPointMake(self.frame.maxX - 45, self.frame.minX + 40)
            } else if isPad {
                tutorialButton!.size = CGSizeMake(70, 70)
                tutorialButton!.position = CGPointMake(self.frame.maxX - 40, self.frame.minX + 35)
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
    
    //needs lock
    
    var lock = true
    func moveButtonsUp() {
        if lock {
            lock = false
            let oldPosition = soundOnButton!.position
            soundOnButton!.position = CGPointMake(oldPosition.x, oldPosition.y + 50)
            let oldPosition2 = tutorialButton!.position
            tutorialButton!.position = CGPointMake(oldPosition2.x, oldPosition2.y + 50)
        }
    }
    
    func moveButtonsDown() {
        if !lock {
            lock = true
            let oldPosition = soundOnButton!.position
            soundOnButton!.position = CGPointMake(oldPosition.x, oldPosition.y - 50)
            let oldPosition2 = tutorialButton!.position
            tutorialButton!.position = CGPointMake(oldPosition2.x, oldPosition2.y - 50)
        }
    }
    
    //Delegate methods for AdBannerView
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        print("add success")
        banner.sizeThatFits(CGSizeMake(self.frame.maxX, 1000))
        banner.frame.origin.y = self.frame.maxY - 50
        if self.view?.scene == self{
            addLoaded = true
            self.view?.addSubview(banner) //Add banner to view (Ad loaded)
        }
        moveButtonsUp()
    }
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError
        error: NSError!) {
            addLoaded = false
            print("add fail")
            banner.removeFromSuperview() //Remove the banner (No ad)
            moveButtonsDown()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let skTransition = SKTransition.fade(withDuration: 1.0)
        for touch in touches{
            if world1Node!.contains((touch ).location(in: self)){
                //remove add
                if addLoaded {
                    addLoaded = true
                    mediumRectAdView!.delegate = nil
                mediumRectAdView!.removeFromSuperview()
                }
                if soundOn {
                    self.run(clickSound)
                }
                self.view?.presentScene(world1Menu!, transition: skTransition)
            }else if inventoryNode!.contains((touch ).location(in: self)){
                if addLoaded {
                    addLoaded = true
                    mediumRectAdView!.delegate = nil
                mediumRectAdView!.removeFromSuperview()
                }
                if soundOn {
                    self.run(clickSound)
                }
                self.view?.presentScene(inventory!, transition: skTransition)
            }else if storeNode!.contains((touch ).location(in: self)){
                if addLoaded {
                    addLoaded = true
                    mediumRectAdView!.delegate = nil
                mediumRectAdView!.removeFromSuperview()
                }
                if soundOn {
                    self.run(clickSound)
                }
                let aStoreScene = StoreScene(size: self.frame.size)
                aStoreScene.userData = NSMutableDictionary()
                aStoreScene.userData?.setObject(inventory!, forKey: "inventory" as NSCopying)
                //aStoreScene.userData?.setObject(world1Menu!, forKey: "menu")
                aStoreScene.userData?.setObject(self, forKey: "worldscene" as NSCopying)
                self.view?.presentScene(aStoreScene, transition: skTransition)
            }else if tutorialButton!.contains((touch ).location(in: self)){
                if addLoaded {
                    addLoaded = true
                    mediumRectAdView!.delegate = nil
                mediumRectAdView!.removeFromSuperview()
                }
                if soundOn {
                    self.run(clickSound)
                }
                let aTutorialScene = TutorialScene(size: self.frame.size)
                aTutorialScene.userData = NSMutableDictionary()
                aTutorialScene.userData?.setObject(self, forKey: "zoneScene" as NSCopying)
                self.view?.presentScene(aTutorialScene, transition: skTransition)
            }else if soundOnButton!.contains((touch ).location(in: self)){
                if soundOn {
                    soundOnButton!.texture = SKTexture(imageNamed: "Sound_Off_Button_1")
                    soundOn = false
                    defaults.set(false, forKey: "sound")
                    happyMusic!.stop()
                }else {
                    self.run(clickSound)
                    soundOnButton!.texture = SKTexture(imageNamed: "Sound_On_Button_1")
                    soundOn = true
                    defaults.set(true, forKey: "sound")
                    happyMusic!.play()
                }
            }
        }
    }
}
