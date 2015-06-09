//
//  StoreScene.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 2/13/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class StoreScene: SKScene {
    var menu: SKSpriteNode?
    var inv: SKSpriteNode?
    var itemSpaces: [ItemSpaceNode] = []
    var items: [ItemClass] = []
    var firstLoad = true
    var backPackSpaces = 15
    var goldNode: SKLabelNode?
    var statLabelLife: SKLabelNode?
    var statLabelMovement: SKLabelNode?
    var statLabelRegen: SKLabelNode?
    var itemText: SKSpriteNode?
    var currentItem: ItemClass?
    var goldCount: CGFloat = 0
    var firstClick = true
    
    var persistentData: NSUserDefaults?
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        persistentData = NSUserDefaults.standardUserDefaults()
       //add menu option node here
        self.backgroundColor = UIColor.grayColor()
        let background = SKSpriteNode(imageNamed: "Store_2.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.addChild(background)
        //add shelves
        let shelf1 = SKSpriteNode(imageNamed: "Store_Shelf_1.png")
        shelf1.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 175)
        shelf1.setScale(0.35)
        self.addChild(shelf1)
        let shelf2 = SKSpriteNode(imageNamed: "Store_Shelf_1.png")
        shelf2.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 275)
        shelf2.setScale(0.35)
        self.addChild(shelf2)
        let shelf3 = SKSpriteNode(imageNamed: "Store_Shelf_1.png")
        shelf3.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 375)
        shelf3.setScale(0.35)
        self.addChild(shelf3)
        let shelf4 = SKSpriteNode(imageNamed: "Store_Shelf_1.png")
        shelf4.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 475)
        shelf4.setScale(0.35)
        self.addChild(shelf4)
        let storeTextNode = SKSpriteNode(imageNamed: "Store_Text_1")
        storeTextNode.position = CGPointMake(self.frame.midX, self.frame.maxY - 53)
        storeTextNode.size = CGSizeMake(150, 40)
        self.addChild(storeTextNode)
        //shelf1.zPosition = -1
        //stats label
        
        statLabelLife = SKLabelNode.init(text: "")
        statLabelLife!.position = CGPointMake(self.frame.midX - 110, self.frame.minY + 87)
        statLabelLife!.fontColor = UIColor.blueColor()
        statLabelLife!.fontName = "ChalkboardSE-Bold"
        statLabelLife!.fontSize = 30
        statLabelLife!.fontColor = UIColor.blackColor()
        statLabelLife!.name = "lifeStat"
        statLabelLife!.setScale(0.7)
        self.addChild(statLabelLife!)
        statLabelMovement = SKLabelNode.init(text: "")
        statLabelMovement!.position = CGPointMake(self.frame.midX - 110, self.frame.minY + 57)
        statLabelMovement!.fontName = "ChalkboardSE-Bold"
        statLabelMovement!.fontSize = 30
        statLabelMovement!.fontColor = UIColor.blackColor()
        statLabelMovement!.name = "movementStat"
        statLabelMovement!.setScale(0.7)
        self.addChild(statLabelMovement!)
        statLabelRegen = SKLabelNode.init(text: "")
        statLabelRegen!.position = CGPointMake(self.frame.midX - 110, self.frame.minY + 27)
        statLabelRegen!.fontColor = UIColor.blueColor()
        statLabelRegen!.fontName = "ChalkboardSE-Bold"
        statLabelRegen!.fontSize = 30
        statLabelRegen!.fontColor = UIColor.blackColor()
        statLabelRegen!.name = "regenStat"
        statLabelRegen!.setScale(0.7)
        self.addChild(statLabelRegen!)
        
        menu = SKSpriteNode(imageNamed: "Zones__Button_1")
        menu!.position = CGPointMake(self.frame.minX + 55, self.frame.maxY - 55)
        menu!.name = "menu"
        menu!.size = CGSizeMake(100, 100)
        self.addChild(menu!)
        inv = SKSpriteNode(imageNamed: "Fitting_Room__Button_1")
        inv!.position = CGPointMake(self.frame.maxX - 55, self.frame.maxY - 55)
        inv!.name = "inventory"
        inv!.size = CGSizeMake(100, 100)
        self.addChild(inv!)
        //gold node
        goldCount = (self.userData?.objectForKey("inventory") as! Inventory).gold
        goldNode = SKLabelNode.init(text: "\(Int(goldCount))")
        goldNode!.position = CGPointMake(self.frame.midX - 30, self.frame.maxY - 120)
        goldNode!.fontName = "ChalkboardSE-Bold"
        goldNode!.fontSize = 30
        goldNode!.fontColor = UIColor.blackColor()
        self.addChild(goldNode!)
        //booty coin image
        let booty = SKSpriteNode(imageNamed: "Booty_1.png")
        booty.position = CGPointMake(self.frame.midX + 30, self.frame.maxY - 110)
        booty.setScale(0.10)
        self.addChild(booty)
        addItems()
    }
    
    func addItems(){
        
        var counter = 1
        for itemName in allStoreItems{
            let item = ItemClass.itemInSpace(itemName)
            //shelf 1
            if itemName == "Copper_Ring_1"{
                item.size = CGSizeMake(40, 40)
                item.position = CGPointMake(self.frame.minX + 60, self.frame.maxY - 165)
                if isPlus{
                   item.position = CGPointMake(self.frame.minX + 80, self.frame.maxY - 165)
                }
            }else if itemName == "Sweaty_Wristband_1"{
                item.size = CGSizeMake(45, 60)
                item.position = CGPointMake(self.frame.minX + 120, self.frame.maxY - 160)
                if isPlus{
                    item.position = CGPointMake(self.frame.minX + 140, self.frame.maxY - 160)
                }
            }else if itemName == "Silver_Ring_1"{
                item.size = CGSizeMake(40, 40)
                item.position = CGPointMake(self.frame.midX, self.frame.maxY - 165)
            }else if itemName == "Water_Wing_1"{
                item.size = CGSizeMake(70, 70)
                item.position = CGPointMake(self.frame.maxX - 120, self.frame.maxY - 155)
                if isPlus{
                    item.position = CGPointMake(self.frame.maxX - 140, self.frame.maxY - 160)
                }
            }else if itemName == "Gold_Ring_1"{
                item.size = CGSizeMake(40, 40)
                item.position = CGPointMake(self.frame.maxX - 60, self.frame.maxY - 165)
                if isPlus{
                    item.position = CGPointMake(self.frame.maxX - 80, self.frame.maxY - 165)
                }
            
            
            //shelf 2
            }else if itemName == "Whistle_1"{
                item.size = CGSizeMake(50, 35)
                item.position = CGPointMake(self.frame.minX + 50, self.frame.maxY - 265)
                if isPlus{
                    item.position = CGPointMake(self.frame.minX + 70, self.frame.maxY - 265)
                }
            }else if itemName == "Lifejacket_1"{
                item.size = CGSizeMake(110, 75)
                item.position = CGPointMake(self.frame.minX + 105, self.frame.maxY - 245)
                if isPlus{
                    item.position = CGPointMake(self.frame.minX + 125, self.frame.maxY - 250)
                }
            }else if itemName == "Beach_Towel_1"{
                item.size = CGSizeMake(100, 50)
                item.position = CGPointMake(self.frame.midX, self.frame.maxY - 255)
            }else if itemName == "Floatie_1"{
                item.size = CGSizeMake(90, 60)
                item.position = CGPointMake(self.frame.maxX - 95, self.frame.maxY - 245)
                if isPlus{
                    item.position = CGPointMake(self.frame.maxX - 115, self.frame.maxY - 250)
                }
            }else if itemName == "Sun_Screen_1"{
                item.size = CGSizeMake(35, 50)
                item.position = CGPointMake(self.frame.maxX - 40, self.frame.maxY - 250)
                if isPlus{
                    item.position = CGPointMake(self.frame.maxX - 60, self.frame.maxY - 255)
                }
                
            //shelf 3
            }else if itemName == "Sweatband_1"{
                item.size = CGSizeMake(65, 65)
                item.position = CGPointMake(self.frame.minX + 50, self.frame.maxY - 360)
                if isPlus{
                    item.position = CGPointMake(self.frame.minX + 70, self.frame.maxY - 360)
                }
            }else if itemName == "Visor_1"{
                item.size = CGSizeMake(65, 75)
                item.position = CGPointMake(self.frame.minX + 115, self.frame.maxY - 360)
                if isPlus{
                    item.position = CGPointMake(self.frame.minX + 135, self.frame.maxY - 360)
                }
            }else if itemName == "Sand_Bucket_1"{
                item.size = CGSizeMake(70, 70)
                item.position = CGPointMake(self.frame.midX - 7, self.frame.maxY - 350)
            }else if itemName == "Sunhat_1"{
                item.size = CGSizeMake(80, 80)
                item.position = CGPointMake(self.frame.maxX - 120, self.frame.maxY - 360)
                if isPlus{
                    item.position = CGPointMake(self.frame.maxX - 140, self.frame.maxY - 360)
                }
            }else if itemName == "Shades_1"{
                item.size = CGSizeMake(50, 35)
                item.position = CGPointMake(self.frame.maxX - 52, self.frame.maxY - 365)
                if isPlus{
                    item.position = CGPointMake(self.frame.maxX - 72, self.frame.maxY - 365)
                }
                
            //shelf 4
            }else if itemName == "Bling_Ring_1"{
                item.size = CGSizeMake(40, 40)
                item.position = CGPointMake(self.frame.minX + 60, self.frame.maxY - 465)
                if isPlus{
                    item.position = CGPointMake(self.frame.minX + 80, self.frame.maxY - 465)
                }
            }else if itemName == "Watch_1"{
                item.size = CGSizeMake(60, 60)
                item.position = CGPointMake(self.frame.minX + 125, self.frame.maxY - 460)
                if isPlus{
                    item.position = CGPointMake(self.frame.minX + 145, self.frame.maxY - 460)
                }
            }else if itemName == "Bow_Tie_1"{
                item.size = CGSizeMake(90, 70)
                item.position = CGPointMake(self.frame.midX, self.frame.maxY - 465)
            }else if itemName == "Monocle_1"{
                item.size = CGSizeMake(60, 60)
                item.position = CGPointMake(self.frame.maxX - 135, self.frame.maxY - 470)
                if isPlus{
                    item.position = CGPointMake(self.frame.maxX - 155, self.frame.maxY - 475)
                }
            }else if itemName == "Top_Hat_1"{
                item.size = CGSizeMake(70, 70)
                item.position = CGPointMake(self.frame.maxX - 60, self.frame.maxY - 445)
                if isPlus{
                    item.position = CGPointMake(self.frame.maxX - 80, self.frame.maxY - 445)
                }
            }
            else{
                item.size = CGSizeMake(40, 40)
            }
            item.name = "item\(counter)"
            counter += 1
            self.addChild(item)
            
        }
        
    }
    func clickedItem(point: CGPoint) -> String{
        for var x = 1; x < allStoreItems.count+1; x+=1{
            let anItem = self.childNodeWithName("item\(x)") as! ItemClass
            if anItem.containsPoint(point){
                return anItem.itemName!
            }
        }
        return ""
    }
    
    func buyItem(){
        if (self.userData?.objectForKey("inventory") as! Inventory).gold >= currentItem!.price && (self.userData?.objectForKey("inventory") as! Inventory).backPackSpaces > 0{
            (self.userData?.objectForKey("inventory") as! Inventory).gold -= currentItem!.price!
            (self.userData?.objectForKey("inventory") as! Inventory).addItem(currentItem!.itemName!)
            goldCount -= currentItem!.price!
            persistentData!.setObject((self.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            goldNode!.text = "\(Int(goldCount))"
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in touches{
            if menu!.containsPoint((touch as! UITouch).locationInNode(self)){
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(self.userData?.objectForKey("worldscene") as! ZoneScene, transition: skTransition)
            }else if inv!.containsPoint((touch as! UITouch).locationInNode(self)){
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(self.userData?.objectForKey("inventory") as! Inventory, transition: skTransition)
            }else if self.childNodeWithName("buyButton") != nil && self.childNodeWithName("buyButton")!.containsPoint((touch as! UITouch).locationInNode(self)){
                buyItem()
                self.childNodeWithName("buyButton")?.removeFromParent()
                self.childNodeWithName("life")?.removeFromParent()
                self.childNodeWithName("speed")?.removeFromParent()
                self.childNodeWithName("regen")?.removeFromParent()
                self.childNodeWithName("priceButton")?.removeFromParent()
                self.childNodeWithName("itemText")?.removeFromParent()
                self.childNodeWithName("booty")?.removeFromParent()
                self.childNodeWithName("slotLabel")?.removeFromParent()
                statLabelLife!.text = ""
                statLabelMovement!.text = ""
                statLabelRegen!.text = ""
                currentItem?.texture = nil
                currentItem = nil
            }else if clickedItem((touch as! UITouch).locationInNode(self)) != ""{
                if currentItem != nil{
                    currentItem!.removeFromParent()
                    self.childNodeWithName("slotLabel")?.removeFromParent()
                }
                currentItem = ItemClass.itemInSpace(clickedItem((touch as! UITouch).locationInNode(self)))
                currentItem!.size == CGSizeMake(70, 70)
                currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 65)
                
                //ZACH ITEMS HERE@@@
                if currentItem?.itemName == "Copper_Ring_1" {
                    currentItem!.size = CGSizeMake(70, 70)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 65)
                    let slotLabel = SKSpriteNode(imageNamed: "Tentacles_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                }else if currentItem?.itemName == "Sweaty_Wristband_1" {
                    currentItem!.size = CGSizeMake(70, 90)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 65)
                    let slotLabel = SKSpriteNode(imageNamed: "Tentacles_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Silver_Ring_1" {
                    currentItem!.size = CGSizeMake(70, 70)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 65)
                    let slotLabel = SKSpriteNode(imageNamed: "Tentacles_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Gold_Ring_1" {
                    currentItem!.size = CGSizeMake(70, 70)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 65)
                    let slotLabel = SKSpriteNode(imageNamed: "Tentacles_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Water_Wing_1" {
                    currentItem!.size = CGSizeMake(120, 120)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 65)
                    let slotLabel = SKSpriteNode(imageNamed: "Tentacles_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Whistle_1" {
                    currentItem!.size = CGSizeMake(160, 100)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 65)
                    let slotLabel = SKSpriteNode(imageNamed: "Neck_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Lifejacket_1" {
                    currentItem!.size = CGSizeMake(170, 150)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 60)
                    let slotLabel = SKSpriteNode(imageNamed: "Neck_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Beach_Towel_1" {
                    currentItem!.size = CGSizeMake(180, 120)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 60)
                    let slotLabel = SKSpriteNode(imageNamed: "Neck_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Floatie_1" {
                    currentItem!.size = CGSizeMake(160, 110)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 60)
                    let slotLabel = SKSpriteNode(imageNamed: "Neck_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Sun_Screen_1" {
                    currentItem!.size = CGSizeMake(75, 120)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 60)
                    let slotLabel = SKSpriteNode(imageNamed: "Neck_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Sweatband_1" {
                    currentItem!.size = CGSizeMake(170, 170)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 65)
                    let slotLabel = SKSpriteNode(imageNamed: "Noggin_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Visor_1" {
                    currentItem!.size = CGSizeMake(170, 170)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 65)
                    let slotLabel = SKSpriteNode(imageNamed: "Noggin_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Sand_Bucket_1" {
                    currentItem!.size = CGSizeMake(120, 120)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 60)
                    let slotLabel = SKSpriteNode(imageNamed: "Noggin_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Sunhat_1" {
                    currentItem!.size = CGSizeMake(190, 190)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 65)
                    let slotLabel = SKSpriteNode(imageNamed: "Noggin_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Shades_1" {
                    currentItem!.size = CGSizeMake(160, 110)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 65)
                    let slotLabel = SKSpriteNode(imageNamed: "Noggin_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Bling_Ring_1" {
                    currentItem!.size = CGSizeMake(70, 70)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 65)
                    let slotLabel = SKSpriteNode(imageNamed: "Tentacles_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Monocle_1" {
                    currentItem!.size = CGSizeMake(130, 130)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 65)
                    let slotLabel = SKSpriteNode(imageNamed: "Noggin_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Bow_Tie_1" {
                    currentItem!.size = CGSizeMake(200, 150)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 65)
                    let slotLabel = SKSpriteNode(imageNamed: "Neck_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Watch_1" {
                    currentItem!.size = CGSizeMake(100, 100)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 65)
                    let slotLabel = SKSpriteNode(imageNamed: "Tentacles_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                } else if currentItem?.itemName == "Top_Hat_1" {
                    currentItem!.size = CGSizeMake(115, 115)
                    currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 60)
                    let slotLabel = SKSpriteNode(imageNamed: "Noggin_Text_1")
                    slotLabel.name = "slotLabel"
                    slotLabel.setScale(0.35)
                    slotLabel.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 100)
                    self.addChild(slotLabel)
                }
                   
                
                statLabelLife!.text = "0"
                statLabelMovement!.text = "0"
                statLabelRegen!.text = "0"
                for tuple in currentItem!.getStats(){
                    if tuple.0 == "Life"{
                        statLabelLife!.text = "\(Int(tuple.1))"
                    }else if tuple.0 == "Movement"{
                        statLabelMovement!.text = "\(Int(tuple.1))"
                    }else if tuple.0 == "Regeneration"{
                        statLabelRegen!.text = "\(Int(tuple.1))"
                    }
                }
                self.addChild(currentItem!)
               
                
            }
        }
        //an item is being highlighted
        if currentItem != nil && self.childNodeWithName("buyButton") == nil{
            let buyNode = SKSpriteNode(imageNamed: "Buy_Text_1")
            buyNode.position = CGPointMake(self.frame.midX + 135, self.frame.minY + 35)
            buyNode.setScale(0.5)
            buyNode.name = "buyButton"
            self.addChild(buyNode)
            //stat symbols
            let lifeSymbol = SKSpriteNode(imageNamed: "Life_Symbol_1")
            lifeSymbol.setScale(0.15)
            lifeSymbol.name = "life"
            lifeSymbol.position = CGPointMake(self.frame.midX - 145, self.frame.minY + 95)
            self.addChild(lifeSymbol)
            let speedSymbol = SKSpriteNode(imageNamed: "Speed_Symbol_1")
            speedSymbol.setScale(0.15)
            speedSymbol.name = "speed"
            speedSymbol.position = CGPointMake(self.frame.midX - 145, self.frame.minY + 65)
            self.addChild(speedSymbol)
            let regenerationSymbol = SKSpriteNode(imageNamed: "Regeneration_Symbol_1")
            regenerationSymbol.setScale(0.15)
            regenerationSymbol.name = "regen"
            regenerationSymbol.position = CGPointMake(self.frame.midX - 145, self.frame.minY + 35)
            self.addChild(regenerationSymbol)
        }
        
        
        
        if currentItem != nil{
            if self.childNodeWithName("priceButton") != nil{
                self.childNodeWithName("priceButton")?.removeFromParent()
                
            }
            
            let priceNode = SKLabelNode.init(text: "\(Int(currentItem!.price!))")
            priceNode.position = CGPointMake(self.frame.midX + 110, self.frame.minY + 60)
            priceNode.fontName = "ChalkboardSE-Bold"
            priceNode.fontSize = 30
            priceNode.name = "priceButton"
            priceNode.fontColor = UIColor.blackColor()
            let booty = SKSpriteNode(imageNamed: "Booty_1.png")
            booty.position = CGPointMake(self.frame.midX + 160, self.frame.minY + 70)
            booty.name = "booty"
            booty.setScale(0.075)
            if firstClick{
                self.addChild(booty)
            }
            self.addChild(priceNode)
            self.childNodeWithName("itemText")?.removeFromParent()
            //text for item names
            var itemName = currentItem?.itemName!
            itemName = itemName!.stringByReplacingOccurrencesOfString("1", withString: "Text", options: NSStringCompareOptions.LiteralSearch, range: nil)
            itemText = SKSpriteNode(imageNamed: "\(itemName!)")
            itemText!.name = "itemText"
            itemText!.setScale(0.7)
            itemText!.position = CGPointMake(self.frame.midX, self.frame.minY + 135)
            //if firstClick{
                self.addChild(itemText!)
            //}
            firstClick = false
        }
    }
}