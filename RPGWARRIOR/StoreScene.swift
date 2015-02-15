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
    var menu: SKLabelNode?
    var inv: SKLabelNode?
    var itemSpaces: [ItemSpaceNode] = []
    var items: [ItemClass] = []
    var itemToMove: ItemClass?
    var spaceToMove: ItemSpaceNode?
    var firstLoad = true
    var backPackSpaces = 16
    var goldNode: SKLabelNode?
    var statLabel: SKLabelNode?
    var currentItem: SKSpriteNode?
    var goldCount = 0
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
       //add menu option node here
        self.backgroundColor = UIColor.grayColor()
        statLabel = SKLabelNode.init(text: "")
        statLabel!.position = CGPointMake(self.frame.midX, self.frame.minY + 75)
        statLabel!.name = "stats"
        statLabel!.setScale(0.7)
        self.addChild(statLabel!)
        menu = SKLabelNode.init(text: "Main Menu")
        menu!.position = CGPointMake(self.frame.maxX - 70, self.frame.minY + 40)
        menu!.name = "menu"
        menu!.setScale(0.7)
        self.addChild(menu!)
        inv = SKLabelNode.init(text: "Inventory")
        inv!.position = CGPointMake(self.frame.midX, self.frame.minY + 40)
        inv!.name = "inventory"
        inv!.setScale(0.7)
        self.addChild(inv!)
        //gold node
        goldCount = (self.userData?.objectForKey("inventory") as Inventory).gold
        goldNode = SKLabelNode.init(text: "\(goldCount)")
        goldNode!.position = CGPointMake(self.frame.minX + 70, self.frame.minY + 40)
        goldNode!.fontColor = UIColor.yellowColor()
        self.addChild(goldNode!)
        addItems()
    }
    
    func addItems(){
        //generate points
        var startX = self.frame.minX + 40
        var startY = self.frame.maxY - 40
        var counter = 1
        for itemName in allStoreItems{
            let item = ItemClass.itemInSpace(itemName)
            item.position = CGPointMake(startX, startY)
            item.size = CGSizeMake(40, 40)
            item.name = "item\(counter)"
            counter += 1
            self.addChild(item)
            if self.frame.maxX - startX < 60{
                startY -= 60
                startX = self.frame.minX + 40
            }else{
                startX += 40
            }
        }
        
    }
    func clickedItem(point: CGPoint) -> String{
        for var x = 1; x < allStoreItems.count+1; x+=1{
            let anItem = self.childNodeWithName("item\(x)") as ItemClass
            if anItem.containsPoint(point){
                return anItem.itemName!
            }
        }
        return ""
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches{
            if menu!.containsPoint(touch.locationInNode(self)){
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(self.userData?.objectForKey("menu") as MainMenuScene, transition: skTransition)
            }else if inv!.containsPoint(touch.locationInNode(self)){
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(self.userData?.objectForKey("inventory") as Inventory, transition: skTransition)
            }else if clickedItem(touch.locationInNode(self)) != ""{
                if currentItem != nil{
                    currentItem!.removeFromParent()
                }
                currentItem = ItemClass.itemInSpace(clickedItem(touch.locationInNode(self)))
                currentItem!.position = CGPointMake(self.frame.midX, self.frame.minY + 150)
                currentItem!.size = CGSizeMake(100, 100)
                resizeLabel(statLabel!)
                statLabel!.text = (currentItem as ItemClass).statString()
                self.addChild(currentItem!)
            }else{
                currentItem?.removeFromParent()
                currentItem = nil
                statLabel!.text = ""
            }
        }
    }
}