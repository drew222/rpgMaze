//
//  ZoneScene.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 3/9/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit


class ZoneScene: SKScene {
    
    var world1Menu: MainMenuScene?
    var inventory: Inventory?
    var firstLoad = true
    var world1Node: SKSpriteNode?
    var inventoryNode: SKSpriteNode?
    var storeNode: SKSpriteNode?
    var zonesTextNode: SKSpriteNode?
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let background = SKSpriteNode(imageNamed: "Zone_Screen_2")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.addChild(background)
        if firstLoad{
            
            world1Menu = MainMenuScene(size: self.frame.size)
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
            if let gold = defaults.objectForKey("gold") as? CGFloat{
                inventory!.gold = gold
            }
            if let head = defaults.objectForKey("headSpace") as? String{
                if head != "" {
                    let item = ItemClass.itemInSpace("\(head)")
                    (inventory!.childNodeWithName("weapon") as! ItemSpaceNode).insertItem(item)
                    inventory!.displayItem(item, spot: "weapon")
                }
            }
            if let neck = defaults.objectForKey("neckSpace") as? String{
                if neck != "" {
                    let item = ItemClass.itemInSpace("\(neck)")
                    (inventory!.childNodeWithName("neck") as! ItemSpaceNode).insertItem(item)
                    inventory!.displayItem(item, spot: "neck")
                }
            }
            if let left = defaults.objectForKey("leftSpace") as? String{
                if left != "" {
                    let item = ItemClass.itemInSpace("\(left)")
                    (inventory!.childNodeWithName("body") as! ItemSpaceNode).insertItem(item)
                    inventory!.displayItem(item, spot: "body")
                }
            }
            if let right = defaults.objectForKey("rightSpace") as? String{
                if right != "" {
                    let item = ItemClass.itemInSpace("\(right)")
                    (inventory!.childNodeWithName("feet") as! ItemSpaceNode).insertItem(item)
                    inventory!.displayItem(item, spot: "feet")
                }
            }
            if let spot1 = defaults.objectForKey("packSpace1") as? String{
                if spot1 != "" {
                    let item = ItemClass.itemInSpace("\(spot1)")
                    (inventory!.childNodeWithName("1") as! ItemSpaceNode).insertItem(item)
                }
            }
            if let spot2 = defaults.objectForKey("packSpace2") as? String{
                if spot2 != "" {
                    let item = ItemClass.itemInSpace("\(spot2)")
                    (inventory!.childNodeWithName("2") as! ItemSpaceNode).insertItem(item)
                }
            }
            if let spot3 = defaults.objectForKey("packSpace3") as? String{
                if spot3 != "" {
                    let item = ItemClass.itemInSpace("\(spot3)")
                    (inventory!.childNodeWithName("3") as! ItemSpaceNode).insertItem(item)
                }
            }
            if let spot4 = defaults.objectForKey("packSpace4") as? String{
                if spot4 != "" {
                    let item = ItemClass.itemInSpace("\(spot4)")
                    (inventory!.childNodeWithName("4") as! ItemSpaceNode).insertItem(item)
                }
            }
            if let spot5 = defaults.objectForKey("packSpace5") as? String{
                if spot5 != "" {
                    let item = ItemClass.itemInSpace("\(spot5)")
                    (inventory!.childNodeWithName("5") as! ItemSpaceNode).insertItem(item)
                }
            }
            if let spot6 = defaults.objectForKey("packSpace6") as? String{
                if spot6 != "" {
                    let item = ItemClass.itemInSpace("\(spot6)")
                    (inventory!.childNodeWithName("6") as! ItemSpaceNode).insertItem(item)
                }
            }
            if let spot7 = defaults.objectForKey("packSpace7") as? String{
                if spot7 != "" {
                    let item = ItemClass.itemInSpace("\(spot7)")
                    (inventory!.childNodeWithName("7") as! ItemSpaceNode).insertItem(item)
                }
            }
            if let spot8 = defaults.objectForKey("packSpace8") as? String{
                if spot8 != "" {
                    let item = ItemClass.itemInSpace("\(spot8)")
                    (inventory!.childNodeWithName("8") as! ItemSpaceNode).insertItem(item)
                }
            }
            if let spot9 = defaults.objectForKey("packSpace9") as? String{
                if spot9 != "" {
                    let item = ItemClass.itemInSpace("\(spot9)")
                    (inventory!.childNodeWithName("9") as! ItemSpaceNode).insertItem(item)
                }
            }
            if let spot10 = defaults.objectForKey("packSpace10") as? String{
                if spot10 != "" {
                    let item = ItemClass.itemInSpace("\(spot10)")
                    (inventory!.childNodeWithName("10") as! ItemSpaceNode).insertItem(item)
                }
            }
            if let spot11 = defaults.objectForKey("packSpace11") as? String{
                if spot11 != "" {
                    let item = ItemClass.itemInSpace("\(spot11)")
                    (inventory!.childNodeWithName("11") as! ItemSpaceNode).insertItem(item)
                }
            }
            if let spot12 = defaults.objectForKey("packSpace12") as? String{
                if spot12 != "" {
                    let item = ItemClass.itemInSpace("\(spot12)")
                    (inventory!.childNodeWithName("12") as! ItemSpaceNode).insertItem(item)
                }
            }
            if let spot13 = defaults.objectForKey("packSpace13") as? String{
                if spot13 != "" {
                    let item = ItemClass.itemInSpace("\(spot13)")
                    (inventory!.childNodeWithName("13") as! ItemSpaceNode).insertItem(item)
                }
            }
            if let spot14 = defaults.objectForKey("packSpace14") as? String{
                if spot14 != "" {
                    let item = ItemClass.itemInSpace("\(spot14)")
                    (inventory!.childNodeWithName("14") as! ItemSpaceNode).insertItem(item)
                }
            }
            if let spot15 = defaults.objectForKey("packSpace15") as? String{
                if spot15 != "" {
                    let item = ItemClass.itemInSpace("\(spot15)")
                    (inventory!.childNodeWithName("15") as! ItemSpaceNode).insertItem(item)
                }
            }
            
            
            
            //*******************************************************************
            
            world1Node = SKSpriteNode(imageNamed: "The_Beach_Zone_Button_1")
            //world1Node!.zPosition = -2
            world1Node!.size = CGSizeMake(350, 80)
            world1Node!.position = CGPointMake(self.frame.midX, self.frame.maxY - 150)
            self.addChild(world1Node!)
            inventoryNode = SKSpriteNode(imageNamed: "Fitting_Room__Button_1")
            //inventoryNode!.zPosition = -2
            inventoryNode!.size = CGSizeMake(100, 100)
            inventoryNode!.position = CGPointMake(self.frame.minX + 55, self.frame.maxY - 55)
            self.addChild(inventoryNode!)
            storeNode = SKSpriteNode(imageNamed: "Store_Button_1")
            //storeNode!.zPosition = -2
            storeNode!.size = CGSizeMake(100, 100)
            storeNode!.position = CGPointMake(self.frame.maxX - 55, self.frame.maxY - 55)
            self.addChild(storeNode!)
            zonesTextNode = SKSpriteNode(imageNamed: "Zones_Text_1")
            //zonesTextNode!.zPosition = -2
            zonesTextNode!.size = CGSizeMake(150, 40)
            zonesTextNode!.position = CGPointMake(self.frame.midX, self.frame.maxY - 53)
            self.addChild(zonesTextNode!)
            firstLoad = false
        }
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let skTransition = SKTransition.fadeWithDuration(1.0)
        for touch in touches{
            if world1Node!.containsPoint((touch as! UITouch).locationInNode(self)){
                self.view?.presentScene(world1Menu, transition: skTransition)
            }else if inventoryNode!.containsPoint((touch as! UITouch).locationInNode(self)){
                self.view?.presentScene(inventory, transition: skTransition)
            }else if storeNode!.containsPoint((touch as! UITouch).locationInNode(self)){
                let aStoreScene = StoreScene(size: self.frame.size)
                aStoreScene.userData = NSMutableDictionary()
                aStoreScene.userData?.setObject(inventory!, forKey: "inventory")
                //aStoreScene.userData?.setObject(world1Menu!, forKey: "menu")
                aStoreScene.userData?.setObject(self, forKey: "worldscene")
                self.view?.presentScene(aStoreScene, transition: skTransition)
            }
        }
    }
}