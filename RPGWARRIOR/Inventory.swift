//
//  Inventory.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 2/9/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit
import Foundation

//import AVFoundation

class Inventory: SKScene {
    var menu: SKSpriteNode?
    var store: SKSpriteNode?
    var backPack: SKSpriteNode?
    var itemSpaces: [ItemSpaceNode] = []
    var items: [ItemClass] = []
    var itemToMove: ItemClass?
    var spaceToMove: ItemSpaceNode?
    var firstLoad = true
    var backPackSpaces = 15
    var gold: CGFloat = 1500
    var goldNode: SKLabelNode?
    var statLabelLife: SKLabelNode?
    var statLabelMovement: SKLabelNode?
    var statLabelRegen: SKLabelNode?
    var lifeSymbol2: SKSpriteNode?
    var speedSymbol2: SKSpriteNode?
    var regenerationSymbol2: SKSpriteNode?
    var statLabelLife2: SKLabelNode?
    var statLabelMovement2: SKLabelNode?
    var statLabelRegen2: SKLabelNode?
    var weapon: ItemClass?
    var body: ItemClass?
    var feet: ItemClass?
    var neck: ItemClass?
    var headDisplay: SKSpriteNode?
    var leftDisplay: SKSpriteNode?
    var rightDisplay: SKSpriteNode?
    var neckDisplay: SKSpriteNode?
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        if spaceToMove != nil{
            spaceToMove!.texture = SKTexture(imageNamed: "Inventory_Slot_1")
            spaceToMove = nil
            itemToMove = nil
            statLabelLife!.text = ""
            statLabelMovement!.text = ""
            statLabelRegen!.text = ""
            self.childNodeWithName("sellButton")?.removeFromParent()
        }
        
