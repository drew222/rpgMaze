//
//  Inventory.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 2/9/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit
import Foundation
import AVFoundation

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
    var gold: CGFloat = 0
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
    
    var persistentData: UserDefaults?
    
    class func createInventory(size: CGSize) -> Inventory {
        let inv = Inventory()
        inv.size = size
        inv.backgroundColor = UIColor.gray
        inv.menu = SKSpriteNode(imageNamed: "Zones__Button_1")
        inv.menu!.position = CGPointMake(inv.frame.minX + 55, inv.frame.maxY - 55)
        inv.menu!.zPosition = 4
        inv.menu!.name = "menu"
        inv.menu!.size = CGSizeMake(100, 100)
        if is5{
            inv.menu!.position = CGPointMake(inv.frame.minX + 45, inv.frame.maxY - 45)
            inv.menu!.size = CGSizeMake(80, 80)
        } else if isPad{
            inv.menu!.position = CGPointMake(inv.frame.minX + 40, inv.frame.maxY - 40)
            inv.menu!.size = CGSizeMake(70, 70)
        }
        inv.addChild(inv.menu!)
        let krakenNode = SKSpriteNode(imageNamed: "Fitting_Room_Kraken_1")
        krakenNode.position = CGPointMake(inv.frame.midX, inv.frame.maxY - 230)
        krakenNode.name = "kraken"
        krakenNode.size = CGSizeMake(250, 250)
        inv.addChild(krakenNode)
        //napsack text
        if is5{
            let napsackText = SKSpriteNode(imageNamed: "Napsack_Text_1")
            napsackText.position = CGPointMake(inv.frame.midX, inv.frame.minY + 20)
            napsackText.zPosition = 2
            napsackText.setScale(0.45)
            inv.addChild(napsackText)
        } else if isPad{
        } else {
            let napsackText = SKSpriteNode(imageNamed: "Napsack_Text_1")
            napsackText.position = CGPointMake(inv.frame.midX, inv.frame.minY + 213)
            napsackText.zPosition = 2
            napsackText.setScale(0.45)
            inv.addChild(napsackText)
        }
        
        //overall stats
        let Totaltext = SKSpriteNode(imageNamed: "Total_Stats_Text_1")
        Totaltext.position = CGPointMake(inv.frame.minX + 40, inv.frame.maxY - 123)
        Totaltext.zPosition = 2
        Totaltext.setScale(0.3)
        inv.addChild(Totaltext)
        
        let lifeSymbol = SKSpriteNode(imageNamed: "Life_Symbol_1")
        lifeSymbol.position = CGPointMake(inv.frame.minX + 25, inv.frame.maxY - 155)
        lifeSymbol.zPosition = 2
        lifeSymbol.setScale(0.2)
        inv.addChild(lifeSymbol)
        let speedSymbol = SKSpriteNode(imageNamed: "Speed_Symbol_1")
        speedSymbol.position = CGPointMake(inv.frame.minX + 25, inv.frame.maxY - 195)
        speedSymbol.zPosition = 2
        speedSymbol.setScale(0.2)
        inv.addChild(speedSymbol)
        let regenerationSymbol = SKSpriteNode(imageNamed: "Regeneration_Symbol_1")
        regenerationSymbol.position = CGPointMake(inv.frame.minX + 25, inv.frame.maxY - 235)
        regenerationSymbol.zPosition = 2
        regenerationSymbol.setScale(0.2)
        inv.addChild(regenerationSymbol)
        inv.headDisplay = SKSpriteNode(imageNamed: "")
        inv.headDisplay!.texture = nil
        inv.headDisplay!.size = CGSizeMake(135, 80)
        inv.headDisplay!.position = CGPointMake(krakenNode.position.x - 10, krakenNode.position.y + 75)
        inv.headDisplay!.zPosition = 10
        inv.addChild(inv.headDisplay!)
        inv.leftDisplay = SKSpriteNode(imageNamed: "")
        inv.leftDisplay!.texture = nil
        inv.leftDisplay!.size = CGSizeMake(40, 40)
        inv.leftDisplay!.zRotation = -pi/3
        inv.leftDisplay!.position = CGPointMake(krakenNode.position.x - 65, krakenNode.position.y - 40)
        inv.leftDisplay!.zPosition = 10
        inv.addChild(inv.leftDisplay!)
        inv.rightDisplay = SKSpriteNode(imageNamed: "")
        inv.rightDisplay!.size = CGSizeMake(40, 40)
        inv.rightDisplay!.zRotation = pi/2
        inv.rightDisplay!.texture = nil
        inv.rightDisplay!.position = CGPointMake(krakenNode.position.x + 65, krakenNode.position.y - 28)
        inv.rightDisplay!.zPosition = 10
        inv.addChild(inv.rightDisplay!)
        inv.neckDisplay = SKSpriteNode(imageNamed: "")
        inv.neckDisplay!.size = CGSizeMake(110, 45)
        //neckDisplay!.zRotation = pi/3
        inv.neckDisplay!.texture = nil
        inv.neckDisplay!.position = CGPointMake(krakenNode.position.x, krakenNode.position.y - 25)
        inv.neckDisplay!.zPosition = 10
        inv.addChild(inv.neckDisplay!)
        inv.store = SKSpriteNode(imageNamed: "Store_Button_1")
        inv.store!.position = CGPointMake(inv.frame.maxX - 55, inv.frame.maxY - 55)
        inv.store!.zPosition = 10
        inv.store!.name = "store"
        inv.store!.size = CGSizeMake(100, 100)
        if is5{
            inv.store!.position = CGPointMake(inv.frame.maxX - 45, inv.frame.maxY - 45)
            inv.store!.size = CGSizeMake(80, 80)
        } else if isPad{
            inv.store!.position = CGPointMake(inv.frame.maxX - 40, inv.frame.maxY - 40)
            inv.store!.size = CGSizeMake(70, 70)
        }
        inv.addChild(inv.store!)
        let storeText = SKSpriteNode(imageNamed: "Fitting_Room_Text_1")
        storeText.position = CGPointMake(inv.frame.midX, inv.frame.maxY - 50)
        storeText.name = "store"
        storeText.zPosition = 10
        storeText.size = CGSizeMake(165, 60)
        if is5{
            storeText.position = CGPointMake(inv.frame.midX, inv.frame.maxY - 50)
            storeText.size = CGSizeMake(140, 55)
        } else if isPad{
            storeText.position = CGPointMake(inv.frame.midX, inv.frame.maxY - 50)
            storeText.size = CGSizeMake(165, 60)
        }
        inv.addChild(storeText)
        inv.backPack = SKSpriteNode(imageNamed: "Inventory_Array_Background_1")
        inv.backPack!.position = CGPointMake(inv.frame.midX, inv.frame.minY + 115)
        inv.backPack!.size = CGSizeMake(325,195)
        if isPad{
            inv.backPack!.position = CGPointMake(inv.frame.midX, inv.frame.minY + 65)
            inv.backPack!.size = CGSizeMake(310,131)
        }
        inv.backPack!.name = "backpack"
        inv.addChild(inv.backPack!)
        
        
        if isPlus{
            inv.statLabelLife = SKLabelNode.init(text: "")
            inv.statLabelLife!.position = CGPointMake(inv.frame.midX - 30, inv.frame.midY - 83)
            inv.statLabelLife!.fontName = "ChalkboardSE-Bold"
            inv.statLabelLife!.fontSize = 22
            inv.statLabelLife!.fontColor = UIColor.black
            inv.statLabelLife!.name = "lifeStat"
            inv.statLabelLife!.setScale(0.7)
            inv.addChild(inv.statLabelLife!)
            inv.statLabelMovement = SKLabelNode.init(text: "")
            inv.statLabelMovement!.position = CGPointMake(inv.frame.midX + 25, inv.frame.midY - 83)
            inv.statLabelMovement!.fontName = "ChalkboardSE-Bold"
            inv.statLabelMovement!.fontSize = 22
            inv.statLabelMovement!.fontColor = UIColor.black
            inv.statLabelMovement!.name = "movementStat"
            inv.statLabelMovement!.setScale(0.7)
            inv.addChild(inv.statLabelMovement!)
            inv.statLabelRegen = SKLabelNode.init(text: "")
            inv.statLabelRegen!.position = CGPointMake(inv.frame.midX + 75, inv.frame.midY - 83)
            inv.statLabelRegen!.fontName = "ChalkboardSE-Bold"
            inv.statLabelRegen!.fontSize = 22
            inv.statLabelRegen!.fontColor = UIColor.black
            inv.statLabelRegen!.name = "regenStat"
            inv.statLabelRegen!.setScale(0.7)
            inv.addChild(inv.statLabelRegen!)
        } else if isPad{
            inv.statLabelLife = SKLabelNode.init(text: "")
            inv.statLabelLife!.position = CGPointMake(inv.frame.midX - 30, inv.frame.minY + 158)
            inv.statLabelLife!.fontName = "ChalkboardSE-Bold"
            inv.statLabelLife!.fontSize = 22
            inv.statLabelLife!.fontColor = UIColor.black
            inv.statLabelLife!.name = "lifeStat"
            inv.statLabelLife!.setScale(0.7)
            inv.statLabelLife!.zPosition = 10
            inv.addChild(inv.statLabelLife!)
            inv.statLabelMovement = SKLabelNode.init(text: "")
            inv.statLabelMovement!.position = CGPointMake(inv.frame.midX + 25, inv.frame.minY + 158)
            inv.statLabelMovement!.fontName = "ChalkboardSE-Bold"
            inv.statLabelMovement!.fontSize = 22
            inv.statLabelMovement!.fontColor = UIColor.black
            inv.statLabelMovement!.name = "movementStat"
            inv.statLabelMovement!.setScale(0.7)
            inv.statLabelMovement!.zPosition = 10
            inv.addChild(inv.statLabelMovement!)
            inv.statLabelRegen = SKLabelNode.init(text: "")
            inv.statLabelRegen!.position = CGPointMake(inv.frame.midX + 75, inv.frame.minY + 158)
            inv.statLabelRegen!.fontName = "ChalkboardSE-Bold"
            inv.statLabelRegen!.fontSize = 22
            inv.statLabelRegen!.fontColor = UIColor.black
            inv.statLabelRegen!.name = "regenStat"
            inv.statLabelRegen!.setScale(0.7)
            inv.statLabelRegen!.zPosition = 10
            inv.addChild(inv.statLabelRegen!)
        } else {
        inv.statLabelLife = SKLabelNode.init(text: "")
        inv.statLabelLife!.position = CGPointMake(inv.frame.midX - 30, inv.frame.minY + 253)
        inv.statLabelLife!.fontName = "ChalkboardSE-Bold"
        inv.statLabelLife!.fontSize = 22
            inv.statLabelLife!.fontColor = UIColor.black
        inv.statLabelLife!.name = "lifeStat"
        inv.statLabelLife!.setScale(0.7)
        inv.statLabelLife!.zPosition = 10
        inv.addChild(inv.statLabelLife!)
        inv.statLabelMovement = SKLabelNode.init(text: "")
        inv.statLabelMovement!.position = CGPointMake(inv.frame.midX + 25, inv.frame.minY + 253)
        inv.statLabelMovement!.fontName = "ChalkboardSE-Bold"
        inv.statLabelMovement!.fontSize = 22
            inv.statLabelMovement!.fontColor = UIColor.black
        inv.statLabelMovement!.name = "movementStat"
        inv.statLabelMovement!.setScale(0.7)
        inv.statLabelMovement!.zPosition = 10
        inv.addChild(inv.statLabelMovement!)
        inv.statLabelRegen = SKLabelNode.init(text: "")
        inv.statLabelRegen!.position = CGPointMake(inv.frame.midX + 75, inv.frame.minY + 253)
        inv.statLabelRegen!.fontName = "ChalkboardSE-Bold"
        inv.statLabelRegen!.fontSize = 22
            inv.statLabelRegen!.fontColor = UIColor.black
        inv.statLabelRegen!.name = "regenStat"
        inv.statLabelRegen!.setScale(0.7)
        inv.statLabelRegen!.zPosition = 10
        inv.addChild(inv.statLabelRegen!)
        }
        
        if isPlus{
            inv.lifeSymbol2 = SKSpriteNode(imageNamed: "Life_Symbol_1")
            inv.lifeSymbol2!.position = CGPointMake(inv.frame.midX - 55, inv.frame.midY - 75)
            inv.lifeSymbol2!.zPosition = 2
            inv.lifeSymbol2!.setScale(0.15)
            
            inv.speedSymbol2 = SKSpriteNode(imageNamed: "Speed_Symbol_1")
            inv.speedSymbol2!.position = CGPointMake(inv.frame.midX, inv.frame.midY - 75)
            inv.speedSymbol2!.zPosition = 2
            inv.speedSymbol2!.setScale(0.15)
            
            inv.regenerationSymbol2 = SKSpriteNode(imageNamed: "Regeneration_Symbol_1")
            inv.regenerationSymbol2!.position = CGPointMake(inv.frame.midX + 55, inv.frame.midY - 75)
            inv.regenerationSymbol2!.zPosition = 2
            inv.regenerationSymbol2!.setScale(0.15)
        } else if isPad{
            inv.lifeSymbol2 = SKSpriteNode(imageNamed: "Life_Symbol_1")
            inv.lifeSymbol2!.position = CGPointMake(inv.frame.midX - 55, inv.frame.minY + 165)
            inv.lifeSymbol2!.zPosition = 10
            inv.lifeSymbol2!.setScale(0.15)
            
            inv.speedSymbol2 = SKSpriteNode(imageNamed: "Speed_Symbol_1")
            inv.speedSymbol2!.position = CGPointMake(inv.frame.midX, inv.frame.minY + 165)
            inv.speedSymbol2!.zPosition = 10
            inv.speedSymbol2!.setScale(0.15)
            
            inv.regenerationSymbol2 = SKSpriteNode(imageNamed: "Regeneration_Symbol_1")
            inv.regenerationSymbol2!.position = CGPointMake(inv.frame.midX + 55, inv.frame.minY + 165)
            inv.regenerationSymbol2!.zPosition = 10
            inv.regenerationSymbol2!.setScale(0.15)

        } else {
        
        inv.lifeSymbol2 = SKSpriteNode(imageNamed: "Life_Symbol_1")
        inv.lifeSymbol2!.position = CGPointMake(inv.frame.midX - 55, inv.frame.minY + 260)
        inv.lifeSymbol2!.zPosition = 10
        inv.lifeSymbol2!.setScale(0.15)
        
        inv.speedSymbol2 = SKSpriteNode(imageNamed: "Speed_Symbol_1")
        inv.speedSymbol2!.position = CGPointMake(inv.frame.midX, inv.frame.minY + 260)
        inv.speedSymbol2!.zPosition = 10
        inv.speedSymbol2!.setScale(0.15)
        
        inv.regenerationSymbol2 = SKSpriteNode(imageNamed: "Regeneration_Symbol_1")
        inv.regenerationSymbol2!.position = CGPointMake(inv.frame.midX + 55, inv.frame.minY + 260)
        inv.regenerationSymbol2!.zPosition = 10
        inv.regenerationSymbol2!.setScale(0.15)
        }
        
        inv.statLabelLife2 = SKLabelNode.init(text: "0")
        inv.statLabelLife2!.position = CGPointMake(inv.frame.minX + 60, inv.frame.maxY - 165)
        inv.statLabelLife2!.fontName = "ChalkboardSE-Bold"
        inv.statLabelLife2!.fontSize = 25
        inv.statLabelLife2!.fontColor = UIColor.black
        inv.statLabelLife2!.zPosition = 10
        inv.statLabelLife2!.name = "lifeStat"
        inv.addChild(inv.statLabelLife2!)
        inv.statLabelMovement2 = SKLabelNode.init(text: "0")
        inv.statLabelMovement2!.position = CGPointMake(inv.frame.minX + 60, inv.frame.maxY - 205)
        inv.statLabelMovement2!.fontName = "ChalkboardSE-Bold"
        inv.statLabelMovement2!.fontSize = 25
        inv.statLabelMovement2!.fontColor = UIColor.black
        inv.statLabelMovement2!.zPosition = 10
        inv.statLabelMovement2!.name = "movementStat"
        inv.addChild(inv.statLabelMovement2!)
        inv.statLabelRegen2 = SKLabelNode.init(text: "0")
        inv.statLabelRegen2!.position = CGPointMake(inv.frame.minX + 60, inv.frame.maxY - 245)
        inv.statLabelRegen2!.fontName = "ChalkboardSE-Bold"
        inv.statLabelRegen2!.fontSize = 25
        inv.statLabelRegen2!.fontColor = UIColor.black
        inv.statLabelRegen2!.zPosition = 10
        inv.statLabelRegen2!.name = "regenStat"
        inv.addChild(inv.statLabelRegen2!)
        
        let weaponLabel = SKSpriteNode(imageNamed: "Noggin_Text_1")
        weaponLabel.setScale(0.35)
        weaponLabel.zPosition = 10
        weaponLabel.position = CGPointMake(inv.frame.maxX - 40, inv.frame.maxY - 120)
        inv.addChild(weaponLabel)
        let neckLabel = SKSpriteNode(imageNamed: "Neck_Text_1")
        neckLabel.setScale(0.35)
        neckLabel.zPosition = 10
        neckLabel.position = CGPointMake(inv.frame.maxX - 40, inv.frame.maxY - 195)
        inv.addChild(neckLabel)
        let bodyLabel = SKSpriteNode(imageNamed: "Left_Text_1")
        bodyLabel.setScale(0.35)
        bodyLabel.zPosition = 10
        bodyLabel.position = CGPointMake(inv.frame.minX + 40, inv.frame.maxY - 275)
        inv.addChild(bodyLabel)
        let feetLabel = SKSpriteNode(imageNamed: "Right_Text_1")
        feetLabel.setScale(0.35)
        feetLabel.zPosition = 10
        feetLabel.position = CGPointMake(inv.frame.maxX - 40, inv.frame.maxY - 275)
        inv.addChild(feetLabel)
        
        
        //create all the item spaces
        if isPad{
            //row 1
            let itemSpace1 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 40, inv.backPack!.frame.maxY - 23))
            itemSpace1.setScale(1.0)
            itemSpace1.zPosition = 1
            itemSpace1.name = "1"
            inv.itemSpaces.append(itemSpace1)
            inv.addChild(itemSpace1)
            let itemSpace2 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 100, inv.backPack!.frame.maxY - 23))
            itemSpace2.setScale(1.0)
            itemSpace2.zPosition = 1
            itemSpace2.name = "2"
            inv.itemSpaces.append(itemSpace2)
            inv.addChild(itemSpace2)
            let itemSpace3 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 160, inv.backPack!.frame.maxY - 23))
            itemSpace3.setScale(1.0)
            itemSpace3.zPosition = 1
            itemSpace3.name = "3"
            inv.itemSpaces.append(itemSpace3)
            inv.addChild(itemSpace3)
            let itemSpace4 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 220, inv.backPack!.frame.maxY - 23))
            itemSpace4.setScale(1.0)
            itemSpace4.zPosition = 1
            itemSpace4.name = "4"
            inv.itemSpaces.append(itemSpace4)
            inv.addChild(itemSpace4)
            let itemSpace5 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 280, inv.backPack!.frame.maxY - 23))
            itemSpace5.setScale(1.0)
            itemSpace5.zPosition = 1
            itemSpace5.name = "5"
            inv.itemSpaces.append(itemSpace5)
            inv.addChild(itemSpace5)
            //row 2
            let itemSpace6 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 40, inv.backPack!.frame.maxY - 65))
            itemSpace6.setScale(1.0)
            itemSpace6.zPosition = 1
            itemSpace6.name = "6"
            inv.itemSpaces.append(itemSpace6)
            inv.addChild(itemSpace6)
            let itemSpace7 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 100, inv.backPack!.frame.maxY - 65))
            itemSpace7.setScale(1.0)
            itemSpace7.zPosition = 1
            itemSpace7.name = "7"
            inv.itemSpaces.append(itemSpace7)
            inv.addChild(itemSpace7)
            let itemSpace8 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 160, inv.backPack!.frame.maxY - 65))
            itemSpace8.setScale(1.0)
            itemSpace8.zPosition = 1
            itemSpace8.name = "8"
            inv.itemSpaces.append(itemSpace8)
            inv.addChild(itemSpace8)
            let itemSpace9 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 220, inv.backPack!.frame.maxY - 65))
            itemSpace9.zPosition = 1
            itemSpace9.setScale(1.0)
            itemSpace9.name = "9"
            inv.itemSpaces.append(itemSpace9)
            inv.addChild(itemSpace9)
            let itemSpace10 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 280, inv.backPack!.frame.maxY - 65))
            itemSpace10.zPosition = 1
            itemSpace10.setScale(1.0)
            itemSpace10.name = "10"
            inv.itemSpaces.append(itemSpace10)
            inv.addChild(itemSpace10)
            
            //row 3
            let itemSpace11 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 40, inv.backPack!.frame.maxY - 107))
            itemSpace11.setScale(1.0)
            itemSpace11.zPosition = 1
            itemSpace11.name = "11"
            inv.itemSpaces.append(itemSpace11)
            inv.addChild(itemSpace11)
            let itemSpace12 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 100, inv.backPack!.frame.maxY - 107))
            itemSpace12.setScale(1.0)
            itemSpace12.zPosition = 1
            itemSpace12.name = "12"
            inv.itemSpaces.append(itemSpace12)
            inv.addChild(itemSpace12)
            let itemSpace13 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 160, inv.backPack!.frame.maxY - 107))
            itemSpace13.setScale(1.0)
            itemSpace13.zPosition = 1
            itemSpace13.name = "13"
            inv.itemSpaces.append(itemSpace13)
            inv.addChild(itemSpace13)
            let itemSpace14 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 220, inv.backPack!.frame.maxY - 107))
            itemSpace14.setScale(1.0)
            itemSpace14.zPosition = 1
            itemSpace14.name = "14"
            inv.itemSpaces.append(itemSpace14)
            inv.addChild(itemSpace14)
            let itemSpace15 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 280, inv.backPack!.frame.maxY - 107))
            itemSpace15.setScale(1.0)
            itemSpace15.zPosition = 1
            itemSpace15.name = "15"
            inv.itemSpaces.append(itemSpace15)
            inv.addChild(itemSpace15)
 
        } else {
        //row 1
            let itemSpace1 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 40, inv.backPack!.frame.maxY - 40))
        itemSpace1.setScale(1.3)
        itemSpace1.zPosition = 1
        itemSpace1.name = "1"
        inv.itemSpaces.append(itemSpace1)
        inv.addChild(itemSpace1)
            let itemSpace2 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 100, inv.backPack!.frame.maxY - 40))
        itemSpace2.setScale(1.3)
        itemSpace2.zPosition = 1
        itemSpace2.name = "2"
        inv.itemSpaces.append(itemSpace2)
        inv.addChild(itemSpace2)
            let itemSpace3 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 160, inv.backPack!.frame.maxY - 40))
        itemSpace3.setScale(1.3)
        itemSpace3.zPosition = 1
        itemSpace3.name = "3"
        inv.itemSpaces.append(itemSpace3)
        inv.addChild(itemSpace3)
            let itemSpace4 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 220, inv.backPack!.frame.maxY - 40))
        itemSpace4.setScale(1.3)
        itemSpace4.zPosition = 1
        itemSpace4.name = "4"
        inv.itemSpaces.append(itemSpace4)
        inv.addChild(itemSpace4)
            let itemSpace5 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 280, inv.backPack!.frame.maxY - 40))
        itemSpace5.setScale(1.3)
        itemSpace5.zPosition = 1
        itemSpace5.name = "5"
        inv.itemSpaces.append(itemSpace5)
        inv.addChild(itemSpace5)
        //row 2
            let itemSpace6 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 40, inv.backPack!.frame.maxY - 100))
        itemSpace6.setScale(1.3)
        itemSpace6.zPosition = 1
        itemSpace6.name = "6"
        inv.itemSpaces.append(itemSpace6)
        inv.addChild(itemSpace6)
            let itemSpace7 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 100, inv.backPack!.frame.maxY - 100))
        itemSpace7.setScale(1.3)
        itemSpace7.zPosition = 1
        itemSpace7.name = "7"
        inv.itemSpaces.append(itemSpace7)
        inv.addChild(itemSpace7)
            let itemSpace8 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 160, inv.backPack!.frame.maxY - 100))
        itemSpace8.setScale(1.3)
        itemSpace8.zPosition = 1
        itemSpace8.name = "8"
        inv.itemSpaces.append(itemSpace8)
        inv.addChild(itemSpace8)
            let itemSpace9 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 220, inv.backPack!.frame.maxY - 100))
        itemSpace9.zPosition = 1
        itemSpace9.setScale(1.3)
        itemSpace9.name = "9"
        inv.itemSpaces.append(itemSpace9)
        inv.addChild(itemSpace9)
            let itemSpace10 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 280, inv.backPack!.frame.maxY - 100))
        itemSpace10.zPosition = 1
        itemSpace10.setScale(1.3)
        itemSpace10.name = "10"
        inv.itemSpaces.append(itemSpace10)
        inv.addChild(itemSpace10)
        
        //row 3
            let itemSpace11 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 40, inv.backPack!.frame.maxY - 160))
        itemSpace11.setScale(1.3)
        itemSpace11.zPosition = 1
        itemSpace11.name = "11"
        inv.itemSpaces.append(itemSpace11)
        inv.addChild(itemSpace11)
            let itemSpace12 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 100, inv.backPack!.frame.maxY - 160))
        itemSpace12.setScale(1.3)
        itemSpace12.zPosition = 1
        itemSpace12.name = "12"
        inv.itemSpaces.append(itemSpace12)
        inv.addChild(itemSpace12)
            let itemSpace13 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 160, inv.backPack!.frame.maxY - 160))
        itemSpace13.setScale(1.3)
        itemSpace13.zPosition = 1
        itemSpace13.name = "13"
        inv.itemSpaces.append(itemSpace13)
        inv.addChild(itemSpace13)
            let itemSpace14 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 220, inv.backPack!.frame.maxY - 160))
        itemSpace14.setScale(1.3)
        itemSpace14.zPosition = 1
        itemSpace14.name = "14"
        inv.itemSpaces.append(itemSpace14)
        inv.addChild(itemSpace14)
            let itemSpace15 = ItemSpaceNode.spaceAtPosition(position: CGPointMake(inv.backPack!.frame.minX + 280, inv.backPack!.frame.maxY - 160))
        itemSpace15.setScale(1.3)
        itemSpace15.zPosition = 1
        itemSpace15.name = "15"
        inv.itemSpaces.append(itemSpace15)
        inv.addChild(itemSpace15)
    }
    
        //weaponspace holds noggin items
        let weaponSpace = ItemSpaceNode.spaceAtPosition(position: CGPointMake(weaponLabel.frame.midX, weaponLabel.frame.midY - 40))
        weaponSpace.zPosition = 1
        weaponSpace.name = "weapon"
        inv.addChild(weaponSpace)
        inv.itemSpaces.append(weaponSpace)
        let neckSpace = ItemSpaceNode.spaceAtPosition(position: CGPointMake(neckLabel.frame.midX, neckLabel.frame.midY - 40))
        neckSpace.zPosition = 1
        neckSpace.name = "neck"
        inv.addChild(neckSpace)
        inv.itemSpaces.append(neckSpace)
        //body and feet spaces are tentacles
        let bodySpace = ItemSpaceNode.spaceAtPosition(position: CGPointMake(bodyLabel.frame.midX, bodyLabel.frame.midY - 40))
        bodySpace.zPosition = 1
        bodySpace.name = "body"
        inv.addChild(bodySpace)
        inv.itemSpaces.append(bodySpace)
        let feetSpace = ItemSpaceNode.spaceAtPosition(position: CGPointMake(feetLabel.frame.midX, feetLabel.frame.midY - 40))
        feetSpace.zPosition = 1
        feetSpace.name = "feet"
        inv.addChild(feetSpace)
        inv.itemSpaces.append(feetSpace)
        
        
        //booty coin image
        let booty = SKSpriteNode(imageNamed: "Booty_1.png")
        booty.position = CGPointMake(inv.frame.maxX - 40, inv.frame.minY + 230)
        booty.setScale(0.08)
        if is5{
            booty.position = CGPointMake(inv.frame.maxX - 40, inv.frame.minY + 222)
            booty.setScale(0.06)
        } else if isPad{
            booty.position = CGPointMake(inv.frame.maxX - 15, inv.frame.minY + 138)
            booty.setScale(0.04)
        }
        inv.addChild(booty)
        //gold node
        inv.goldNode = SKLabelNode.init(text: "\(Int(inv.gold))")
        inv.goldNode!.fontName = "ChalkboardSE-Bold"
        inv.goldNode!.fontSize = 30
        inv.goldNode!.fontColor = UIColor.black
        inv.goldNode!.position = CGPointMake(inv.frame.maxX - 100, inv.frame.minY + 220)
        if is5{
            inv.goldNode!.fontSize = 23
            inv.goldNode!.position = CGPointMake(inv.frame.maxX - 85, inv.frame.minY + 215)
        } else if isPad{
            inv.goldNode!.fontSize = 17
            inv.goldNode!.position = CGPointMake(inv.frame.maxX - 43, inv.frame.minY + 131)
        }
        inv.addChild(inv.goldNode!)
        
        return inv
    }
    
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        persistentData = UserDefaults.standard
        
        
        if spaceToMove != nil{
            spaceToMove!.texture = SKTexture(imageNamed: "Inventory_Slot_1")
            spaceToMove = nil
            itemToMove = nil
            statLabelLife!.text = ""
            statLabelMovement!.text = ""
            statLabelRegen!.text = ""
            self.childNode(withName: "sellButton")?.removeFromParent()
        }
        
        
        updateStats()
        
        goldNode!.text = "\(Int(gold))"
        goldNode!.fontColor = UIColor.black
        
        self.populateBags()
        if spaceToMove != nil{
            spaceToMove!.color = UIColor.white
        }
        itemToMove = nil
        spaceToMove = nil
        self.firstLoad = false
        
    }
    
    func updateStats() {
        var life = 1
        var movement = 0
        var regen = 0
        let weaponSpace = self.childNode(withName: "weapon") as! ItemSpaceNode
        let bodySpace = self.childNode(withName: "body") as! ItemSpaceNode
        let neckSpace = self.childNode(withName: "neck") as! ItemSpaceNode
        let feetSpace = self.childNode(withName: "feet") as! ItemSpaceNode
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
        if backPackSpaces == 0 {
        }else{
            //&&DATA
            
            //get correct packSpace
            var packIndex = 1
            while (self.childNode(withName: "\(packIndex)") as? ItemSpaceNode != nil) {
                if (self.childNode(withName: "\(packIndex)") as! ItemSpaceNode).item != nil {
                    packIndex += 1
                }else {
                    break
                }
            }
            persistentData = UserDefaults.standard
            persistentData!.set(itemName, forKey: "packSpace\(packIndex)")
            //&&
            (self.childNode(withName: "\(packIndex)") as! ItemSpaceNode).insertItem(anItem: ItemClass.itemInSpace(nameOfTexture: itemName))
            //let anItem = ItemClass.itemInSpace(itemName)
            //anItem.size = CGSizeMake(37, 37)
            //items.append(anItem)
            backPackSpaces-=1
        }
    }
    
    //put the items into itemSpaces
    func populateBags(){
        var count = 0
        for item in items{
            var placed = false
            for space in itemSpaces{
                if space.item == nil && placed == false{
                    space.insertItem(anItem: item)
                    placed = true
                    items.remove(at:count)
                    count-=1
                }
            }
            count+=1
        }
    }
    
    func sellItem(){
        //sound
        if soundOn {
            self.run(bootySound)
        }
        gold += round(itemToMove!.price! / 5)
        //&&
        persistentData!.set(gold, forKey: "gold")
        //&&
        goldNode!.text = "\(Int(gold))"
        spaceToMove!.texture = SKTexture(imageNamed: "Inventory_Slot_1")
        spaceToMove!.item = nil
        itemToMove?.removeFromParent()
        spaceToMove!.color = UIColor.white
        self.childNode(withName: "sellButton")?.removeFromParent()
        if !(spaceToMove!.name == "weapon" || spaceToMove!.name == "body" || spaceToMove!.name == "feet" || spaceToMove!.name == "neck"){
            backPackSpaces+=1
            //&&
            persistentData!.set("", forKey: "packSpace\(spaceToMove!.name!)")
            //&&
        }else{
            if spaceToMove!.name == "weapon"{
                headDisplay!.texture = nil
                //&&
                persistentData!.set("", forKey: "headSpace")
                //&&
            }else if spaceToMove!.name == "body" {
                leftDisplay!.texture = nil
                //&&
                persistentData!.set("", forKey: "leftSpace")
                //&&
            }else if spaceToMove!.name == "feet"{
                rightDisplay!.texture = nil
                //&&
                persistentData!.set("", forKey: "rightSpace")
                //&&
            }else{
                neckDisplay!.texture = nil
                //&&
                persistentData!.set("", forKey: "neckSpace")
                //&&
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
        self.childNode(withName: "itemName")?.removeFromParent()
        self.childNode(withName: "priceButton")?.removeFromParent()
        self.childNode(withName: "sellBooty")?.removeFromParent()
        self.childNode(withName: "typeString")?.removeFromParent()
    }
    
    func displayItem(item: ItemClass, spot: String) {
        //NOGGIN
        if spot == "weapon"{
            var itemName = item.itemName!
            itemName = itemName.replacingOccurrences(of: "1", with: "2")
            //USE MIDX and MAXY FOR SPACING ON BOTH IPHONE 6 and PLUS PURPOSES
            if itemName == "Top_Hat_2" {
                itemName = "Top_Hat_1"
                headDisplay!.size = CGSizeMake(150, 150)
                headDisplay!.position = CGPointMake(self.frame.midX - 12, self.frame.maxY - 90)
                headDisplay!.zPosition = 2
            } else if itemName == "Sweatband_2" {
                headDisplay!.size = CGSizeMake(160, 160)
                headDisplay!.position = CGPointMake(self.frame.midX - 13, self.frame.maxY - 160)
                headDisplay!.zPosition = 2
            } else if itemName == "Visor_2" {
                headDisplay!.size = CGSizeMake(160, 160)
                headDisplay!.position = CGPointMake(self.frame.midX - 13, self.frame.maxY - 178)
                headDisplay!.zPosition = 5
            } else if itemName == "Sand_Bucket_2" {
                itemName = "Sand_Bucket_1"
                headDisplay!.size = CGSizeMake(150, 150)
                headDisplay!.zPosition = 2
                headDisplay!.position = CGPointMake(self.frame.midX - 10, self.frame.maxY - 85)
            } else if itemName == "Sunhat_2" {
                itemName = "Sunhat_1"
                headDisplay!.size = CGSizeMake(225, 225)
                headDisplay!.position = CGPointMake(self.frame.midX - 10, self.frame.maxY - 150)
                headDisplay!.zPosition = 3
            } else if itemName == "Shades_2" {
                headDisplay!.zPosition = 5
                headDisplay!.size = CGSizeMake(120, 80)
                headDisplay!.position = CGPointMake(self.frame.midX - 7, self.frame.maxY - 220)
            } else if itemName == "Monocle_2" {
                itemName = "Monocle_1"
                headDisplay!.size = CGSizeMake(96, 107)
                headDisplay!.position = CGPointMake(self.frame.midX - 41, self.frame.maxY - 246)
                headDisplay!.zPosition = 5
            } else if itemName == "Crab_Claw_Cap_2" {
                itemName = "Crab_Claw_Cap_1"
                headDisplay!.size = CGSizeMake(300, 200)
                headDisplay!.position = CGPointMake(self.frame.midX + 10, self.frame.maxY - 115)
                headDisplay!.zPosition = 2
            } else if itemName == "Coral_Crown_2" {
                itemName = "Coral_Crown_1"
                headDisplay!.size = CGSizeMake(180, 125)
                headDisplay!.position = CGPointMake(self.frame.midX - 15, self.frame.maxY - 110)
                headDisplay!.zPosition = 2
            } else if itemName == "Afro_Seaweed_2" {
                itemName = "Afro_Seaweed_1"
                headDisplay!.size = CGSizeMake(200, 200)
                headDisplay!.position = CGPointMake(self.frame.midX - 10, self.frame.maxY - 135)
                headDisplay!.zPosition = 2
            } else if itemName == "Wicked_2" {
                headDisplay!.size = CGSizeMake(170, 170)
                headDisplay!.position = CGPointMake(self.frame.midX, self.frame.maxY - 175)
                headDisplay!.zPosition = 5
            } else if itemName == "Sinister_2" {
                headDisplay!.size = CGSizeMake(170, 170)
                headDisplay!.position = CGPointMake(self.frame.midX, self.frame.maxY - 175)
                headDisplay!.zPosition = 5
            } else if itemName == "Insidious_2" {
                headDisplay!.size = CGSizeMake(170, 170)
                headDisplay!.position = CGPointMake(self.frame.midX, self.frame.maxY - 175)
                headDisplay!.zPosition = 5
            } else if itemName == "Lust_Of_Lucifer_2" {
                headDisplay!.size = CGSizeMake(170, 170)
                headDisplay!.position = CGPointMake(self.frame.midX, self.frame.maxY - 175)
                headDisplay!.zPosition = 5
            }
            headDisplay!.texture = SKTexture(imageNamed: "\(itemName)")
            //LEFT
        }else if spot == "body" {
            var itemName = item.itemName!
            itemName = itemName.replacingOccurrences(of: "1", with: "2")
           if itemName == "Copper_Ring_2" {
                leftDisplay!.size = CGSizeMake(50, 50)
                leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
            } else if itemName == "Silver_Ring_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
            } else if itemName == "Gold_Ring_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
            } else if itemName == "Water_Wing_2" {
            leftDisplay!.size = CGSizeMake(80, 80)
            leftDisplay!.position = CGPointMake(self.frame.midX - 80, self.frame.maxY - 274)
            leftDisplay!.zPosition = 3
            } else if itemName == "Sweaty_Wristband_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
            }  else if itemName == "Bling_Ring_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
            }   else if itemName == "Watch_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
           } else if itemName == "Rusty_Copper_Ring_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
           } else if itemName == "Mossy_Copper_Ring_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
           } else if itemName == "Rusty_Silver_Ring_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
           } else if itemName == "Mossy_Silver_Ring_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
           } else if itemName == "Rusty_Gold_Ring_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
           } else if itemName == "Mossy_Gold_Ring_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
           } else if itemName == "Beach_Ball_Fragment_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
           } else if itemName == "Seashell_Charm_Bracelet_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
           } else if itemName == "Pearl_Snap_Ring_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
           } else if itemName == "Inky_Ring_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
           } else if itemName == "King_Kraken_Tentacle_Ring_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
           } else if itemName == "Whale_Flesh_Ring_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
           } else if itemName == "Dusk_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
           } else if itemName == "Nightfall_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
           } else if itemName == "Twilight_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
           } else if itemName == "Tomorrows_End_2" {
            leftDisplay!.size = CGSizeMake(50, 50)
            leftDisplay!.position = CGPointMake(self.frame.midX - 75, self.frame.maxY - 279)
            leftDisplay!.zPosition = 2
            }
            
            
            
            leftDisplay!.texture = SKTexture(imageNamed: "\(itemName)")
            //RIGHT
        }else if spot == "feet" {
            var itemName = item.itemName!
            itemName = itemName.replacingOccurrences(of: "1", with: "2")
            if itemName == "Copper_Ring_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Silver_Ring_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Gold_Ring_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Water_Wing_2" {
                rightDisplay!.size = CGSizeMake(80, 80)
                rightDisplay!.zPosition = 3
                rightDisplay!.position = CGPointMake(self.frame.midX + 72, self.frame.maxY - 257)
            } else if itemName == "Sweaty_Wristband_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            }  else if itemName == "Bling_Ring_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            }   else if itemName == "Watch_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Rusty_Copper_Ring_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Mossy_Copper_Ring_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Rusty_Silver_Ring_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Mossy_Silver_Ring_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Rusty_Gold_Ring_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Mossy_Gold_Ring_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Beach_Ball_Fragment_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Seashell_Charm_Bracelet_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Pearl_Snap_Ring_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Inky_Ring_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "King_Kraken_Tentacle_Ring_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Whale_Flesh_Ring_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Dusk_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Nightfall_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Twilight_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            } else if itemName == "Tomorrows_End_2" {
                rightDisplay!.size = CGSizeMake(50, 50)
                rightDisplay!.position = CGPointMake(self.frame.midX + 75, self.frame.maxY - 262)
                rightDisplay!.zPosition = 2
            }
            rightDisplay!.texture = SKTexture(imageNamed: "\(itemName)")
            //NECK
        }else {
            var itemName = item.itemName!
            itemName = itemName.replacingOccurrences(of: "1", with: "2")
            
            if itemName == "Bow_Tie_2" {
                itemName = "Bow_Tie_1"
                neckDisplay!.size = CGSizeMake(160, 100)
                neckDisplay!.position = CGPointMake(self.frame.midX - 5, self.frame.maxY - 270)
                neckDisplay!.zPosition = 6
            } else if itemName == "Whistle_2" {
                neckDisplay!.size = CGSizeMake(150,95)
                neckDisplay!.position = CGPointMake(self.frame.midX - 10, self.frame.maxY - 250)
                neckDisplay!.zPosition = 2
            } else if itemName == "Lifejacket_2" {
                neckDisplay!.size = CGSizeMake(203,120)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.maxY - 245)
                neckDisplay!.zPosition = 4
            } else if itemName == "Beach_Towel_2" {
                neckDisplay!.size = CGSizeMake(177,100)
                neckDisplay!.zPosition = 4
                neckDisplay!.position = CGPointMake(self.frame.midX - 13, self.frame.maxY - 250)
            } else if itemName == "Floatie_2" {
                neckDisplay!.size = CGSizeMake(180,140)
                neckDisplay!.position = CGPointMake(self.frame.midX + 12, self.frame.maxY - 227)
                neckDisplay!.zPosition = 4
            } else if itemName == "Sun_Screen_2" {
                neckDisplay!.size = CGSizeMake(250, 250)
                neckDisplay!.position = CGPointMake(self.frame.midX, self.frame.maxY - 230)
                neckDisplay!.zPosition = 1
            } else if itemName == "Pearl_Necklace_2" {
                neckDisplay!.size = CGSizeMake(154, 77)
                neckDisplay!.position = CGPointMake(self.frame.midX - 7, self.frame.maxY - 250)
                neckDisplay!.zPosition = 2
            } else if itemName == "Seashell_Necklace_2" {
                neckDisplay!.size = CGSizeMake(150, 75)
                neckDisplay!.position = CGPointMake(self.frame.midX - 8, self.frame.maxY - 249)
                neckDisplay!.zPosition = 2
            }else if itemName == "Seaweed_Mustache_2" {
                itemName = "Seaweed_Mustache_1"
                neckDisplay!.size = CGSizeMake(165, 120)
                neckDisplay!.position = CGPointMake(self.frame.midX - 7, self.frame.maxY - 257)
                neckDisplay!.zPosition = 4
            } else if itemName == "Barnacles_2" {
                itemName = "Barnacles_1"
                neckDisplay!.size = CGSizeMake(160, 80)
                neckDisplay!.position = CGPointMake(self.frame.midX - 7, self.frame.maxY - 255)
                neckDisplay!.zPosition = 3
            } else if itemName == "Fear_2" {
                neckDisplay!.size = CGSizeMake(160, 80)
                neckDisplay!.position = CGPointMake(self.frame.midX - 7, self.frame.maxY - 255)
                neckDisplay!.zPosition = 2
            } else if itemName == "Nightmare_2" {
                neckDisplay!.size = CGSizeMake(160, 80)
                neckDisplay!.position = CGPointMake(self.frame.midX - 7, self.frame.maxY - 255)
                neckDisplay!.zPosition = 2
            } else if itemName == "Insomnia_2" {
                neckDisplay!.size = CGSizeMake(160, 80)
                neckDisplay!.position = CGPointMake(self.frame.midX - 7, self.frame.maxY - 255)
                neckDisplay!.zPosition = 2
            } else if itemName == "The_Jitters_2" {
                neckDisplay!.size = CGSizeMake(160, 160)
                neckDisplay!.position = CGPointMake(self.frame.midX - 7, self.frame.maxY - 257)
                neckDisplay!.zPosition = 2
            }

            neckDisplay!.texture = SKTexture(imageNamed: "\(itemName)")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            if menu!.contains((touch).location(in: self)){
                if soundOn {
                    self.run(clickSound)
                }
                //do some cleanup on highlighted items
                itemToMove = nil
                statLabelLife!.text = ""
                statLabelMovement!.text = ""
                statLabelRegen!.text = ""
                lifeSymbol2?.removeFromParent()
                speedSymbol2?.removeFromParent()
                regenerationSymbol2?.removeFromParent()
                self.childNode(withName: "sellButton")?.removeFromParent()
                self.childNode(withName: "typeString")?.removeFromParent()
                self.childNode(withName: "itemName")?.removeFromParent()
                self.childNode(withName: "priceButton")?.removeFromParent()
                self.childNode(withName: "sellBooty")?.removeFromParent()
                //let menuScene = MainMenuScene(size: self.frame.size)
                //menuScene.userData?.setValue(self.userData?.objectForKey("inventory"), forKey: "inventory")
                (self.userData?.object(forKey: "menu") as! MainMenuScene).userData?.setObject(self, forKey: "inventory" as NSCopying)
                let skTransition = SKTransition.fade(withDuration: 1.0)
                //self.view?.presentScene(menuScene, transition: skTransition)
                self.view?.presentScene(self.userData?.object(forKey: "worldscene") as! ZoneScene, transition: skTransition)
            }else if store!.contains((touch).location(in: self)){
                if soundOn {
                    self.run(clickSound)
                }
                //do some cleanup on highlighted items
                itemToMove = nil
                statLabelLife!.text = ""
                statLabelMovement!.text = ""
                statLabelRegen!.text = ""
                lifeSymbol2?.removeFromParent()
                speedSymbol2?.removeFromParent()
                regenerationSymbol2?.removeFromParent()
                self.childNode(withName: "sellButton")?.removeFromParent()
                self.childNode(withName: "typeString")?.removeFromParent()
                self.childNode(withName: "itemName")?.removeFromParent()
                self.childNode(withName: "priceButton")?.removeFromParent()
                self.childNode(withName: "sellBooty")?.removeFromParent()
                let storeScene = StoreScene(size: self.frame.size)
                storeScene.userData = NSMutableDictionary()
                storeScene.userData?.setObject(self, forKey: "inventory" as NSCopying)
                //storeScene.userData?.setObject(self.userData?.objectForKey("menu") as MainMenuScene, forKey: "menu")
                storeScene.userData?.setObject(self.userData?.object(forKey: "worldscene") as! ZoneScene, forKey: "worldscene" as NSCopying)
                let skTransition = SKTransition.fade(withDuration: 1.0)
                //self.view?.presentScene(menuScene, transition: skTransition)
                self.view?.presentScene(storeScene, transition: skTransition)
            }else if self.childNode(withName: "sellButton") != nil && self.childNode(withName: "sellButton")!.contains((touch).location(in: self)){
                sellItem()
            }else{
                for space in itemSpaces{
                    if space.contains((touch).location(in: self)){
                        if spaceToMove != nil{
                            spaceToMove!.texture = SKTexture(imageNamed: "Inventory_Slot_1")
                        }
                        //clicked on space with item in it
                        if space.item != nil{
                            if soundOn {
                                self.run(clickSound)
                            }
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
                                    self.itemToMove = nil
                                    self.spaceToMove = nil
                                }else{
                                    if space.name == "weapon" || space.name == "body" || space.name == "feet" || space.name == "neck"{
                                        if space.name == "weapon" && itemToMove!.itemType == ItemType.weapon{
                                            //SWAPPING HEAD FOR HEAD HIGHLIGHTED = packspace
                                            //&&
                                            persistentData!.set("\(itemToMove!.itemName!)", forKey: "headSpace")
                                            //&&
                                            
                                            //&&
                                            //changed
                                            persistentData!.set("\(space.item!.itemName!)", forKey: "packSpace\(spaceToMove!.name!)")
                                            //&&
                                            
                                            self.spaceToMove!.insertItem(anItem: space.item!)
                                            space.insertItem(anItem: self.itemToMove!)
                                            displayItem(item: itemToMove!, spot: "weapon")
                                            if soundOn {
                                                self.run(itemSound)
                                            }
                                        }else if space.name == "body" && (itemToMove!.itemType == ItemType.body || itemToMove!.itemType == ItemType.feet){
                                            //SWAPPING LEFT FOR LEFT HIGHLIGHTED = packspace
                                            
                                            //&&
                                            persistentData!.set("\(itemToMove!.itemName!)", forKey: "leftSpace")
                                            //&&
                                            
                                            //&&
                                            //changed
                                            persistentData!.set("\(space.item!.itemName!)", forKey: "packSpace\(spaceToMove!.name!)")
                                            //&&
                                            
                                            self.spaceToMove!.insertItem(anItem: space.item!)
                                            space.insertItem(anItem: self.itemToMove!)
                                            displayItem(item: itemToMove!, spot: "body")
                                            if soundOn {
                                                self.run(itemSound)
                                            }
                                        }else if space.name == "feet" && (itemToMove!.itemType == ItemType.feet || itemToMove!.itemType == ItemType.body){
                                            //SWAPPING RIGHT FOR RIGHT HIGHLIGHTED = packspace
                                            
                                            //&&
                                            persistentData!.set("\(itemToMove!.itemName!)", forKey: "rightSpace")
                                            //&&
                                            
                                            //&&
                                            //changed
                                            persistentData!.set("\(space.item!.itemName!)", forKey: "packSpace\(spaceToMove!.name!)")
                                            //&&
                                            
                                            self.spaceToMove!.insertItem(anItem: space.item!)
                                            space.insertItem(anItem: self.itemToMove!)
                                            displayItem(item: itemToMove!, spot: "feet")
                                            if soundOn {
                                                self.run(itemSound)
                                            }
                                        }else if space.name == "neck" && itemToMove!.itemType == ItemType.neck{
                                            //SWAPPING NECK FOR NECK HIGHLIGHTED = packspace
                                            
                                            //&&
                                            persistentData!.set("\(itemToMove!.itemName!)", forKey: "neckSpace")
                                            //&&
                                            
                                            //&&
                                            //changed
                                            persistentData!.set("\(space.item!.itemName!)", forKey: "packSpace\(spaceToMove!.name!)")
                                            //&&
                                            
                                            //println("Name of the space: \(space.name!)")
                                            //println("\(itemToMove!.itemName!)")
                                            
                                            
                                            self.spaceToMove!.insertItem(anItem: space.item!)
                                            space.insertItem(anItem: self.itemToMove!)
                                            displayItem(item: itemToMove!, spot: "neck")
                                        }
                                    }else if spaceToMove!.name == "weapon" || spaceToMove!.name == "body" || spaceToMove!.name == "feet" || spaceToMove!.name == "neck"{
                                        //CHECK IF SPACETOMOVE IS WEP,BODY,FEET AND THEN CHECK SPACE'S ITEMTYPE
                                        if spaceToMove!.name == "weapon" && space.item!.itemType == ItemType.weapon{
                                            //SWAPPING HEAD FOR HEAD HIGHLIGHTED = HEAD
                                            
                                            //&&
                                            persistentData!.set("\(space.item!.itemName!)", forKey: "headSpace")
                                            //&&
                                            
                                            //&&
                                            persistentData!.set("\(itemToMove!.itemName!)", forKey: "packSpace\(space.name!)")
                                            //&&
                                            
                                            self.spaceToMove!.insertItem(anItem: space.item!)
                                            displayItem(item: space.item!, spot: "weapon")
                                            space.insertItem(anItem: self.itemToMove!)
                                            if soundOn {
                                                self.run(itemSound)
                                            }
                                        }else if spaceToMove!.name == "body" && (space.item!.itemType == ItemType.body || space.item!.itemType == ItemType.feet){
                                            //SWAPPING Left FOR Left HIGHLIGHTED = Left
                                            
                                            //&&
                                            persistentData!.set("\(space.item!.itemName!)", forKey: "leftSpace")
                                            //&&
                                            
                                            //&&
                                            persistentData!.set("\(itemToMove!.itemName!)", forKey: "packSpace\(space.name!)")
                                            //&&
                                            displayItem(item: space.item!, spot: "body")
                                            self.spaceToMove!.insertItem(anItem: space.item!)
                                            space.insertItem(anItem: self.itemToMove!)
                                            if soundOn {
                                                self.run(itemSound)
                                            }
                                        }else if spaceToMove!.name == "feet" && (space.item!.itemType == ItemType.feet || space.item!.itemType == ItemType.body){
                                            //SWAPPING Right FOR Right HIGHLIGHTED = Right
                                            
                                            //&&
                                            persistentData!.set("\(space.item!.itemName!)", forKey: "rightSpace")
                                            //&&
                                            
                                            //&&
                                            persistentData!.set("\(itemToMove!.itemName!)", forKey: "packSpace\(space.name!)")
                                            //&&
                                            displayItem(item: space.item!, spot: "feet")
                                            self.spaceToMove!.insertItem(anItem: space.item!)
                                            space.insertItem(anItem: self.itemToMove!)
                                            if soundOn {
                                                self.run(itemSound)
                                            }
                                        }else if spaceToMove!.name == "neck" && space.item!.itemType == ItemType.neck{
                                            //SWAPPING Neck FOR Neck HIGHLIGHTED = Neck
                                            
                                            //&&
                                            persistentData!.set("\(space.item!.itemName!)", forKey: "neckSpace")
                                            //&&
                                            
                                            //&&
                                            persistentData!.set("\(itemToMove!.itemName!)", forKey: "packSpace\(space.name!)")
                                            //&&
                                            
                                            self.spaceToMove!.insertItem(anItem: space.item!)
                                            displayItem(item: space.item!, spot: "neck")
                                            space.insertItem(anItem: self.itemToMove!)
                                            if soundOn {
                                                self.run(itemSound)
                                            }
                                        }
                                    }
                                    else{
                                        //SWAPPING TWO ITEMS IN THE BACKPACK!!!
                                        if soundOn {
                                            self.run(itemSound)
                                        }
                                        //&&
                                        persistentData!.set("\(space.item!.itemName!)", forKey: "packSpace\(spaceToMove!.name!)")
                                        //&&
                                        
                                        //&&
                                        persistentData!.set("\(itemToMove!.itemName!)", forKey: "packSpace\(space.name!)")
                                        //&&
                                        
                                        self.spaceToMove!.insertItem(anItem: space.item!)
                                        space.insertItem(anItem: self.itemToMove!)
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
                                    
                                    //&&
                                    persistentData!.set("", forKey: "headSpace")
                                    //&&
                                    
                                    //&&
                                    //persistentData!.setObject("\(itemToMove!.name!)", forKey: "packSpace\(space.name)")
                                    //&&
                                    
                                    weapon = nil
                                }else if spaceToMove!.name == "body"{
                                    
                                    //&&
                                    persistentData!.set("", forKey: "leftSpace")
                                    //&&
                                    
                                    //&&
                                    //persistentData!.setObject("\(itemToMove!.name!)", forKey: "packSpace\(space.name)")
                                    //&&
                                    
                                    body = nil
                                }else if spaceToMove!.name == "feet"{
                                    
                                    //&&
                                    persistentData!.set("", forKey: "rightSpace")
                                    //&&
                                    
                                    //&&
                                    //persistentData!.setObject("\(itemToMove!.name!)", forKey: "packSpace\(space.name)")
                                    //&&
                                    
                                    feet = nil
                                }else if spaceToMove!.name == "neck"{
                                    
                                    //&&
                                    persistentData!.set("", forKey: "neckSpace")
                                    //&&
                                    
                                    //&&
                                    //persistentData!.setObject("\(itemToMove!.name!)", forKey: "packSpace\(space.name)")
                                    //&&
                                    
                                    neck = nil
                                }
                                var moved = false
                                if space.name == "weapon" || space.name == "body" || space.name == "feet" || space.name == "neck"{
                                    if space.name == "weapon" && itemToMove!.itemType == ItemType.weapon{
                                        //MOVING ITEM FROM PACK TO HEAD
                                        backPackSpaces+=1
                                        weapon = itemToMove
                                        displayItem(item: itemToMove!, spot: "weapon")
                                        
                                        //&&
                                        persistentData!.set("\(itemToMove!.itemName!)", forKey: "headSpace")
                                        //&&
                                        
                                        //&&
                                        //println("spaceToMove name is \(spaceToMove!.name!)")
                                        persistentData!.set("", forKey: "packSpace\(spaceToMove!.name!)")
                                        //&&
                                        
                                        spaceToMove!.removeItem()
                                        space.insertItem(anItem: self.itemToMove!)
                                        moved = true
                                        if soundOn {
                                            self.run(itemSound)
                                        }
                                    }else if space.name == "body" && (itemToMove!.itemType == ItemType.body || itemToMove!.itemType == ItemType.feet){
                                        //MOVING ITEM FROM PACK TO LEFT
                                        backPackSpaces+=1
                                        body = itemToMove
                                        displayItem(item: itemToMove!, spot: "body")
                                        
                                        //&&
                                        persistentData!.set("\(itemToMove!.itemName!)", forKey: "leftSpace")
                                        //&&
                                        
                                        //&&
                                        persistentData!.set("", forKey: "packSpace\(spaceToMove!.name!)")
                                        //&&
                                        
                                        spaceToMove!.removeItem()
                                        space.insertItem(anItem: self.itemToMove!)
                                        moved = true
                                        if soundOn {
                                            self.run(itemSound)
                                        }
                                    }else if space.name == "feet" && (itemToMove!.itemType == ItemType.feet || itemToMove!.itemType == ItemType.body){
                                        //MOVING ITEM FROM PACK TO RIGHT
                                        backPackSpaces+=1
                                        feet = itemToMove
                                        displayItem(item: itemToMove!, spot: "feet")
                                        
                                        //&&
                                        persistentData!.set("\(itemToMove!.itemName!)", forKey: "rightSpace")
                                        //&&
                                        
                                        //&&
                                        persistentData!.set("", forKey: "packSpace\(spaceToMove!.name!)")
                                        //&&
                                        
                                        spaceToMove!.removeItem()
                                        space.insertItem(anItem: self.itemToMove!)
                                        moved = true
                                        if soundOn {
                                            self.run(itemSound)
                                        }
                                    }else if space.name == "neck" && itemToMove!.itemType == ItemType.neck{
                                        //MOVING ITEM FROM PACK TO NECK
                                        backPackSpaces+=1
                                        neck = itemToMove
                                        displayItem(item: itemToMove!, spot: "neck")
                                        
                                        //&&
                                        persistentData!.set("\(itemToMove!.itemName!)", forKey: "neckSpace")
                                        //&&
                                        
                                        //&&
                                        persistentData!.set("", forKey: "packSpace\(spaceToMove!.name!)")
                                        //&&
                                        
                                        spaceToMove!.removeItem()
                                        space.insertItem(anItem: self.itemToMove!)
                                        moved = true
                                        if soundOn {
                                            self.run(itemSound)
                                        }
                                    }else{
                                    }
                                }else{
                                    //println("space to space!")
                                    //&&
                                    persistentData!.set("\(itemToMove!.itemName!)", forKey: "packSpace\(space.name!)")
                                    //&&
                                    
                                    //&&
                                    persistentData!.set("", forKey: "packSpace\(spaceToMove!.name!)")
                                    //&&
                                    
                                    spaceToMove!.removeItem()
                                    space.insertItem(anItem: self.itemToMove!)
                                    moved = true
                                    if soundOn {
                                        self.run(itemSound)
                                    }
                                }
                                if (spaceToMove!.name == "weapon" || spaceToMove!.name == "body" || spaceToMove!.name == "feet" || spaceToMove!.name == "neck") && moved{
                                    backPackSpaces-=1
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
                            spaceToMove!.color = UIColor.black
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
                            if self.childNode(withName: "priceButton") != nil{
                                self.childNode(withName: "priceButton")?.removeFromParent()
                            }
                            
                            if isPlus{
                                let sellNode = SKLabelNode.init(text: "\(Int(round(itemToMove!.price! / 5)))")
                                sellNode.position = CGPointMake(self.frame.minX + 65, self.frame.midY - 118)
                                sellNode.fontName = "ChalkboardSE-Bold"
                                sellNode.fontSize = 22
                                sellNode.fontColor = UIColor.black
                                sellNode.name = "priceButton"
                                self.addChild(sellNode)
                                
                                //booty coin image
                                let booty = SKSpriteNode(imageNamed: "Booty_1.png")
                                booty.position = CGPointMake(self.frame.minX + 97, self.frame.midY - 110)
                                booty.name = "sellBooty"
                                booty.setScale(0.06)
                                self.addChild(booty)
                            } else if is5{
                                let sellNode = SKLabelNode.init(text: "\(Int(round(itemToMove!.price! / 5)))")
                                sellNode.position = CGPointMake(self.frame.minX + 40, self.frame.minY + 215)
                                sellNode.fontName = "ChalkboardSE-Bold"
                                sellNode.fontSize = 23
                                sellNode.fontColor = UIColor.black
                                sellNode.name = "priceButton"
                                self.addChild(sellNode)
                                
                                //booty coin image
                                let booty = SKSpriteNode(imageNamed: "Booty_1.png")
                                booty.position = CGPointMake(self.frame.minX + 72, self.frame.minY + 222)
                                booty.name = "sellBooty"
                                booty.setScale(0.06)
                                self.addChild(booty)
                            } else if isPad{
                                let sellNode = SKLabelNode.init(text: "\(Int(round(itemToMove!.price! / 5)))")
                                sellNode.position = CGPointMake(self.frame.minX + 30, self.frame.minY + 131)
                                sellNode.fontName = "ChalkboardSE-Bold"
                                sellNode.fontSize = 17
                                sellNode.fontColor = UIColor.black
                                sellNode.name = "priceButton"
                                self.addChild(sellNode)
                                
                                //booty coin image
                                let booty = SKSpriteNode(imageNamed: "Booty_1.png")
                                booty.position = CGPointMake(self.frame.minX + 53, self.frame.minY + 137)
                                booty.name = "sellBooty"
                                booty.setScale(0.04)
                                self.addChild(booty)
                            }else {
                                let sellNode = SKLabelNode.init(text: "\(Int(round(itemToMove!.price! / 5)))")
                                sellNode.position = CGPointMake(self.frame.minX + 48, self.frame.minY + 252)
                                sellNode.fontName = "ChalkboardSE-Bold"
                                sellNode.fontSize = 22
                                sellNode.fontColor = UIColor.black
                                sellNode.name = "priceButton"
                                self.addChild(sellNode)
                                
                                //booty coin image
                                let booty = SKSpriteNode(imageNamed: "Booty_1.png")
                                booty.position = CGPointMake(self.frame.minX + 80, self.frame.minY + 260)
                                booty.name = "sellBooty"
                                booty.setScale(0.06)
                                self.addChild(booty)
                            }
                            
                            //sell text
                            let sellText = SKSpriteNode(imageNamed: "Sell_Text_1.png")
                            sellText.position = CGPointMake(self.frame.midX - 120, self.frame.minY + 230)
                            sellText.setScale(0.45)
                            sellText.name = "sellButton"
                            if is5{
                                sellText.position = CGPointMake(self.frame.midX - 30, self.frame.minY + 225)
                                sellText.setScale(0.4)
                            } else if isPad{
                                sellText.position = CGPointMake(self.frame.midX - 73, self.frame.minY + 140)
                                sellText.setScale(0.25)
                            }
                            self.addChild(sellText)
                            //name of the item
                            var itemPicName = spaceToMove!.item!.itemName!
                            //println("\(itemPicName)")
                            itemPicName = itemPicName.replacingOccurrences(of: "1", with: "Text")
                            let itemText = SKSpriteNode(imageNamed: "\(itemPicName)")
                            itemText.name = "itemName"
                            itemText.setScale(0.7)
                            if isPlus {
                                itemText.position = CGPointMake(self.frame.midX, self.frame.midY - 25)
                            } else if is5{
                                itemText.zPosition = 10
                                itemText.setScale(0.35)
                                itemText.position = CGPointMake(self.frame.midX, self.frame.midY - 5)
                            } else if isPad{
                                itemText.setScale(0.35)
                                itemText.zPosition = 10
                                itemText.position = CGPointMake(self.frame.midX, self.frame.midY - 55)
                            } else {
                            itemText.position = CGPointMake(self.frame.midX, self.frame.minY + 295)
                            }
                            self.addChild(itemText)
                            
                            //Add item type***********
                            let itemType = itemToMove!.itemType
                            var typeString: SKSpriteNode?
                            if isPlus {
                                if itemType == ItemType.weapon{
                                    typeString = SKSpriteNode(imageNamed: "Noggin_Text_1")
                                }else if itemType == ItemType.neck {
                                    typeString = SKSpriteNode(imageNamed: "Neck_Text_1")
                                }else {
                                    typeString = SKSpriteNode(imageNamed: "Tentacles_Text_1")
                                }

                                typeString!.position = CGPointMake(self.frame.midX, self.frame.midY - 105)
                                typeString?.setScale(0.3)
                            } else if is5{
                                if itemType == ItemType.weapon{
                                    typeString = SKSpriteNode(imageNamed: "Noggin_Text_1")
                                }else if itemType == ItemType.neck {
                                    typeString = SKSpriteNode(imageNamed: "Neck_Text_1")
                                }else {
                                    typeString = SKSpriteNode(imageNamed: "Tentacles_Text_1")
                                }
                                
                                typeString!.position = CGPointMake(self.frame.midX, self.frame.midY - 38)
                                typeString?.zPosition = 10
                                typeString?.setScale(0.2)
                            } else if isPad{
                                if itemType == ItemType.weapon{
                                    typeString = SKSpriteNode(imageNamed: "Noggin_Text_1")
                                }else if itemType == ItemType.neck {
                                    typeString = SKSpriteNode(imageNamed: "Neck_Text_1")
                                }else {
                                    typeString = SKSpriteNode(imageNamed: "Tentacles_Text_1")
                                }
                                
                                typeString!.position = CGPointMake(self.frame.midX, self.frame.midY - 95)
                                typeString?.zPosition = 10
                                typeString?.setScale(0.2)
                            } else {
                                if itemType == ItemType.weapon{
                                    typeString = SKSpriteNode(imageNamed: "Noggin_Text_1")
                                }else if itemType == ItemType.neck {
                                    typeString = SKSpriteNode(imageNamed: "Neck_Text_1")
                                }else {
                                    typeString = SKSpriteNode(imageNamed: "Tentacles_Text_1")
                                }

                                typeString!.position = CGPointMake(self.frame.midX, self.frame.midY - 95)
                                typeString?.setScale(0.3)
                            }
                            
                            typeString!.name = "typeString"
                            self.addChild(typeString!)
                            //************************
                        }else{
                            statLabelLife!.text = ""
                            statLabelMovement!.text = ""
                            statLabelRegen!.text = ""
                            lifeSymbol2?.removeFromParent()
                            speedSymbol2?.removeFromParent()
                            regenerationSymbol2?.removeFromParent()
                            self.childNode(withName: "sellButton")?.removeFromParent()
                            self.childNode(withName: "typeString")?.removeFromParent()
                            self.childNode(withName: "itemName")?.removeFromParent()
                            self.childNode(withName: "priceButton")?.removeFromParent()
                            self.childNode(withName: "sellBooty")?.removeFromParent()
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
