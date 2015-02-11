//
//  Inventory.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 2/9/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class Inventory: SKScene {
    var menu: SKLabelNode?
    var backPack: SKSpriteNode?
    var itemSpaces: [ItemSpaceNode] = []
    var items: [ItemClass] = []
    var itemToMove: ItemClass?
    var spaceToMove: ItemSpaceNode?
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = UIColor.grayColor()
        menu = SKLabelNode.init(text: "Main Menu")
        menu!.position = CGPointMake(self.frame.maxX - 70, self.frame.minY + 40)
        menu!.name = "menu"
        menu!.setScale(0.7)
        self.addChild(menu!)
        backPack = SKSpriteNode(color: UIColor.brownColor(), size: CGSizeMake(260,260))
        backPack!.position = CGPointMake(self.frame.midX, self.frame.midY - 50)
        backPack!.name = "backpack"
        self.addChild(backPack!)
        let bodyLabel = SKLabelNode.init(text: "Body")
        bodyLabel.position = CGPointMake(self.frame.midX, self.frame.midY + 200)
        self.addChild(bodyLabel)
        let weaponLabel = SKLabelNode.init(text: "Weapon")
        weaponLabel.position = CGPointMake(self.frame.midX + 120, self.frame.midY + 200)
        self.addChild(weaponLabel)
        let feetLabel = SKLabelNode.init(text: "Feet")
        feetLabel.position = CGPointMake(self.frame.midX - 120, self.frame.midY + 200)
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
        let weaponSpace = ItemSpaceNode.spaceAtPosition(CGPointMake(weaponLabel.frame.midX, weaponLabel.frame.midY - 60))
        weaponSpace.zPosition = 1
        self.addChild(weaponSpace)
        let bodySpace = ItemSpaceNode.spaceAtPosition(CGPointMake(bodyLabel.frame.midX, bodyLabel.frame.midY - 60))
        bodySpace.zPosition = 1
        self.addChild(bodySpace)
        let feetSpace = ItemSpaceNode.spaceAtPosition(CGPointMake(feetLabel.frame.midX, feetLabel.frame.midY - 60))
        feetSpace.zPosition = 1
        self.addChild(feetSpace)
        
        self.populateBags()
        
    }
    
    func addItem(itemName: String){
        println("adding item to items array")
        items.append(ItemClass.itemInSpace(itemName))
    }
    
    //put the items into itemSpaces
    func populateBags(){
        println("populating bags")
        var count = 0
        for space in itemSpaces{
            space.item = nil
        }
        for item in items{
            var placed = false
            for space in itemSpaces{
                if space.item == nil && placed == false{
                    println("inserting an item into spot")
                    space.insertItem(item)
                    placed = true
                }
            }
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
                self.view?.presentScene(self.userData?.objectForKey("menu") as MainMenuScene, transition: skTransition)
            }else{
                for space in itemSpaces{
                    if space.containsPoint(touch.locationInNode(self)){
                        //clicked on space with item in it
                        if space.item != nil{
                            if self.itemToMove == nil{
                                self.itemToMove = space.item
                                self.spaceToMove = space
                            }//already an item to move, swap
                            else{
                                self.spaceToMove!.insertItem(space.item!)
                                space.insertItem(self.itemToMove!)
                                //performed swap of items, clean up
                                self.itemToMove = nil
                                self.spaceToMove = nil
                                
                            }
                        }//clicked on space with no item in it
                        else{
                            //add item to new space if have item to move
                            if self.itemToMove != nil{
                                space.insertItem(self.itemToMove!)
                                //change position of item in array
                            }
                            //no item in this space so clean up
                            self.itemToMove = nil
                            self.spaceToMove = nil
                        }
                        //space.wasClicked = true
                        //self.itemToMove = space.item
                    }//else{
                        //space.wasClicked = false
                   // }
                }
            }
        }
    }
}