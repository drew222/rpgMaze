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
    var backPackSpaces = 16
    var gold: CGFloat = 1500
    var goldNode: SKLabelNode?
    var statLabel: SKLabelNode?
    var weapon: ItemClass?
    var body: ItemClass?
    var feet: ItemClass?
    var headDisplay: SKSpriteNode?
    var leftDisplay: SKSpriteNode?
    var rightDisplay: SKSpriteNode?
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        if firstLoad{
        self.backgroundColor = UIColor.grayColor()
        menu = SKSpriteNode(imageNamed: "Zones__Button_1")
        menu!.position = CGPointMake(self.frame.minX + 55, self.frame.maxY - 55)
        menu!.name = "menu"
        menu!.size = CGSizeMake(100, 100)
        self.addChild(menu!)
            let krakenNode = SKSpriteNode(imageNamed: "Fitting_Room_Kraken_1")
            krakenNode.position = CGPointMake(self.frame.midX, self.frame.midY + 100)
            krakenNode.name = "kraken"
            krakenNode.size = CGSizeMake(200, 200)
            self.addChild(krakenNode)
            headDisplay = SKSpriteNode(imageNamed: "")
            headDisplay!.texture = nil
            headDisplay!.size = CGSizeMake(80, 80)
            headDisplay!.position = CGPointMake(krakenNode.position.x - 10, krakenNode.position.y + 90)
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
        backPack!.position = CGPointMake(self.frame.maxX - 135, self.frame.minY + 135)
        backPack!.size = CGSizeMake(260,260)
        backPack!.name = "backpack"
        self.addChild(backPack!)
        statLabel = SKLabelNode.init(text: "")
        statLabel!.position = CGPointMake(self.frame.midX + 70, self.frame.maxY - 360)
        resizeLabel(statLabel!)
        self.addChild(statLabel!)
        let bodyLabel = SKLabelNode.init(text: "Left")
        bodyLabel.position = CGPointMake(self.frame.minX + 50, self.frame.minY + 150)
        self.addChild(bodyLabel)
        let weaponLabel = SKLabelNode.init(text: "Noggin")
        weaponLabel.position = CGPointMake(self.frame.minX + 50, self.frame.minY + 230)
        self.addChild(weaponLabel)
        let feetLabel = SKLabelNode.init(text: "Right")
        feetLabel.position = CGPointMake(self.frame.minX + 50, self.frame.minY + 70)
        self.addChild(feetLabel)
        //create all the item spaces
        let itemSpace1 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 40, backPack!.frame.maxY - 40))
        itemSpace1.zPosition = 1
        itemSpace1.name = "1"
        itemSpaces.append(itemSpace1)
        self.addChild(itemSpace1)
        let itemSpace2 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 100, backPack!.frame.maxY - 40))
        itemSpace2.zPosition = 1
        itemSpace1.name = "2"
        itemSpaces.append(itemSpace2)
        self.addChild(itemSpace2)
        let itemSpace3 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 160, backPack!.frame.maxY - 40))
        itemSpace3.zPosition = 1
        itemSpace1.name = "3"
        itemSpaces.append(itemSpace3)
        self.addChild(itemSpace3)
        let itemSpace4 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 220, backPack!.frame.maxY - 40))
        itemSpace4.zPosition = 1
        itemSpace1.name = "4"
        itemSpaces.append(itemSpace4)
        self.addChild(itemSpace4)
        let itemSpace5 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 40, backPack!.frame.maxY - 100))
        itemSpace5.zPosition = 1
        itemSpace1.name = "5"
        itemSpaces.append(itemSpace5)
        self.addChild(itemSpace5)
        let itemSpace6 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 100, backPack!.frame.maxY - 100))
        itemSpace6.zPosition = 1
        itemSpace1.name = "6"
        itemSpaces.append(itemSpace6)
        self.addChild(itemSpace6)
        let itemSpace7 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 160, backPack!.frame.maxY - 100))
        itemSpace7.zPosition = 1
        itemSpace1.name = "7"
        itemSpaces.append(itemSpace7)
        self.addChild(itemSpace7)
        let itemSpace8 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 220, backPack!.frame.maxY - 100))
        itemSpace8.zPosition = 1
        itemSpace1.name = "8"
        itemSpaces.append(itemSpace8)
        self.addChild(itemSpace8)
        let itemSpace9 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 40, backPack!.frame.maxY - 160))
        itemSpace9.zPosition = 1
        itemSpace1.name = "9"
        itemSpaces.append(itemSpace9)
        self.addChild(itemSpace9)
        let itemSpace10 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 100, backPack!.frame.maxY - 160))
        itemSpace10.zPosition = 1
        itemSpace1.name = "10"
        itemSpaces.append(itemSpace10)
        self.addChild(itemSpace10)
        let itemSpace11 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 160, backPack!.frame.maxY - 160))
        itemSpace11.zPosition = 1
        itemSpace1.name = "11"
        itemSpaces.append(itemSpace11)
        self.addChild(itemSpace11)
        let itemSpace12 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 220, backPack!.frame.maxY - 160))
        itemSpace12.zPosition = 1
        itemSpace1.name = "12"
        itemSpaces.append(itemSpace12)
        self.addChild(itemSpace12)
        let itemSpace13 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 40, backPack!.frame.maxY - 220))
        itemSpace13.zPosition = 1
        itemSpace1.name = "13"
        itemSpaces.append(itemSpace13)
        self.addChild(itemSpace13)
        let itemSpace14 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 100, backPack!.frame.maxY - 220))
        itemSpace14.zPosition = 1
        itemSpace1.name = "14"
        itemSpaces.append(itemSpace14)
        self.addChild(itemSpace14)
        let itemSpace15 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 160, backPack!.frame.maxY - 220))
        itemSpace15.zPosition = 1
        itemSpace1.name = "15"
        itemSpaces.append(itemSpace15)
        self.addChild(itemSpace15)
        let itemSpace16 = ItemSpaceNode.spaceAtPosition(CGPointMake(backPack!.frame.minX + 220, backPack!.frame.maxY - 220))
        itemSpace16.zPosition = 1
        itemSpace1.name = "16"
        itemSpaces.append(itemSpace16)
        self.addChild(itemSpace16)
            //weaponspace holds noggin items
        let weaponSpace = ItemSpaceNode.spaceAtPosition(CGPointMake(weaponLabel.frame.midX, weaponLabel.frame.midY - 40))
        weaponSpace.zPosition = 1
        weaponSpace.name = "weapon"
        self.addChild(weaponSpace)
        itemSpaces.append(weaponSpace)
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
            
        //gold node
        goldNode = SKLabelNode.init(text: "\(Int(gold))")
        goldNode!.position = CGPointMake(self.frame.maxX - 80, self.frame.maxY - 400)
        self.addChild(goldNode!)
        }
        
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
        if !(spaceToMove!.name == "weapon" || spaceToMove!.name == "body" || spaceToMove!.name == "feet"){
            backPackSpaces++
        }else{
            if spaceToMove!.name == "weapon"{
                headDisplay!.texture = nil
            }else if spaceToMove!.name == "body" {
                leftDisplay!.texture = nil
            }else{
                rightDisplay!.texture = nil
            }
        }
        spaceToMove = nil
        itemToMove = nil
        statLabel!.text = ""
        
    }
    
    func displayItem(item: ItemClass, spot: String) {
        println("got here!!!!\(spaceToMove!.item!.itemName!)")
        if spot == "weapon" {
            println("got here222@!!!!!!!")
            headDisplay!.texture = SKTexture(imageNamed: "\(item.itemName!)")
        }else if spot == "body" {
            var itemName = item.itemName!
            itemName = itemName.stringByReplacingOccurrencesOfString("1", withString: "2", options: NSStringCompareOptions.LiteralSearch, range: nil)
            leftDisplay!.texture = SKTexture(imageNamed: "\(itemName)")
        }else if spot == "feet" {
            var itemName = item.itemName!
            itemName = itemName.stringByReplacingOccurrencesOfString("1", withString: "2", options: NSStringCompareOptions.LiteralSearch, range: nil)
            rightDisplay!.texture = SKTexture(imageNamed: "\(itemName)")
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches{
            if menu!.containsPoint(touch.locationInNode(self)){
                //let menuScene = MainMenuScene(size: self.frame.size)
                //menuScene.userData?.setValue(self.userData?.objectForKey("inventory"), forKey: "inventory")
                (self.userData?.objectForKey("menu") as MainMenuScene).userData?.setObject(self, forKey: "inventory")
                let skTransition = SKTransition.fadeWithDuration(1.0)
                //self.view?.presentScene(menuScene, transition: skTransition)
                self.view?.presentScene(self.userData?.objectForKey("worldscene") as ZoneScene, transition: skTransition)
            }else if store!.containsPoint(touch.locationInNode(self)){
                let storeScene = StoreScene(size: self.frame.size)
                storeScene.userData = NSMutableDictionary()
                storeScene.userData?.setObject(self, forKey: "inventory")
                //storeScene.userData?.setObject(self.userData?.objectForKey("menu") as MainMenuScene, forKey: "menu")
                storeScene.userData?.setObject(self.userData?.objectForKey("worldscene") as ZoneScene, forKey: "worldscene")
                let skTransition = SKTransition.fadeWithDuration(1.0)
                //self.view?.presentScene(menuScene, transition: skTransition)
                self.view?.presentScene(storeScene, transition: skTransition)
            }else if self.childNodeWithName("sellButton")? != nil && self.childNodeWithName("sellButton")!.containsPoint(touch.locationInNode(self)){
                sellItem()
            }else{
                for space in itemSpaces{
                    if space.containsPoint(touch.locationInNode(self)){
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
                                if (spaceToMove!.name == "body" || spaceToMove!.name == "feet" || spaceToMove!.name == "weapon") && (space.name == "body" || space.name == "feet" || space.name == "weapon"){
                                    self.itemToMove = nil
                                    self.spaceToMove = nil
                                }else{
                                    if space.name == "weapon" || space.name == "body" || space.name == "feet"{
                                        if space.name == "weapon" && itemToMove!.itemType == ItemType.weapon{
                                                //weapon = space.item
                                            self.spaceToMove!.insertItem(space.item!)
                                            space.insertItem(self.itemToMove!)
                                            displayItem(itemToMove!, spot: "weapon")
                                        }else if space.name == "body" && (itemToMove!.itemType == ItemType.body || itemToMove!.itemType == ItemType.feet){
                                            self.spaceToMove!.insertItem(space.item!)
                                            space.insertItem(self.itemToMove!)
                                            displayItem(itemToMove!, spot: "body")
                                                //body = space.item
                                        }else if space.name == "feet" && (itemToMove!.itemType == ItemType.feet || itemToMove!.itemType == ItemType.body){
                                                //feet = space.item
                                            self.spaceToMove!.insertItem(space.item!)
                                            space.insertItem(self.itemToMove!)
                                            displayItem(itemToMove!, spot: "feet")
                                        }
                                    }else if spaceToMove!.name == "weapon" || spaceToMove!.name == "body" || spaceToMove!.name == "feet"{
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
                                }
                                if space.name == "weapon" || space.name == "body" || space.name == "feet"{
                                    if space.name == "weapon" && itemToMove!.itemType == ItemType.weapon{
                                        backPackSpaces++
                                        weapon = itemToMove
                                        displayItem(itemToMove!, spot: "weapon")
                                        spaceToMove!.removeItem()
                                        space.insertItem(self.itemToMove!)
                                        
                                    }else if space.name == "body" && (itemToMove!.itemType == ItemType.body || itemToMove!.itemType == ItemType.feet){
                                        backPackSpaces++
                                        body = itemToMove
                                        displayItem(itemToMove!, spot: "body")
                                        spaceToMove!.removeItem()
                                        space.insertItem(self.itemToMove!)
                                        
                                    }else if space.name == "feet" && (itemToMove!.itemType == ItemType.feet || itemToMove!.itemType == ItemType.body){
                                        backPackSpaces++
                                        feet = itemToMove
                                        displayItem(itemToMove!, spot: "feet")
                                        spaceToMove!.removeItem()
                                        space.insertItem(self.itemToMove!)
                                        
                                    }else{
                                        println("trying to move item into wrong typed slot dumbass")
                                    }
                                }else{
                                    spaceToMove!.removeItem()
                                    space.insertItem(self.itemToMove!)
                                }
                                if spaceToMove!.name == "weapon" || spaceToMove!.name == "body" || spaceToMove!.name == "feet"{
                                    backPackSpaces--
                                    if spaceToMove!.name == "weapon"{
                                        headDisplay!.texture = nil
                                    }else if spaceToMove!.name == "body"{
                                        leftDisplay!.texture = nil
                                    }else if spaceToMove!.name == "feet"{
                                        rightDisplay!.texture = nil
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
                            statLabel!.text = itemToMove!.statString()
                            if self.childNodeWithName("priceButton") != nil{
                                self.childNodeWithName("priceButton")?.removeFromParent()
                            }
                            let sellNode = SKLabelNode.init(text: "Sell: \(round(itemToMove!.price! / 10))")
                            sellNode.position = CGPointMake(self.frame.midX, self.frame.maxY - 400)
                            sellNode.fontSize = 30
                            sellNode.name = "sellButton"
                            sellNode.fontColor = UIColor.blueColor()
                            self.addChild(sellNode)
                        }else{
                            statLabel!.text = ""
                            self.childNodeWithName("sellButton")?.removeFromParent()
                        }
                    }//else{
                        //space.wasClicked = false
                   // }
                }
            }
        }
    }
}