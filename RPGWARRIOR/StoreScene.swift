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
    var backPackSpaces = 16
    var goldNode: SKLabelNode?
    var statLabel: SKLabelNode?
    var currentItem: ItemClass?
    var goldCount: CGFloat = 0
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
       //add menu option node here
        self.backgroundColor = UIColor.grayColor()
        let background = SKSpriteNode(imageNamed: "Store_2.png")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -1
        self.addChild(background)
        //add shelves
        let shelf1 = SKSpriteNode(imageNamed: "Store_Shelf_1.png")
        shelf1.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 170)
        shelf1.setScale(0.35)
        self.addChild(shelf1)
        let shelf2 = SKSpriteNode(imageNamed: "Store_Shelf_1.png")
        shelf2.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 310)
        shelf2.setScale(0.35)
        self.addChild(shelf2)
        let shelf3 = SKSpriteNode(imageNamed: "Store_Shelf_1.png")
        shelf3.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 450)
        shelf3.setScale(0.35)
        self.addChild(shelf3)
        let storeTextNode = SKSpriteNode(imageNamed: "Store_Text_1")
        storeTextNode.position = CGPointMake(self.frame.midX, self.frame.maxY - 53)
        storeTextNode.size = CGSizeMake(150, 40)
        self.addChild(storeTextNode)
        //shelf1.zPosition = -1
        //stats label
        statLabel = SKLabelNode.init(text: "")
        statLabel!.position = CGPointMake(self.frame.midX, self.frame.minY + 60)
        statLabel!.fontColor = UIColor.blueColor()
        statLabel!.name = "stats"
        statLabel!.setScale(0.7)
        self.addChild(statLabel!)
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
        goldNode!.position = CGPointMake(self.frame.minX + 70, self.frame.minY + 40)
        goldNode!.fontColor = UIColor.redColor()
        self.addChild(goldNode!)
        addItems()
    }
    
    func addItems(){
        //generate points
        var startX = self.frame.minX + 50
        var startY = self.frame.maxY - 160
        var counter = 1
        for itemName in allStoreItems{
            let item = ItemClass.itemInSpace(itemName)
            item.position = CGPointMake(startX, startY)
            item.size = CGSizeMake(40, 40)
            item.name = "item\(counter)"
            counter += 1
            self.addChild(item)
            if self.frame.maxX - startX < 60{
                startY -= 140
                startX = self.frame.minX + 40
            }else{
                startX += 40
            }
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
            }else if clickedItem((touch as! UITouch).locationInNode(self)) != ""{
                if currentItem != nil{
                    currentItem!.removeFromParent()
                }
                currentItem = ItemClass.itemInSpace(clickedItem((touch as! UITouch).locationInNode(self)))
                currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 135)
                currentItem!.size = CGSizeMake(100, 100)
                resizeLabel(statLabel!)
                statLabel!.text = currentItem!.statString()
                self.addChild(currentItem!)
            }else if self.childNodeWithName("buyButton") != nil && self.childNodeWithName("buyButton")!.containsPoint((touch as! UITouch).locationInNode(self)){
                buyItem()
            }
        }
        //an item is being highlighted
        if currentItem != nil && self.childNodeWithName("buyButton") == nil{
            let buyNode = SKLabelNode.init(text: "Buy Item")
            buyNode.position = CGPointMake(self.frame.midX + 110, self.frame.minY + 150)
            buyNode.fontColor = UIColor.blueColor()
            buyNode.name = "buyButton"
            self.addChild(buyNode)
        }
        if currentItem != nil{
            if self.childNodeWithName("priceButton") != nil{
                self.childNodeWithName("priceButton")?.removeFromParent()
            }
            let priceNode = SKLabelNode.init(text: "Price: \(Int(currentItem!.price!))")
            priceNode.position = CGPointMake(self.frame.midX + 110, self.frame.minY + 90)
            priceNode.fontSize = 16
            priceNode.name = "priceButton"
            priceNode.fontColor = UIColor.redColor()
            self.addChild(priceNode)
        }
    }
}