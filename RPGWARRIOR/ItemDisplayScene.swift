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
    var numBooty = 0
    var continueButton: SKSpriteNode? = nil
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        theItem = ItemClass.itemInSpace(nameOfTexture: "\(itemName!)")
        let theImage = SKSpriteNode(imageNamed: "\(itemName!)")
        theImage.position = CGPointMake(self.frame.midX, self.frame.midY + 50)
        if itemName == "Booty_1" {
            theImage.position = CGPointMake(self.frame.midX, self.frame.midY + 50)
        }
        theImage.size = CGSizeMake(100, 100)
        theImage.zPosition = 1
        self.addChild(theImage)
        
        let levelComplete = SKSpriteNode(imageNamed: "Level_Complete_Text")
        levelComplete.position = CGPointMake(self.frame.midX, self.frame.midY + 250)
        levelComplete.name = "levelComplete"
        levelComplete.setScale(0.35)
        levelComplete.zPosition = 1
        if is5{
            levelComplete.position = CGPointMake(self.frame.midX, self.frame.midY + 230)
            levelComplete.setScale(0.3)
        } else if isPad{
            levelComplete.position = CGPointMake(self.frame.midX, self.frame.midY + 200)
            levelComplete.setScale(0.3)
        }
        self.addChild(levelComplete)
        
        //backpack spaces
        let backpackSpaces = (self.userData?.object(forKey: "inventory") as! Inventory).backPackSpaces
        if backpackSpaces == 0 && itemName != "Booty_1"{
            theImage.texture = SKTexture(imageNamed: "Backpack_Full_Text")
            theImage.size = CGSizeMake(300, 250)
            theImage.position = CGPointMake(self.frame.midX, self.frame.midY - 20)
            
        }
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
        
        if backpackSpaces != 0 {
        var liteAttack: SKEmitterNode?
            let litePath = BundleBundle.main.pathForResource("TreasureChestSpark", ofType: "sks")
        liteAttack = (NSKeyedUnarchiver.unarchiveObjectWithFile(litePath!) as! SKEmitterNode)
        liteAttack!.position = CGPointMake(self.frame.midX, self.frame.midY + 50)
            if is5{
                liteAttack!.position = CGPointMake(self.frame.midX, self.frame.midY + 30)
            } else if isPad{
                liteAttack!.position = CGPointMake(self.frame.midX, self.frame.midY + 50)
            }
            if itemName == "Booty_1" {
                liteAttack!.position = CGPointMake(self.frame.midX, self.frame.midY + 130)
            }
        liteAttack!.zPosition = 2
        liteAttack!.particleColorBlueRange = 100
        liteAttack!.setScale(0.9)
            let waitDuration = SKAction.wait(forDuration: 1)
            let runBlock = SKAction.run({liteAttack!.removeFromParent()})
        let sequence = SKAction.sequence([waitDuration, runBlock])
            liteAttack!.run(sequence)
        self.addChild(liteAttack!)
        }
        
        
        let theBackground = SKSpriteNode(imageNamed: "Beach_Background_1")
        theBackground.position = CGPointMake(self.frame.midX, self.frame.midY)
        theBackground.name = "background"
        theBackground.size = CGSizeMake(self.frame.maxX, self.frame.maxY)
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
        
        
        continueButton = SKSpriteNode(imageNamed: "Tap_To_Continue_Text_1")
        continueButton!.position = CGPointMake(self.frame.midX, self.frame.midY - 250)
        continueButton!.name = "continue"
        continueButton!.setScale(0.35)
        continueButton!.zPosition = 3
        if is5{
            continueButton!.position = CGPointMake(self.frame.midX, self.frame.midY - 230)
            continueButton!.setScale(0.3)
        } else if isPad{
            continueButton!.position = CGPointMake(self.frame.midX, self.frame.midY - 210)
            continueButton!.setScale(0.3)
        }
        self.addChild(continueButton!)
        
        
        
        
        let received = SKSpriteNode(imageNamed: "You_Received_Text")
        received.position = CGPointMake(self.frame.midX, self.frame.midY + 150)
        received.name = "received"
        received.setScale(0.4)
        received.zPosition = 1
        self.addChild(received)
        
        
        if itemName != "Booty_1" && backpackSpaces != 0{
            
            let checkIt = SKSpriteNode(imageNamed: "Check_It_Text_1")
            checkIt.position = CGPointMake(self.frame.midX, self.frame.midY - 125)
            checkIt.name = "checkIt"
            checkIt.setScale(0.4)
            checkIt.zPosition = 1
            self.addChild(checkIt)
            
            //Add item type***********
            let itemType = theItem!.itemType
            var typeString: SKSpriteNode?
            //var typeString: String?
            if itemType == ItemType.weapon{
                typeString = SKSpriteNode(imageNamed: "Noggin_Text_1")
            }else if itemType == ItemType.neck {
                typeString = SKSpriteNode(imageNamed: "Neck_Text_1")
            }else {
                typeString = SKSpriteNode(imageNamed: "Tentacles_Text_1")
            }
            
            typeString!.position = CGPointMake(self.frame.midX - 125, self.frame.midY - 82)
            typeString?.setScale(0.4)
            typeString!.name = "typeString"
            //self.addChild(typeString!)
            //************************

            
            
            
        let sellNode = SKLabelNode.init(text: "\(Int(round(theItem!.price! / 5)))")
        sellNode.position = CGPointMake(self.frame.midX + 155, 285)
        sellNode.fontName = "ChalkboardSE-Bold"
        sellNode.fontSize = 20
            sellNode.fontColor = UIColor.black
        sellNode.name = "priceButton"
        sellNode.zPosition = 3
        //self.addChild(sellNode)
        }else if itemName == "Booty_1" {
            
            let dontForget = SKSpriteNode(imageNamed: "Dont_Forget_Text_1")
            dontForget.position = CGPointMake(self.frame.midX, self.frame.midY - 125)
            dontForget.name = "checkIt"
            dontForget.setScale(0.4)
            dontForget.zPosition = 1
            self.addChild(dontForget)
            
            
            //gold node
            let goldCount = (self.userData?.object(forKey: "inventory") as! Inventory).gold
            let goldNode = SKLabelNode.init(text: "\(Int(goldCount))")
            goldNode.position = CGPointMake(self.frame.midX + 50, self.frame.midY - 180)
            goldNode.fontName = "ChalkboardSE-Bold"
            goldNode.fontSize = 20
            goldNode.fontColor = UIColor.black
            self.addChild(goldNode)
            //booty coin image
            let booty = SKSpriteNode(imageNamed: "Booty_1.png")
            booty.position = CGPointMake(self.frame.midX, self.frame.midY - 172)
            booty.setScale(0.07)
            self.addChild(booty)
            //total booty node
            let myBootyText = SKLabelNode.init(text: "TOTAL")
            myBootyText.position = CGPointMake(self.frame.midX - 50, self.frame.midY - 180)
            myBootyText.fontName = "ChalkboardSE-Bold"
            myBootyText.fontSize = 20
            myBootyText.fontColor = UIColor.black
            myBootyText.name = "bootyText"
            myBootyText.zPosition = 3
            self.addChild(myBootyText)
            
            
            
            let sellNode2 = SKLabelNode.init(text: "\(Int(numBooty))")
            sellNode2.position = CGPointMake(self.frame.midX + 80, self.frame.midY - 51)
            sellNode2.fontName = "ChalkboardSE-Bold"
            sellNode2.fontSize = 20
            sellNode2.fontColor = UIColor.black
            sellNode2.name = "priceButton"
            sellNode2.zPosition = 3
            self.addChild(sellNode2)
        } else {
            
        }
        
        //myBooty node
        if itemName != "Booty_1"  && backpackSpaces != 0{
        let myBootyText2 = SKLabelNode.init(text: "Sells for")
        myBootyText2.position = CGPointMake(self.frame.midX + 50, 285)
        myBootyText2.fontName = "ChalkboardSE-Bold"
        myBootyText2.fontSize = 20
            myBootyText2.fontColor = UIColor.black
        myBootyText2.name = "sellText"
        myBootyText2.zPosition = 3
        //self.addChild(myBootyText2)
        }else if itemName == "Booty_1" {
            let myBootyText3 = SKLabelNode.init(text: "Kraken Booty  x")
            myBootyText3.position = CGPointMake(self.frame.midX - 20, self.frame.midY - 50)
            myBootyText3.fontName = "ChalkboardSE-Bold"
            myBootyText3.fontSize = 20
            myBootyText3.fontColor = UIColor.black
            myBootyText3.name = "sellText"
            myBootyText3.zPosition = 3
            self.addChild(myBootyText3)
        } else {
            
        }
        
        
        if itemName != "Booty_1" && backpackSpaces != 0{
        let itemText = SKSpriteNode(imageNamed: theItem!.itemName!.stringByReplacingOccurrencesOfString("1", withString: "Text", options: NSStringCompareOptions.LiteralSearch, range: nil))
        itemText.name = "itemName"
        itemText.setScale(0.5)
        itemText.position = CGPointMake(self.frame.midX, self.frame.midY - 15)
        self.addChild(itemText)
        }
        
        
        if itemName != "Booty_1"  && backpackSpaces != 0{
            if life! == -1 {
                life! = 0
            }
            if movement! == -1 {
                movement! = 0
            }
            if regen! == -1 {
                regen! = 0
            }
        
        let statLabelLife = SKLabelNode.init(text: "\(Int(life!))")
        statLabelLife.position = CGPointMake(self.frame.midX - 70, self.frame.minY + 327)
        statLabelLife.fontName = "ChalkboardSE-Bold"
        statLabelLife.fontSize = 25
            statLabelLife.fontColor = UIColor.black
        statLabelLife.name = "lifeStat"
        statLabelLife.setScale(0.7)
        //self.addChild(statLabelLife)
        let statLabelMovement = SKLabelNode.init(text: "\(Int(movement!))")
        statLabelMovement.position = CGPointMake(self.frame.midX + 30, self.frame.minY + 327)
        statLabelMovement.fontName = "ChalkboardSE-Bold"
        statLabelMovement.fontSize = 30
            statLabelMovement.fontColor = UIColor.black
        statLabelMovement.name = "movementStat"
        statLabelMovement.setScale(0.7)
        //self.addChild(statLabelMovement)
        let statLabelRegen = SKLabelNode.init(text: "\(Int(regen!))")
        statLabelRegen.position = CGPointMake(self.frame.midX + 130, self.frame.minY + 327)
        statLabelRegen.fontName = "ChalkboardSE-Bold"
        statLabelRegen.fontSize = 30
            statLabelRegen.fontColor = UIColor.black
        statLabelRegen.name = "regenStat"
        statLabelRegen.setScale(0.7)
        //self.addChild(statLabelRegen)
        }
        
        if itemName != "Booty_1" && backpackSpaces != 0{
        let lifeSymbol = SKSpriteNode(imageNamed: "Life_Symbol_1")
        lifeSymbol.setScale(0.15)
        lifeSymbol.name = "life"
        lifeSymbol.position = CGPointMake(self.frame.midX - 110, self.frame.minY + 335)
        //self.addChild(lifeSymbol)
        let speedSymbol = SKSpriteNode(imageNamed: "Speed_Symbol_1")
        speedSymbol.setScale(0.15)
        speedSymbol.name = "speed"
        speedSymbol.position = CGPointMake(self.frame.midX - 10, self.frame.minY + 335)
        //self.addChild(speedSymbol)
        let regenerationSymbol = SKSpriteNode(imageNamed: "Regeneration_Symbol_1")
        regenerationSymbol.setScale(0.15)
        regenerationSymbol.name = "regen"
        regenerationSymbol.position = CGPointMake(self.frame.midX + 90, self.frame.minY + 335)
        //self.addChild(regenerationSymbol)
        }
        
        
        if soundOn {
            self.run(hornSound)
            let wait = SKAction.wait(forDuration: 0.1)
            let sequence = SKAction.sequence([wait, fireworksSound, wait, fireworksSound, wait, fireworksSound, wait, fireworksSound])
            self.run(sequence)
        }
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            if continueButton!.contains((touch ).location(in: self)){
                if soundOn {
                    self.run(clickSound)
                }
                if soundOn{
                    beachMusic!.stop()
                }
                //go to mainmenuscene
                let skTransition = SKTransition.fade(withDuration: 1.0)
                let mainMenu = self.userData?.object(forKey: "menu") as! MainMenuScene
                self.view?.presentScene(mainMenu, transition: skTransition)
            }else{
                if soundOn{
                    self.run(fireworksSound)
                }
                var liteAttack: SKEmitterNode?
                let litePath = Bundle.main.path(forResource: "TreasureChestSpark", ofType: "sks")
                liteAttack = (NSKeyedUnarchiver.unarchiveObject(withFile: litePath!) as! SKEmitterNode)
                liteAttack!.position = (touch ).location(in: self)
                liteAttack!.zPosition = 2
                liteAttack!.particleColorBlueRange = 100
                liteAttack!.setScale(0.3)
                let waitDuration = SKAction.wait(forDuration: 1)
                let runBlock = SKAction.run({liteAttack!.removeFromParent()})
                let sequence = SKAction.sequence([waitDuration, runBlock])
                liteAttack!.run(sequence)
                self.addChild(liteAttack!)
            }
        }
    }
}
