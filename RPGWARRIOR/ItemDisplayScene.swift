//
//  ItemDisplayScene.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 6/14/15.
//  Copyright (c) 2015 Drew and Zach. All rights reserved.
//

import Foundation
import SpriteKit

class ItemDisplayScene: SKScene {
    

    var itemName: String? = "Silver_Ring_1"
    var life: CGFloat? = -1
    var movement: CGFloat? = -1
    var regen: CGFloat? = -1
    var theItem: ItemClass? = nil
    var continueButton: SKSpriteNode? = nil
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        theItem = ItemClass.itemInSpace("\(itemName!)")
        let theImage = SKSpriteNode(imageNamed: "\(itemName!)")
        theImage.position = CGPointMake(self.frame.midX, self.frame.midY + 150)
        theImage.size = CGSizeMake(100, 100)
        theImage.zPosition = 1
        self.addChild(theImage)
        
        //setup the life speed and regen of the item
        for stat in theItem!.itemStats! {
            if stat.0 == "Life"{
                life = stat.1
            }else if stat.0 == "Movement"{
                movement = stat.1
            }else{
                regen = stat.1
            }
        }
        
        let theBackground = SKSpriteNode(imageNamed: "Beach_Background_1")
        theBackground.position = CGPointMake(self.frame.midX, self.frame.midY)
        theBackground.name = "background"
        theBackground.size = self.frame.size
        theBackground.zPosition = -1
        self.addChild(theBackground)
        
        /*
        var liteAttack: SKEmitterNode?
        let litePath = NSBundle.mainBundle().pathForResource("TreasureChestSpark", ofType: "sks")
        liteAttack = (NSKeyedUnarchiver.unarchiveObjectWithFile(litePath!) as! SKEmitterNode)
        liteAttack!.position = CGPointMake(self.frame.midX, self.frame.midY)
        liteAttack!.zPosition = 2
        liteAttack!.setScale(0.1)
        self.addChild(liteAttack!)
        */
        
        
        continueButton = SKSpriteNode(imageNamed: "Continue_Button_Text")
        continueButton!.position = CGPointMake(self.frame.midX, self.frame.midY - 150)
        continueButton!.name = "continue"
        continueButton!.size = CGSizeMake(350, 100)
        continueButton!.zPosition = 3
        self.addChild(continueButton!)

        
        let sellNode = SKLabelNode.init(text: "\(Int(round(theItem!.price! / 5)))")
        sellNode.position = CGPointMake(self.frame.minX + 50, self.frame.minY + 220)
        sellNode.fontName = "ChalkboardSE-Bold"
        sellNode.fontSize = 30
        sellNode.fontColor = UIColor.blackColor()
        sellNode.name = "priceButton"
        self.addChild(sellNode)
        

        let itemText = SKSpriteNode(imageNamed: "\(theItem!.itemName!)")
        itemText.name = "itemName"
        itemText.setScale(0.7)
        itemText.position = CGPointMake(self.frame.midX, self.frame.minY + 295)
        self.addChild(itemText)
        
        //gold node
        let goldCount = (self.userData?.objectForKey("inventory") as! Inventory).gold
        let goldNode = SKLabelNode.init(text: "\(Int(goldCount))")
        goldNode.position = CGPointMake(self.frame.midX - 30, self.frame.maxY - 120)
        goldNode.fontName = "ChalkboardSE-Bold"
        goldNode.fontSize = 30
        goldNode.fontColor = UIColor.blackColor()
        self.addChild(goldNode)
        //booty coin image
        let booty = SKSpriteNode(imageNamed: "Booty_1.png")
        booty.position = CGPointMake(self.frame.midX + 30, self.frame.maxY - 110)
        booty.setScale(0.10)
        self.addChild(booty)
        
        
        let statLabelLife = SKLabelNode.init(text: "\(life)")
        statLabelLife.position = CGPointMake(self.frame.midX - 110, self.frame.minY + 87)
        statLabelLife.fontName = "ChalkboardSE-Bold"
        statLabelLife.fontSize = 30
        statLabelLife.fontColor = UIColor.blackColor()
        statLabelLife.name = "lifeStat"
        statLabelLife.setScale(0.7)
        self.addChild(statLabelLife)
        let statLabelMovement = SKLabelNode.init(text: "\(movement)")
        statLabelMovement.position = CGPointMake(self.frame.midX - 110, self.frame.minY + 57)
        statLabelMovement.fontName = "ChalkboardSE-Bold"
        statLabelMovement.fontSize = 30
        statLabelMovement.fontColor = UIColor.blackColor()
        statLabelMovement.name = "movementStat"
        statLabelMovement.setScale(0.7)
        self.addChild(statLabelMovement)
        let statLabelRegen = SKLabelNode.init(text: "\(regen)")
        statLabelRegen.position = CGPointMake(self.frame.midX - 110, self.frame.minY + 27)
        statLabelRegen.fontName = "ChalkboardSE-Bold"
        statLabelRegen.fontSize = 30
        statLabelRegen.fontColor = UIColor.blackColor()
        statLabelRegen.name = "regenStat"
        statLabelRegen.setScale(0.7)
        self.addChild(statLabelRegen)
        
        
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in touches {
            if continueButton!.containsPoint((touch as! UITouch).locationInNode(self)){
                //go to mainmenuscene
                let skTransition = SKTransition.fadeWithDuration(1.0)
                let mainMenu = self.userData?.objectForKey("menu") as! MainMenuScene
                self.view?.presentScene(mainMenu, transition: skTransition)
            }
        }
    }
}