        if firstLoad{
        self.backgroundColor = UIColor.grayColor()
        menu = SKSpriteNode(imageNamed: "Zones__Button_1")
        menu!.position = CGPointMake(self.frame.minX + 55, self.frame.maxY - 55)
        menu!.name = "menu"
        menu!.size = CGSizeMake(100, 100)
        self.addChild(menu!)
            let krakenNode = SKSpriteNode(imageNamed: "Fitting_Room_Kraken_1")
            krakenNode.position = CGPointMake(self.frame.midX, self.frame.maxY - 230)
            krakenNode.name = "kraken"
            krakenNode.size = CGSizeMake(250, 250)
            self.addChild(krakenNode)
            let lifeSymbol = SKSpriteNode(imageNamed: "Life_Symbol_1")
            lifeSymbol.position = CGPointMake(self.frame.minX + 25, self.frame.maxY - 140)
            lifeSymbol.zPosition = 2
            lifeSymbol.setScale(0.2)
            self.addChild(lifeSymbol)
            let speedSymbol = SKSpriteNode(imageNamed: "Speed_Symbol_1")
            speedSymbol.position = CGPointMake(self.frame.minX + 25, self.frame.maxY - 180)
            speedSymbol.zPosition = 2
            speedSymbol.setScale(0.2)
            self.addChild(speedSymbol)
            let regenerationSymbol = SKSpriteNode(imageNamed: "Regeneration_Symbol_1")
            regenerationSymbol.position = CGPointMake(self.frame.minX + 25, self.frame.maxY - 220)
            regenerationSymbol.zPosition = 2
            regenerationSymbol.setScale(0.2)
            self.addChild(regenerationSymbol)
            headDisplay = SKSpriteNode(imageNamed: "")
            headDisplay!.texture = nil
            headDisplay!.size = CGSizeMake(135, 80)
            headDisplay!.position = CGPointMake(krakenNode.position.x - 10, krakenNode.position.y + 75)
            headDisplay!.zPosition = 2
            self.addChild(headDisplay!)
            leftDisplay = SKSpriteNode(imageNamed: "")
            leftDisplay!.texture = nil
            leftDisplay!.size = CGSizeMake(40, 40)
            leftDisplay!.zRotation = -pi/3
            leftDisplay!.position = CGPointMake(krakenNode.position.x - 65, krakenNode.position.y - 40)
            leftDisplay!.zPosition = 2
            self.addChild(leftDisplay!)
            rightDisplay = SKSpriteNode(imageNamed: "")
            rightDisplay!.size = CGSizeMake(40, 40)
            rightDisplay!.zRotation = pi/3
            rightDisplay!.texture = nil
            rightDisplay!.position = CGPointMake(krakenNode.position.x + 65, krakenNode.position.y - 28)
            rightDisplay!.zPosition = 2
            self.addChild(rightDisplay!)
            neckDisplay = SKSpriteNode(imageNamed: "")
            neckDisplay!.size = CGSizeMake(110, 45)
            //neckDisplay!.zRotation = pi/3
            neckDisplay!.texture = nil
            neckDisplay!.position = CGPointMake(krakenNode.position.x, krakenNode.position.y - 25)
            neckDisplay!.zPosition = 2
            self.addChild(neckDisplay!)
        store = SKSpriteNode(imageNamed: "Store_Button_1")
        store!.position = CGPointMake(self.frame.maxX - 55, self.frame.maxY - 55)
        store!.name = "store"
        store!.size = CGSizeMake(100, 100)
        self.addChild(store!)
            let storeText = SKSpriteNode(imageNamed: "Fitting_Room_Text_1")
            storeText.position = CGPointMake(self.frame.midX, self.frame.maxY - 50)
            storeText.name = "store"
            storeText.size = CGSizeMake(165, 60)
            self.addChild(storeText)
        backPack = SKSpriteNode(imageNamed: "Inventory_Array_Background_1")
        backPack!.position = CGPointMake(self.frame.midX, self.frame.minY + 115)
        backPack!.size = CGSizeMake(325,195)
        backPack!.name = "backpack"
        self.addChild(backPack!)
            statLabelLife = SKLabelNode.init(text: "")
            statLabelLife!.position = CGPointMake(self.frame.midX - 100, self.frame.minY + 260)
            statLabelLife!.fontColor = UIColor.blueColor()
            statLabelLife!.name = "lifeStat"
            statLabelLife!.setScale(0.7)
            self.addChild(statLabelLife!)
            statLabelMovement = SKLabelNode.init(text: "")
            statLabelMovement!.position = CGPointMake(self.frame.midX + 25, self.frame.minY + 260)
            statLabelMovement!.fontColor = UIColor.blueColor()
            statLabelMovement!.name = "movementStat"
            statLabelMovement!.setScale(0.7)
            self.addChild(statLabelMovement!)
            statLabelRegen = SKLabelNode.init(text: "")
            statLabelRegen!.position = CGPointMake(self.frame.midX + 150, self.frame.minY + 260)
            statLabelRegen!.fontColor = UIColor.blueColor()
            statLabelRegen!.name = "regenStat"
            statLabelRegen!.setScale(0.7)
            self.addChild(statLabelRegen!)
            lifeSymbol2 = SKSpriteNode(imageNamed: "Life_Symbol_1")
            lifeSymbol2!.position = CGPointMake(self.frame.midX - 125, self.frame.minY + 260)
            lifeSymbol2!.zPosition = 2
            lifeSymbol2!.setScale(0.2)
            //self.addChild(lifeSymbol2)
            speedSymbol2 = SKSpriteNode(imageNamed: "Speed_Symbol_1")
            speedSymbol2!.position = CGPointMake(self.frame.midX, self.frame.minY + 260)
            speedSymbol2!.zPosition = 2
            speedSymbol2!.setScale(0.2)
            //self.addChild(speedSymbol2)
            regenerationSymbol2 = SKSpriteNode(imageNamed: "Regeneration_Symbol_1")
            regenerationSymbol2!.position = CGPointMake(self.frame.midX + 125, self.frame.minY + 260)
            regenerationSymbol2!.zPosition = 2
            regenerationSymbol2!.setScale(0.2)
            //self.addChild(regenerationSymbol2)
            statLabelLife2 = SKLabelNode.init(text: "0")
            statLabelLife2!.position = CGPointMake(self.frame.minX + 80, self.frame.maxY - 140)
            statLabelLife2!.fontColor = UIColor.blueColor()
            statLabelLife2!.name = "lifeStat"
            statLabelLife2!.setScale(0.7)
            self.addChild(statLabelLife2!)
            statLabelMovement2 = SKLabelNode.init(text: "0")
            statLabelMovement2!.position = CGPointMake(self.frame.minX + 80, self.frame.maxY - 180)
            statLabelMovement2!.fontColor = UIColor.blueColor()
            statLabelMovement2!.name = "movementStat"
            statLabelMovement2!.setScale(0.7)
            self.addChild(statLabelMovement2!)
            statLabelRegen2 = SKLabelNode.init(text: "0")
            statLabelRegen2!.position = CGPointMake(self.frame.minX + 80, self.frame.maxY - 220)
            statLabelRegen2!.fontColor = UIColor.blueColor()
            statLabelRegen2!.name = "regenStat"
            statLabelRegen2!.setScale(0.7)
            self.addChild(statLabelRegen2!)
            
        let weaponLabel = SKSpriteNode(imageNamed: "Noggin_Text_1")
        weaponLabel.setScale(0.35)
        weaponLabel.position = CGPointMake(self.frame.maxX - 40, self.frame.maxY - 120)
        self.addChild(weaponLabel)
        let neckLabel = SKSpriteNode(imageNamed: "Neck_Text_1")
            neckLabel.setScale(0.35)
            neckLabel.position = CGPointMake(self.frame.maxX - 40, self.frame.maxY - 195)
            self.addChild(neckLabel)
        let bodyLabel = SKSpriteNode(imageNamed: "Left_Text_1")
            bodyLabel.setScale(0.35)
            bodyLabel.position = CGPointMake(self.frame.minX + 40, self.frame.maxY - 275)
            self.addChild(bodyLabel)
        let feetLabel = SKSpriteNode(imageNamed: "Right_Text_1")
            feetLabel.setScale(0.35)
        feetLabel.position = CGPointMake(self.frame.maxX - 40, self.frame.maxY - 275)
        self.addChild(feetLabel)
        //create all the item spaces
        //row 1
        let itemSpace1 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 40, backPack!.frame.maxY - 40))
        itemSpace1.setScale(1.3)
        itemSpace1.zPosition = 1
        itemSpace1.name = "1"
        itemSpaces.append(itemSpace1)
        self.addChild(itemSpace1)
        let itemSpace2 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 100, backPack!.frame.maxY - 40))
            itemSpace2.setScale(1.3)
        itemSpace2.zPosition = 1
        itemSpace2.name = "2"
        itemSpaces.append(itemSpace2)
        self.addChild(itemSpace2)
        let itemSpace3 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 160, backPack!.frame.maxY - 40))
            itemSpace3.setScale(1.3)
        itemSpace3.zPosition = 1
        itemSpace3.name = "3"
        itemSpaces.append(itemSpace3)
        self.addChild(itemSpace3)
        let itemSpace4 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 220, backPack!.frame.maxY - 40))
            itemSpace4.setScale(1.3)
        itemSpace4.zPosition = 1
        itemSpace4.name = "4"
        itemSpaces.append(itemSpace4)
        self.addChild(itemSpace4)
            let itemSpace5 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 280, backPack!.frame.maxY - 40))
            itemSpace5.setScale(1.3)
            itemSpace5.zPosition = 1
            itemSpace5.name = "5"
            itemSpaces.append(itemSpace5)
            self.addChild(itemSpace5)
        //row 2
        let itemSpace6 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 40, backPack!.frame.maxY - 100))
            itemSpace6.setScale(1.3)
        itemSpace6.zPosition = 1
        itemSpace6.name = "6"
        itemSpaces.append(itemSpace6)
        self.addChild(itemSpace6)
        let itemSpace7 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 100, backPack!.frame.maxY - 100))
            itemSpace7.setScale(1.3)
        itemSpace7.zPosition = 1
        itemSpace7.name = "7"
        itemSpaces.append(itemSpace7)
        self.addChild(itemSpace7)
        let itemSpace8 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 160, backPack!.frame.maxY - 100))
            itemSpace8.setScale(1.3)
        itemSpace8.zPosition = 1
        itemSpace8.name = "8"
        itemSpaces.append(itemSpace8)
        self.addChild(itemSpace8)
        let itemSpace9 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 220, backPack!.frame.maxY - 100))
        itemSpace9.zPosition = 1
            itemSpace9.setScale(1.3)
        itemSpace9.name = "9"
        itemSpaces.append(itemSpace9)
        self.addChild(itemSpace9)
            let itemSpace10 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 280, backPack!.frame.maxY - 100))
            itemSpace10.zPosition = 1
            itemSpace10.setScale(1.3)
            itemSpace10.name = "10"
            itemSpaces.append(itemSpace10)
            self.addChild(itemSpace10)
            
        //row 3
        let itemSpace11 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 40, backPack!.frame.maxY - 160))
            itemSpace11.setScale(1.3)
        itemSpace11.zPosition = 1
        itemSpace11.name = "11"
        itemSpaces.append(itemSpace11)
        self.addChild(itemSpace11)
        let itemSpace12 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 100, backPack!.frame.maxY - 160))
            itemSpace12.setScale(1.3)
        itemSpace12.zPosition = 1
        itemSpace12.name = "12"
        itemSpaces.append(itemSpace12)
        self.addChild(itemSpace12)
        let itemSpace13 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 160, backPack!.frame.maxY - 160))
            itemSpace13.setScale(1.3)
        itemSpace13.zPosition = 1
        itemSpace13.name = "13"
        itemSpaces.append(itemSpace13)
        self.addChild(itemSpace13)
        let itemSpace14 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 220, backPack!.frame.maxY - 160))
            itemSpace14.setScale(1.3)
        itemSpace14.zPosition = 1
        itemSpace14.name = "14"
        itemSpaces.append(itemSpace14)
        self.addChild(itemSpace14)
            let itemSpace15 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 280, backPack!.frame.maxY - 160))
            itemSpace15.setScale(1.3)
            itemSpace15.zPosition = 1
            itemSpace15.name = "15"
            itemSpaces.append(itemSpace15)
            self.addChild(itemSpace15)
            
            
        //weaponspace holds noggin items
        let weaponSpace = ItemSpaceNode.spaceAtPosition(CGPointMake(weaponLabel.frame.midX, weaponLabel.frame.midY - 40))
        weaponSpace.zPosition = 1
        weaponSpace.name = "weapon"
        self.addChild(weaponSpace)
        itemSpaces.append(weaponSpace)
            let neckSpace = ItemSpaceNode.spaceAtPosition(CGPointMake(neckLabel.frame.midX, neckLabel.frame.midY - 40))
            neckSpace.zPosition = 1
            neckSpace.name = "neck"
            self.addChild(neckSpace)
            itemSpaces.append(neckSpace)
            //body and feet spaces are tentacles
        let bodySpace = ItemSpaceNode.spaceAtPosition(CGPointMake(bodyLabel.frame.midX, bodyLabel.frame.midY - 40))
        bodySpace.zPosition = 1
        bodySpace.name = "body"
        self.addChild(bodySpace)
        itemSpaces.append(bodySpace)
        let feetSpace = ItemSpaceNode.spaceAtPosition(CGPointMake(feetLabel.frame.midX, feetLabel.frame.midY - 40))
        feetSpace.zPosition = 1
        feetSpace.name = "feet"
        self.addChild(feetSpace)
        itemSpaces.append(feetSpace)
            
        
        //booty coin image
        let booty = SKSpriteNode(imageNamed: "Booty_1.png")
        booty.position = CGPointMake(self.frame.maxX - 40, self.frame.minY + 225)
        booty.setScale(0.08)
        self.addChild(booty)
        //gold node
        goldNode = SKLabelNode.init(text: "\(Int(gold))")
        goldNode!.position = CGPointMake(self.frame.maxX - 100, self.frame.minY + 215)
        self.addChild(goldNode!)
        }
        
        updateStats()
        
        goldNode!.text = "\(Int(gold))"
        goldNode!.fontColor = UIColor.yellowColor()
        
        self.populateBags()
        if spaceToMove != nil{
            spaceToMove!.color = UIColor.whiteColor()
        }
        itemToMove = nil
        spaceToMove = nil
        self.firstLoad = false
        
    }
    
    func updateStats() {
        var life = 1
        var movement = 120
        var regen = 0
        let weaponSpace = self.childNodeWithName("weapon") as! ItemSpaceNode
        let bodySpace = self.childNodeWithName("body") as! ItemSpaceNode
        let neckSpace = self.childNodeWithName("neck") as! ItemSpaceNode
        let feetSpace = self.childNodeWithName("feet") as! ItemSpaceNode
        if (weaponSpace.item != nil){
            for statTuple in weaponSpace.item!.getStats(){
                if statTuple.0 == "Life" {
                    life += Int(statTuple.1)
                }else if statTuple.0 == "Movement" {
                    movement += Int(statTuple.1)
                }else if statTuple.0 == "Regeneration" {
                    regen += Int(statTuple.1)
                }
            }
        }
        if (neckSpace.item != nil){
            for statTuple in neckSpace.item!.getStats(){
                if statTuple.0 == "Life" {
                    life += Int(statTuple.1)
                }else if statTuple.0 == "Movement" {
                    movement += Int(statTuple.1)
                }else if statTuple.0 == "Regeneration" {
                    regen += Int(statTuple.1)
                }
            }
        }
        if (feetSpace.item != nil) {
            for statTuple in feetSpace.item!.getStats(){
                if statTuple.0 == "Life" {
                    life += Int(statTuple.1)
                }else if statTuple.0 == "Movement" {
                    movement += Int(statTuple.1)
                }else if statTuple.0 == "Regeneration" {
                    regen += Int(statTuple.1)
                }
            }
        }
        if (bodySpace.item != nil) {
            for statTuple in bodySpace.item!.getStats(){
                if statTuple.0 == "Life" {
                    life += Int(statTuple.1)
                }else if statTuple.0 == "Movement" {
                    movement += Int(statTuple.1)
                }else if statTuple.0 == "Regeneration" {
                    regen += Int(statTuple.1)
                }
            }
        }
        
        statLabelLife2!.text = "\(life)"
        statLabelMovement2!.text = "\(movement)"
        statLabelRegen2!.text = "\(regen)"
    }
    
    func addItem(itemName: String){
        println("adding item to items array")
        if backPackSpaces == 0 {
            println("YOUR PACK IS FULL")
        }else{
            let anItem = ItemClass.itemInSpace(itemName)
            anItem.size = CGSizeMake(37, 37)
            items.append(anItem)
            backPackSpaces--
        }
    }
    
    //put the items into itemSpaces
    func populateBags(){
        var count = 0
        for item in items{
            var placed = false
            for space in itemSpaces{
                if space.item == nil && placed == false{
                    space.insertItem(item)
                    placed = true
                    items.removeAtIndex(count)
                    count--
                }
            }
            count++
        }
    }
    
    func sellItem(){
        gold += round(itemToMove!.price! / 10)
        goldNode!.text = "\(Int(gold))"
        spaceToMove!.texture = SKTexture(imageNamed: "Inventory_Slot_1")
        spaceToMove!.item = nil
        itemToMove?.removeFromParent()
        spaceToMove!.color = UIColor.whiteColor()
        self.childNodeWithName("sellButton")?.removeFromParent()
        if !(spaceToMove!.name == "weapon" || spaceToMove!.name == "body" || spaceToMove!.name == "feet" || spaceToMove!.name == "neck"){
            backPackSpaces++
        }else{
            if spaceToMove!.name == "weapon"{
                headDisplay!.texture = nil
            }else if spaceToMove!.name == "body" {
                leftDisplay!.texture = nil
            }else if spaceToMove!.name == "feet"{
                rightDisplay!.texture = nil
            }else{
                neckDisplay!.texture = nil
            }
        }
        spaceToMove = nil
        itemToMove = nil
        statLabelLife!.text = ""
        statLabelMovement!.text = ""
        statLabelRegen!.text = ""
        lifeSymbol2?.removeFromParent()
        speedSymbol2?.removeFromParent()
        regenerationSymbol2?.removeFromParent()
        self.childNodeWithName("itemName")?.removeFromParent()
        self.childNodeWithName("priceButton")?.removeFromParent()
        self.childNodeWithName("sellBooty")?.removeFromParent()
        
    }
    
    func displayItem(item: ItemClass, spot: String) {
        //println("got here!!!!\(spaceToMove!.item!.itemName!)")
        if spot == "weapon"{
            headDisplay!.texture = SKTexture(imageNamed: "\(item.itemName!)")
        }else if spot == "body" {
            var itemName = item.itemName!
            itemName = itemName.stringByReplacingOccurrencesOfString("1", withString: "2", options: NSStringCompareOptions.LiteralSearch, range: nil)
            leftDisplay!.texture = SKTexture(imageNamed: "\(itemName)")
        }else if spot == "feet" {
            var itemName = item.itemName!
            itemName = itemName.stringByReplacingOccurrencesOfString("1", withString: "2", options: NSStringCompareOptions.LiteralSearch, range: nil)
            rightDisplay!.texture = SKTexture(imageNamed: "\(itemName)")
        }else {
            var itemName = item.itemName!
            itemName = itemName.stringByReplacingOccurrencesOfString("1", withString: "2", options: NSStringCompareOptions.LiteralSearch, range: nil)
            //ZACH
            if itemName == "Bow_Tie_2" {
                itemName = "Bow_Tie_1"
                neckDisplay!.size = CGSizeMake(200, 50)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Copper_Ring_2" {
                neckDisplay!.size = CGSizeMake(100, 200)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Silver_Ring_2" {
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Gold_Ring_2" {
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Water_Wing_2" {
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Sweaty_Wristband_2" {
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Whistle_2" {
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Lifejacket_2" {
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Beach_Towel_2" {
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Floatie_2" {
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Sun_Screen_2" {
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Sweatband_2" {
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Visor_2" {
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Sand_Bucket_2" {
                itemName = "Sand_Bucket_1"
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Sun_Hat_2" {
                itemName = "Sun_Hat_1"
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Shades_2" {
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Bling_Ring_2" {
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Bow_Tie_2" {
                itemName = "Bow_Tie_1"
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Monocle_2" {
                itemName = "Monocle_1"
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Watch_2" {
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            } else if itemName == "Top_Hat_2" {
                itemName = "Top_Hat_1"
                neckDisplay!.size = CGSizeMake(60, 60)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.midY)
            }
            
            
            
            neckDisplay!.texture = SKTexture(imageNamed: "\(itemName)")
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in touches{
            if menu!.containsPoint((touch as! UITouch).locationInNode(self)){
                //let menuScene = MainMenuScene(size: self.frame.size)
                //menuScene.userData?.setValue(self.userData?.objectForKey("inventory"), forKey: "inventory")
                (self.userData?.objectForKey("menu") as! MainMenuScene).userData?.setObject(self, forKey: "inventory")
                let skTransition = SKTransition.fadeWithDuration(1.0)
                //self.view?.presentScene(menuScene, transition: skTransition)
                self.view?.presentScene(self.userData?.objectForKey("worldscene") as! ZoneScene, transition: skTransition)
            }else if store!.containsPoint((touch as! UITouch).locationInNode(self)){
                let storeScene = StoreScene(size: self.frame.size)
                storeScene.userData = NSMutableDictionary()
                storeScene.userData?.setObject(self, forKey: "inventory")
                //storeScene.userData?.setObject(self.userData?.objectForKey("menu") as MainMenuScene, forKey: "menu")
                storeScene.userData?.setObject(self.userData?.objectForKey("worldscene") as! ZoneScene, forKey: "worldscene")
                let skTransition = SKTransition.fadeWithDuration(1.0)
                //self.view?.presentScene(menuScene, transition: skTransition)
                self.view?.presentScene(storeScene, transition: skTransition)
            }else if self.childNodeWithName("sellButton") != nil && self.childNodeWithName("sellButton")!.containsPoint((touch as! UITouch).locationInNode(self)){
                sellItem()
            }else{
                for space in itemSpaces{
                    if space.containsPoint((touch as! UITouch).locationInNode(self)){
                        if spaceToMove != nil{
                            spaceToMove!.texture = SKTexture(imageNamed: "Inventory_Slot_1")
                        }
                        //clicked on space with item in it
                        if space.item != nil{
                            if self.itemToMove == nil{
                                self.itemToMove = space.item
                                self.spaceToMove = space
                                //set "clicked" texture
                                space.texture = SKTexture(imageNamed: "Inventory_Slot_3")
                            }//already an item to move, swap
                            else{
                                //unset "clicked" texture
                                space.texture = SKTexture(imageNamed: "Inventory_Slot_1")
                                //check if both are equipped, item and space to move to nil and put everything else in an else
                                if (spaceToMove!.name == "body" || spaceToMove!.name == "feet" || spaceToMove!.name == "weapon" || spaceToMove!.name == "neck") && (space.name == "body" || space.name == "feet" || space.name == "weapon" || space.name == "neck"){
                                    println("both item slots!!")
                                    self.itemToMove = nil
                                    self.spaceToMove = nil
                                }else{
                                    if space.name == "weapon" || space.name == "body" || space.name == "feet" || space.name == "neck"{
                                        if space.name == "weapon" && itemToMove!.itemType == ItemType.weapon{
                                                //weapon = space.item
                                            self.spaceToMove!.insertItem(space.item!)
                                            space.insertItem(self.itemToMove!)
                                            displayItem(itemToMove!, spot: "weapon")
                                        }else if space.name == "body" && (itemToMove!.itemType == ItemType.body || itemToMove!.itemType == ItemType.feet){
                                            self.spaceToMove!.insertItem(space.item!)
                                            space.insertItem(self.itemToMove!)
                                            displayItem(itemToMove!, spot: "body")
                                        }else if space.name == "feet" && (itemToMove!.itemType == ItemType.feet || itemToMove!.itemType == ItemType.body){
                                                //feet = space.item
                                            self.spaceToMove!.insertItem(space.item!)
                                            space.insertItem(self.itemToMove!)
                                            displayItem(itemToMove!, spot: "feet")
                                        }else if space.name == "neck" && itemToMove!.itemType == ItemType.neck{
                                            self.spaceToMove!.insertItem(space.item!)
                                            space.insertItem(self.itemToMove!)
                                            displayItem(itemToMove!, spot: "neck")
                                        }
                                    }else if spaceToMove!.name == "weapon" || spaceToMove!.name == "body" || spaceToMove!.name == "feet" || spaceToMove!.name == "neck"{
                                        //CHECK IF SPACETOMOVE IS WEP,BODY,FEET AND THEN CHECK SPACE'S ITEMTYPE
                                        if spaceToMove!.name == "weapon" && space.item!.itemType == ItemType.weapon{
                                            //weapon = space.item
                                            self.spaceToMove!.insertItem(space.item!)
                                            displayItem(space.item!, spot: "weapon")
                                            space.insertItem(self.itemToMove!)
                                        }else if spaceToMove!.name == "body" && space.item!.itemType == ItemType.body{
                                            self.spaceToMove!.insertItem(space.item!)
                                            space.insertItem(self.itemToMove!)
                                            displayItem(space.item!, spot: "body")
                                            //body = space.item
                                        }else if spaceToMove!.name == "feet" && space.item!.itemType == ItemType.feet{
                                            //feet = space.item
                                            self.spaceToMove!.insertItem(space.item!)
                                            space.insertItem(self.itemToMove!)
                                            displayItem(space.item!, spot: "feet")
                                        }else if spaceToMove!.name == "neck" && space.item!.itemType == ItemType.neck{
                                            self.spaceToMove!.insertItem(space.item!)
                                            displayItem(space.item!, spot: "neck")
                                            space.insertItem(self.itemToMove!)
                                        }
                                    }
                                    else{
                                        self.spaceToMove!.insertItem(space.item!)
                                        space.insertItem(self.itemToMove!)
                                    }
                                    self.itemToMove = nil
                                    self.spaceToMove = nil
                                }
                                
                                
                            }
                        }//clicked on space with no item in it
                        else{
                            //add item to new space if have item to move
                            if self.itemToMove != nil{
                                if spaceToMove!.name == "weapon"{
                                    weapon = nil
                                }else if spaceToMove!.name == "body"{
                                    body = nil
                                }else if spaceToMove!.name == "feet"{
                                    feet = nil
                                }else if spaceToMove!.name == "neck"{
                                    neck = nil
                                }
                                var moved = false
                                if space.name == "weapon" || space.name == "body" || space.name == "feet" || space.name == "neck"{
                                    if space.name == "weapon" && itemToMove!.itemType == ItemType.weapon{
                                        backPackSpaces++
                                        weapon = itemToMove
                                        displayItem(itemToMove!, spot: "weapon")
                                        spaceToMove!.removeItem()
                                        space.insertItem(self.itemToMove!)
                                        moved = true
                                        
                                    }else if space.name == "body" && (itemToMove!.itemType == ItemType.body || itemToMove!.itemType == ItemType.feet){
                                        backPackSpaces++
                                        body = itemToMove
                                        displayItem(itemToMove!, spot: "body")
                                        spaceToMove!.removeItem()
                                        space.insertItem(self.itemToMove!)
                                        moved = true
                                        
                                    }else if space.name == "feet" && (itemToMove!.itemType == ItemType.feet || itemToMove!.itemType == ItemType.body){
                                        backPackSpaces++
                                        feet = itemToMove
                                        displayItem(itemToMove!, spot: "feet")
                                        spaceToMove!.removeItem()
                                        space.insertItem(self.itemToMove!)
                                        moved = true
                                        
                                    }else if space.name == "neck" && itemToMove!.itemType == ItemType.neck{
                                        backPackSpaces++
                                        neck = itemToMove
                                        displayItem(itemToMove!, spot: "neck")
                                        spaceToMove!.removeItem()
                                        space.insertItem(self.itemToMove!)
                                        moved = true
                                    }else{
                                        println("trying to move item into wrong typed slot dumbass")
                                    }
                                }else{
                                    spaceToMove!.removeItem()
                                    space.insertItem(self.itemToMove!)
                                    moved = true
                                }
                                if (spaceToMove!.name == "weapon" || spaceToMove!.name == "body" || spaceToMove!.name == "feet" || spaceToMove!.name == "neck") && moved{
                                    backPackSpaces--
                                    if spaceToMove!.name == "weapon"{
                                        headDisplay!.texture = nil
                                    }else if spaceToMove!.name == "body"{
                                        leftDisplay!.texture = nil
                                    }else if spaceToMove!.name == "feet"{
                                        rightDisplay!.texture = nil
                                    }else if spaceToMove!.name == "neck"{
                                        neckDisplay!.texture = nil
                                    }
                                }
                                //change position of item in array
                            }
                            //no item in this space so clean up
                            self.itemToMove = nil
                            self.spaceToMove = nil
                        }
                        //space.wasClicked = true
                        //self.itemToMove = space.item
                        if spaceToMove != nil{
                            spaceToMove!.color = UIColor.blueColor()
                            statLabelLife!.text = "0"
                            statLabelMovement!.text = "0"
                            statLabelRegen!.text = "0"
                            for tuple in itemToMove!.getStats(){
                                if tuple.0 == "Life"{
                                    statLabelLife!.text = "\(Int(tuple.1))"
                                }else if tuple.0 == "Movement"{
                                    statLabelMovement!.text = "\(Int(tuple.1))"
                                }else if tuple.0 == "Regeneration"{
                                    statLabelRegen!.text = "\(Int(tuple.1))"
                                }
                            }
                            self.addChild(lifeSymbol2!)
                            self.addChild(speedSymbol2!)
                            self.addChild(regenerationSymbol2!)
                            if self.childNodeWithName("priceButton") != nil{
                                self.childNodeWithName("priceButton")?.removeFromParent()
                            }
                            let sellNode = SKLabelNode.init(text: "\(round(itemToMove!.price! / 5))")
                            sellNode.position = CGPointMake(self.frame.minX + 60, self.frame.minY + 215)
                            sellNode.fontSize = 30
                            sellNode.name = "priceButton"
                            sellNode.fontColor = UIColor.blueColor()
                            self.addChild(sellNode)
                            
                            //booty coin image
                            let booty = SKSpriteNode(imageNamed: "Booty_1.png")
                            booty.position = CGPointMake(self.frame.minX + 120, self.frame.minY + 225)
                            booty.name = "sellBooty"
                            booty.setScale(0.08)
                            self.addChild(booty)
                            //sell text
                            let sellText = SKSpriteNode(imageNamed: "Sell_Text_1.png")
                            sellText.position = CGPointMake(self.frame.midX, self.frame.minY + 225)
                            sellText.setScale(0.4)
                            sellText.name = "sellButton"
                            self.addChild(sellText)
                            //name of the item
                            var itemPicName = spaceToMove!.item!.itemName!
                            //println("\(itemPicName)")
                            itemPicName = itemPicName.stringByReplacingOccurrencesOfString("1", withString: "Text", options: NSStringCompareOptions.LiteralSearch, range: nil)
                            let itemText = SKSpriteNode(imageNamed: "\(itemPicName)")
                            itemText.name = "itemName"
                            itemText.size = CGSizeMake(150, 30)
                            itemText.position = CGPointMake(self.frame.midX, self.frame.minY + 290)
                            self.addChild(itemText)
                        }else{
                            statLabelLife!.text = ""
                            statLabelMovement!.text = ""
                            statLabelRegen!.text = ""
                            lifeSymbol2?.removeFromParent()
                            speedSymbol2?.removeFromParent()
                            regenerationSymbol2?.removeFromParent()
                            self.childNodeWithName("sellButton")?.removeFromParent()
                            self.childNodeWithName("itemName")?.removeFromParent()
                            self.childNodeWithName("priceButton")?.removeFromParent()
                            self.childNodeWithName("sellBooty")?.removeFromParent()
                        }
                    }//else{
                        //space.wasClicked = false
                   // }
                }
            }
        }
        updateStats()
    }
}