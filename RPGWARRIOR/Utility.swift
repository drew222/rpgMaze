//
//  Utility.swift
//  TestRpgGame
//
//  Created by Drew Zoellner on 1/27/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation






let smoothnessFactor = 1.0
let pi = CGFloat(3.1415927)
var isPlus = false
var isPad = false
var is5 = false
var soundOn = true



//NOTE: currently bomb doesn't use collision checking
enum CollisionBitMasks: UInt32{
    case collisionCategoryHero = 1
    case collisionCategoryProjectile = 2
    case collisionCategoryWizard = 4
    case collisionCategoryItem = 8
    case collisionCategoryBomb = 16
    case collisionCategoryBlizzard = 32
    case collisionCategorySeashell = 64
    case collisionCategoryMiniCrab = 128
    case collisionCategoryWave = 256
    case collisionCategoryKraken = 512
    case collisionCategoryChest = 1024
    case collisionCategoryKrill = 2048
    case collisionCategorySpike = 4096
    case collisionCategoryBuff = 8192
    case collisionCategoryCoin = 16384
    case collisionCategoryMudCrab = 32768
    case collisionCategoryWhiteShell = 65536
    case collisionCategoryGreyShell = 131072
    case collisionCategoryBeachBall = 262144
}

let damageSound = SKAction.playSoundFileNamed("Ink_Squirt_Sound_1.mp3", waitForCompletion: false)
let splatterSound = SKAction.playSoundFileNamed("Splat_Sound.mp3", waitForCompletion: false)
let pageSound = SKAction.playSoundFileNamed("Page_Turn_Sound.mp3", waitForCompletion: false)
let hornSound = SKAction.playSoundFileNamed("Horn_Sound.mp3", waitForCompletion: false)
let poofSound = SKAction.playSoundFileNamed("Ink_Spray_Sound.mp3", waitForCompletion: false)
let fireworksSound = SKAction.playSoundFileNamed("Fireworks_Sound.mp3", waitForCompletion: false)
let clickSound = SKAction.playSoundFileNamed("Button_Click_Sound2.mp3", waitForCompletion: false)
let chestSound = SKAction.playSoundFileNamed("Chest_Opening_Sound.mp3", waitForCompletion: false)
let itemSound = SKAction.playSoundFileNamed("Swish_Noise.mp3", waitForCompletion: false)
let url = NSBundle.mainBundle().URLForResource("Gauntlet_Music", withExtension: "mp3")
let gauntletMusic = AVAudioPlayer(contentsOfURL: url, error: nil)
let url2 = NSBundle.mainBundle().URLForResource("Rap_Funk_Music", withExtension: "mp3")
let happyMusic = AVAudioPlayer(contentsOfURL: url2, error: nil)
let url3 = NSBundle.mainBundle().URLForResource("Beach_Noise", withExtension: "mp3")
let beachMusic = AVAudioPlayer(contentsOfURL: url3, error: nil)
let url4 = NSBundle.mainBundle().URLForResource("Intro_Music", withExtension: "mp3")
let introMusic = AVAudioPlayer(contentsOfURL: url4, error: nil)
let url5 = NSBundle.mainBundle().URLForResource("Level_Music2", withExtension: "mp3")
let levelMusic = AVAudioPlayer(contentsOfURL: url5, error: nil)
let bootySound = SKAction.playSoundFileNamed("Kraken_Booty_Sound_1.mp3", waitForCompletion: false)


enum ItemType{
    case body
    case weapon
    case feet
    case neck
}

var heroSpeed: CGFloat = 150
//enum nodeSpeeds: Int{
//    case heroSpeed = 160
//}

let allStoreItems = ["Copper_Ring_1","Sweaty_Wristband_1", "Silver_Ring_1","Water_Wing_1", "Gold_Ring_1", "Whistle_1", "Lifejacket_1", "Beach_Towel_1", "Floatie_1", "Sun_Screen_1",
    "Sweatband_1", "Visor_1", "Sand_Bucket_1", "Sunhat_1", "Shades_1", "Bling_Ring_1",
    "Watch_1", "Bow_Tie_1", "Top_Hat_1", "Monocle_1"]


func randomWithMin(min: Int, max: Int) -> NSInteger{
    //let randomNum = arc4random_uniform(50)
    //random()
    if min == max{
        return min as NSInteger
    }
    let myNum = Int(arc4random_uniform(UInt32(max))) % (max - min) + min as NSInteger
    return myNum
}

func resizeLabel(node: SKLabelNode){
    let numChars = count(node.text)
    node.fontSize = 25 - (CGFloat(numChars) / 6)
}


func distanceBetween(point1: CGPoint, point2: CGPoint)-> CGFloat{
    let xDist = point2.x - point1.x
    let yDist = point2.y - point1.y
    return sqrt(pow(xDist, 2) + pow(yDist ,2))
}

func dropLoot(level: String, scene: SKScene, position: CGPoint, size: CGSize){
    if level == "level1"{
        //75% 1 booty, 25% rusty copper ring
        let myNum = randomWithMin(0, 100)
        if myNum > 75{
            let item = ItemClass.itemInSpace("Rusty_Copper_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }
    else if level == "level2"{
        //50% 1 booty, 50% rusty copper ring
        let myNum = randomWithMin(0, 100)
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Copper_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level3"{
        //75% booty, 25% mossy copper ring
        let myNum = randomWithMin(0, 100)
        if myNum > 75{
            let item = ItemClass.itemInSpace("Mossy_Copper_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }
    else if level == "level4"{
        //25% mossy copper ring, 50% 2 booty, 15% crab claw cap, 10% beachball fragment
        let myNum = randomWithMin(0, 100)
        if myNum < 75{
            let item = ItemClass.itemInSpace("Mossy_Copper_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 75) && (myNum > 65){
            let item = ItemClass.itemInSpace("Beach_Ball_Fragment_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 65) && (myNum > 50){
            let item = ItemClass.itemInSpace("Crab_Claw_Cap_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level5"{
        //50% 2 booty, 25% mossy copper ring, 25% Crab claw cap
        let myNum = randomWithMin(0, 100)
        if myNum > 75{
            let item = ItemClass.itemInSpace("Mossy_Copper_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 75) && (myNum > 50){
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 2
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        } else {
            let item = ItemClass.itemInSpace("Mossy_Copper_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    }else if level == "level6"{
        //25% crab claw cap, 50% mossy copper ring, 25% 2 booty
        let myNum = randomWithMin(0, 100)
        if myNum > 75{
            let item = ItemClass.itemInSpace("Crab_Claw_Cap_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 75) && (myNum > 50){
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 2
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        } else {
            let item = ItemClass.itemInSpace("Mossy_Copper_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    }else if level == "level7"{
        //25% copper ring, 65% 3 booty, 10% pearl necklace
        let myNum = randomWithMin(0, 100)
        if myNum > 75{
            let item = ItemClass.itemInSpace("Copper_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 75) && (myNum > 10){
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 3
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        } else{
            let item = ItemClass.itemInSpace("Pearl_Necklace_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    }else if level == "level8"{
        //25% copper ring, 25% 3 booty, 50% barnacles
        let myNum = randomWithMin(0, 100)
        if myNum > 75{
            let item = ItemClass.itemInSpace("Copper_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 75) && (myNum > 50){
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 3
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        } else{
            let item = ItemClass.itemInSpace("Barnacles_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    }else if level == "level9"{
        //10% beach ball fragment, 25% crab claw cap, 65% 3 booty
        let myNum = randomWithMin(0, 100)
        if myNum > 90{
            let item = ItemClass.itemInSpace("Beach_Ball_Fragment_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 90) && (myNum > 25){
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 3
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        } else {
            let item = ItemClass.itemInSpace("Crab_Claw_Cap_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    }else if level == "level10"{
        //10% pearl necklace, 50% copper ring, 40% 3 booty
        let myNum = randomWithMin(0, 100)
        if myNum > 90{
            let item = ItemClass.itemInSpace("Pearl_Necklace_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 90) && (myNum > 40){
            let item = ItemClass.itemInSpace("Copper_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 3
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level11"{
        //25% rusty silver ring, 15% beach ball fragment, 60% 4 booty
        let myNum = randomWithMin(0, 100)
        if myNum > 75{
            let item = ItemClass.itemInSpace("Rusty_Silver_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 75) && (myNum > 15){
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 4
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        } else {
            let item = ItemClass.itemInSpace("Beach_Ball_Fragment_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    }else if level == "level12"{
        //10% whale flesh ring, 25% rusty silver ring, 15% 4 booty, 50% barnacles
        let myNum = randomWithMin(0, 100)
        if myNum > 90{
            let item = ItemClass.itemInSpace("Whale_Flesh_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 90) && (myNum > 65){
            let item = ItemClass.itemInSpace("Rusty_Silver_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 65) && (myNum > 15){
            let item = ItemClass.itemInSpace("Barnacles_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 4
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level13"{
        //50% coral crown, 25% 5 booty, 25% crab claw cap
        let myNum = randomWithMin(0, 100)
        if myNum > 50{
            let item = ItemClass.itemInSpace("Coral_Crown_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 50) && (myNum > 25){
            let item = ItemClass.itemInSpace("Crab_Claw_Cap_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 5
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level14"{
        // 25% 5 booty, 25% pearl necklace, 50% coral crown
        let myNum = randomWithMin(0, 100)
        if myNum > 75{
            let item = ItemClass.itemInSpace("Pearl_Necklace_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum > 25) && (myNum <= 75){
            let item = ItemClass.itemInSpace("Coral_Crown_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 5
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level15"{
        //25% mossy silver ring, 25% whale flesh ring, 50% coral crown
        let myNum = randomWithMin(0, 100)
        if (myNum > 50){
            let item = ItemClass.itemInSpace("Coral_Crown_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 50) && (myNum > 25){
            let item = ItemClass.itemInSpace("Mossy_Silver_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else{
            let item = ItemClass.itemInSpace("Whale_Flesh_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    }else if level == "level16"{
        //50% 5 booty, 25% mossy silver ring,  25% whale flesh
        let myNum = randomWithMin(0, 100)
        if myNum > 75{
            let item = ItemClass.itemInSpace("Mossy_Silver_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 75) && (myNum > 50){
            let item = ItemClass.itemInSpace("Whale_Flesh_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 5
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level17"{
        //75% 1 booty, 25% mossy silver ring
        let myNum = randomWithMin(0, 100)
        if myNum > 75{
            let item = ItemClass.itemInSpace("Mossy_Silver_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 6
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level18"{
        //50% 6 booty, 25% silver ring, 25% pearl necklace
        let myNum = randomWithMin(0, 100)
        if myNum > 75{
            let item = ItemClass.itemInSpace("Silver_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 75) && (myNum > 50){
            let item = ItemClass.itemInSpace("Pearl_Necklace_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 6
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level19"{
        //100% king kraken tentacle ring
        let myNum = randomWithMin(0, 100)
        if myNum > -1{
            let item = ItemClass.itemInSpace("King_Kraken_Tentacle_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }     }else if level == "level20"{
        //35% 7 booty, 25% silver ring, 40% seashell charm bracelet
        let myNum = randomWithMin(0, 100)
        if myNum > 75{
            let item = ItemClass.itemInSpace("Silver_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 75) && (myNum > 35){
            let item = ItemClass.itemInSpace("Seashell_Charm_Bracelet_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 7
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level21"{
        //50% 1 booty, 25 % king kraken tentacle, 25% rusty gold ring
        let myNum = randomWithMin(0, 100)
        if myNum > 75{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        else if (myNum <= 75) && (myNum > 50){
            let item = ItemClass.itemInSpace("King_Kraken_Tentacle_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 8
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level22"{
        //30% 9 booty, 50% rusty gold ring, 10% afro seaweed, 10% seaweed mustache
        let myNum = randomWithMin(0, 100)
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 50) && (myNum > 40){
            let item = ItemClass.itemInSpace("Afro_Seaweed_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 40) && (myNum > 30){
            let item = ItemClass.itemInSpace("Seaweed_Mustache_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 9
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level23"{
        //10% afroseaweed, 10% seaweed mustache, 30% mossy gold ring, 25% barnacles, 25% 10 booty
        let myNum = randomWithMin(0, 100)
        if myNum > 90{
            let item = ItemClass.itemInSpace("Afro_Seaweed_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 90) && (myNum > 80){
            let item = ItemClass.itemInSpace("Seaweed_Mustache_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 80) && (myNum > 50){
            let item = ItemClass.itemInSpace("Mossy_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 50) && (myNum > 25){
            let item = ItemClass.itemInSpace("Barnacles_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 10
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level24"{
        //50% 10 booty, 25% mossy gold ring, 25% crab claw cap
        let myNum = randomWithMin(0, 100)
        if myNum > 75{
            let item = ItemClass.itemInSpace("Mossy_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 75) && (myNum > 50){
            let item = ItemClass.itemInSpace("Crab_Claw_Cap_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 10
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level25"{
        //20% 10 booty, 50% mossy gold ring, 10% inky ring, 20% king kraken tentacle ring
        let myNum = randomWithMin(0, 100)
        if myNum > 50{
            let item = ItemClass.itemInSpace("Mossy_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 50) && (myNum > 30){
            let item = ItemClass.itemInSpace("King_Kraken_Tentacle_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 30) && (myNum > 20){
            let item = ItemClass.itemInSpace("Inky_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 10
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level26"{
        //40% 10 booty, 15% seashell charm bracelet, 15% seashell necklace, 15% pearlsnap ring, 15% gold ring
        let myNum = randomWithMin(0, 100)
        if myNum > 85{
            let item = ItemClass.itemInSpace("Seashell_Charm_Bracelet_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 85) && (myNum > 70){
            let item = ItemClass.itemInSpace("Seashell_Necklace_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 70) && (myNum > 55){
            let item = ItemClass.itemInSpace("Pearl_Snap_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 55) && (myNum > 40){
            let item = ItemClass.itemInSpace("Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 10
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level27"{
        //50% 10 booty, 25% inky ring, 25% king kraken tentacle ring
        let myNum = randomWithMin(0, 100)
        if myNum > 75{
            let item = ItemClass.itemInSpace("King_Kraken_Tentacle_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 75) && (myNum > 50){
            let item = ItemClass.itemInSpace("Inky_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 10
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }else if level == "level28"{
        //20% afro seaweed, 20% seaweed mustache, 20% seashell charm bracelet, 20% seashell necklace, 20% pearl snap ring
        let myNum = randomWithMin(0, 100)
        if myNum > 80{
            let item = ItemClass.itemInSpace("Afro_Seaweed_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 80) && (myNum > 60){
            let item = ItemClass.itemInSpace("Seaweed_Mustache_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 60) && (myNum > 40){
            let item = ItemClass.itemInSpace("Seashell_Charm_Bracelet_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 40) && (myNum > 20){
            let item = ItemClass.itemInSpace("Seashell_Necklace_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let item = ItemClass.itemInSpace("Pearl_Snap_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    }else if level == "level29"{
        //20% gold ring, 20% afro seaweed, 20% seaweed mustache, 20% seashell charm bracelet, 20% seashell necklace
        let myNum = randomWithMin(0, 100)
        if myNum > 80{
            let item = ItemClass.itemInSpace("Afro_Seaweed_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 80) && (myNum > 60){
            let item = ItemClass.itemInSpace("Seaweed_Mustache_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 60) && (myNum > 40){
            let item = ItemClass.itemInSpace("Seashell_Charm_Bracelet_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 40) && (myNum > 20){
            let item = ItemClass.itemInSpace("Seashell_Necklace_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let item = ItemClass.itemInSpace("Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    //ZACH LOOT DROP**********************
    //GAUNTLET PHASES
    }else if level == "phase1"{
        //10% selected store item, 90% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 98{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 98) && (myNum > 96){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 96) && (myNum > 94){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 94) && (myNum > 92){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 92) && (myNum > 90){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
        
    } else if level == "phase2"{
        //20% selected store item, 80% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 96{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 96) && (myNum > 92){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 92) && (myNum > 88){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 88) && (myNum > 84){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 84) && (myNum > 80){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
        
    } else if level == "phase3"{
        //30% selected store item, 70% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 94{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 94) && (myNum > 88){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 88) && (myNum > 82){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 82) && (myNum > 76){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 76) && (myNum > 70){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
        
    } else if level == "phase4"{
        //40% selected store item, 60% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 92{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 92) && (myNum > 84){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 84) && (myNum > 76){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 76) && (myNum > 68){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 68) && (myNum > 60){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    } else if level == "phase5"{
        //50% selected store item, 50% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 90{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 90) && (myNum > 80){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 80) && (myNum > 70){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 70) && (myNum > 60){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 60) && (myNum > 50){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    } else if level == "phase6"{
        //60% selected store item, 40% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 88{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 88) && (myNum > 76){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 76) && (myNum > 64){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 64) && (myNum > 52){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 52) && (myNum > 40){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    } else if level == "phase7"{
        //70% selected store item, 30% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 86{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 86) && (myNum > 72){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 72) && (myNum > 58){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 58) && (myNum > 44){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 44) && (myNum > 30){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    } else if level == "phase8"{
        //80% selected store item, 20% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 84{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 84) && (myNum > 68){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 68) && (myNum > 52){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 52) && (myNum > 36){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 36) && (myNum > 20){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
        
    } else if level == "phase9"{
        //90% selected store item, 10% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 82{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 82) && (myNum > 64){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 64) && (myNum > 46){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 46) && (myNum > 28){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 28) && (myNum > 10){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
        
    } else if level == "phase10"{
        //100% selected store item
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 80{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 80) && (myNum > 60){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 60) && (myNum > 40){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 40) && (myNum > 20){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
    
    }
    
    else if level == "phase11"{
        //10% T1 item, 45% selected store item, 45% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 91{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 91) && (myNum > 82){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 82) && (myNum > 73){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 73) && (myNum > 64){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 64) && (myNum > 55){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
         
        //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 55) && (myNum > 52){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 52) && (myNum > 49){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 49) && (myNum > 45){
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }
    else if level == "phase12"{
        //20% T1 item, 40% selected store item, 40% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 92{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 92) && (myNum > 84){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 84) && (myNum > 76){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 76) && (myNum > 68){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 68) && (myNum > 60){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
        //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 60) && (myNum > 53){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 53) && (myNum > 46){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 46) && (myNum > 40){
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //****************************************************************************
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }
    else if level == "phase13"{
        //30% T1 item, 35% selected store item, 35% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 93{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 93) && (myNum > 86){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 86) && (myNum > 79){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 79) && (myNum > 72){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 72) && (myNum > 65){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
            //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 65) && (myNum > 55){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 55) && (myNum > 45){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 45) && (myNum > 35){
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //****************************************************************************
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }
    else if level == "phase14"{
        //40% T1 item, 30% selected store item, 30% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 94{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 94) && (myNum > 88){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 88) && (myNum > 82){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 82) && (myNum > 76){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 76) && (myNum > 70){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
            //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 70) && (myNum > 57){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 57) && (myNum > 44){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 44) && (myNum > 30){
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //****************************************************************************
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }
    else if level == "phase15"{
        //50% T1 item, 25% selected store item, 25% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 95{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 95) && (myNum > 90){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 90) && (myNum > 85){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 85) && (myNum > 80){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 80) && (myNum > 75){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
            //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 75) && (myNum > 58){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 58) && (myNum > 41){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 41) && (myNum > 25){
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //****************************************************************************
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }
    else if level == "phase16"{
        //60% T1 item, 20% selected store item, 20% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 96{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 96) && (myNum > 92){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 92) && (myNum > 88){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 88) && (myNum > 84){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 84) && (myNum > 80){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
            //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 80) && (myNum > 60){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 60) && (myNum > 40){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 40) && (myNum > 20){
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //****************************************************************************
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }
    else if level == "phase17"{
        //70% T1 item, 15% selected store item, 15% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 97{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 97) && (myNum > 94){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 94) && (myNum > 91){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 91) && (myNum > 88){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 88) && (myNum > 85){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
            //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 85) && (myNum > 62){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 62) && (myNum > 39){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 39) && (myNum > 15){
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //****************************************************************************
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }
    else if level == "phase18"{
        //80% T1 item, 10% selected store item, 10% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 98{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 98) && (myNum > 96){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 96) && (myNum > 94){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 94) && (myNum > 92){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 92) && (myNum > 90){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
            //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 90) && (myNum > 63){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 63) && (myNum > 36){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 36) && (myNum > 10){
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //****************************************************************************
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }
    else if level == "phase19"{
        //90% T1 item, 5% selected store item, 5% 30 booty
        let myNum = randomWithMin(0, 100)
        
        //*****SELECTED STORE ITEMS (Top Hat, Monocle, Bowtie, Watch, Bling Ring)*****
        if myNum > 99{
            let item = ItemClass.itemInSpace("Top_Hat_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 99) && (myNum > 98){
            let item = ItemClass.itemInSpace("Monocle_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 98) && (myNum > 97){
            let item = ItemClass.itemInSpace("Bow_Tie_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 97) && (myNum > 96){
            let item = ItemClass.itemInSpace("Watch_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 96) && (myNum > 95){
            let item = ItemClass.itemInSpace("Bling_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }//***************************************************************************
            
            //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 95) && (myNum > 65){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 65) && (myNum > 35){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 35) && (myNum > 5){
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //****************************************************************************
        else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 30
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject((scene.userData?.objectForKey("inventory") as! Inventory).gold, forKey: "gold")
            scene.addChild(gold)
        }
    }
    else if level == "phase20"{
        //100% T1 item
        let myNum = randomWithMin(0, 100)
            
            //*****TIER 1 ITEMS***************************************************************
        if (myNum > 67) {
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 67) && (myNum > 34){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //****************************************************************************
    }
    else if level == "phase21"{
        //10% T2 item, 90% T1 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 2 ITEMS***************************************************************
        if (myNum > 97) {
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 97) && (myNum > 94){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 94) && (myNum > 90){
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 90) && (myNum > 60){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 60) && (myNum > 30){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //****************************************************************************
    }
    else if level == "phase22"{
        //20% T2 item, 80% T1 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 2 ITEMS***************************************************************
        if (myNum > 93) {
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 93) && (myNum > 86){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 86) && (myNum > 80){
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 80) && (myNum > 53){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 53) && (myNum > 26){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase23"{
        //30% T2 item, 70% T1 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 2 ITEMS***************************************************************
        if (myNum > 90) {
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 90) && (myNum > 80){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 80) && (myNum > 70){
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 70) && (myNum > 47){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 47) && (myNum > 24){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase24"{
        //40% T2 item, 60% T1 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 2 ITEMS***************************************************************
        if (myNum > 87) {
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 87) && (myNum > 74){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 74) && (myNum > 60){
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 60) && (myNum > 40){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 40) && (myNum > 20){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase25"{
        //50% T2 item, 50% T1 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 2 ITEMS***************************************************************
        if (myNum > 83) {
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 83) && (myNum > 66){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 66) && (myNum > 50){
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 50) && (myNum > 33){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 33) && (myNum > 16){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase26"{
        //60% T2 item, 40% T1 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 2 ITEMS***************************************************************
        if (myNum > 80) {
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 80) && (myNum > 60){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 60) && (myNum > 40){
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 40) && (myNum > 27){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 27) && (myNum > 14){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase27"{
        //70% T2 item, 30% T1 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 2 ITEMS***************************************************************
        if (myNum > 77) {
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 77) && (myNum > 54){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 54) && (myNum > 30){
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 30) && (myNum > 20){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 20) && (myNum > 10){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase28"{
        //80% T2 item, 20% T1 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 2 ITEMS***************************************************************
        if (myNum > 73) {
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 73) && (myNum > 46){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 46) && (myNum > 20){
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 20) && (myNum > 13){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 13) && (myNum > 6){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase29"{
        //90% T2 item, 10% T1 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 2 ITEMS***************************************************************
        if (myNum > 70) {
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 70) && (myNum > 40){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 40) && (myNum > 10){
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 1 ITEMS***************************************************************
        else if (myNum <= 10) && (myNum > 7){
            let item = ItemClass.itemInSpace("Wicked_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 7) && (myNum > 4){
            let item = ItemClass.itemInSpace("Fear_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Dusk_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase30"{
        //100% T2 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 2 ITEMS***************************************************************
        if (myNum > 67) {
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 67) && (myNum > 34){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    }

    
    
    
    else if level == "phase31"{
        //10% T3 item, 90% T2 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 3 ITEMS***************************************************************
        if (myNum > 97) {
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 97) && (myNum > 94){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 94) && (myNum > 90){
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 2 ITEMS***************************************************************
        else if (myNum <= 90) && (myNum > 60){
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 60) && (myNum > 30){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase32"{
        //20% T3 item, 80% T2 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 3 ITEMS***************************************************************
        if (myNum > 93) {
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 93) && (myNum > 86){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 86) && (myNum > 80){
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 2 ITEMS***************************************************************
        else if (myNum <= 80) && (myNum > 53){
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 53) && (myNum > 26){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase33"{
        //30% T3 item, 70% T2 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 3 ITEMS***************************************************************
        if (myNum > 90) {
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 90) && (myNum > 80){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 80) && (myNum > 70){
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 2 ITEMS***************************************************************
        else if (myNum <= 70) && (myNum > 47){
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 47) && (myNum > 24){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase34"{
        //40% T3 item, 60% T2 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 3 ITEMS***************************************************************
        if (myNum > 87) {
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 87) && (myNum > 74){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 74) && (myNum > 60){
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 2 ITEMS***************************************************************
        else if (myNum <= 60) && (myNum > 40){
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 40) && (myNum > 20){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase35"{
        //50% T3 item, 50% T2 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 3 ITEMS***************************************************************
        if (myNum > 83) {
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 83) && (myNum > 66){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 66) && (myNum > 50){
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 2 ITEMS***************************************************************
        else if (myNum <= 50) && (myNum > 33){
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 33) && (myNum > 16){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase36"{
        //60% T3 item, 40% T2 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 3 ITEMS***************************************************************
        if (myNum > 80) {
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 80) && (myNum > 60){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 60) && (myNum > 40){
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 2 ITEMS***************************************************************
        else if (myNum <= 40) && (myNum > 27){
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 27) && (myNum > 14){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase37"{
        //70% T3 item, 30% T2 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 3 ITEMS***************************************************************
        if (myNum > 77) {
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 77) && (myNum > 54){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 54) && (myNum > 30){
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 2 ITEMS***************************************************************
        else if (myNum <= 30) && (myNum > 20){
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 20) && (myNum > 10){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase38"{
        //80% T3 item, 20% T2 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 3 ITEMS***************************************************************
        if (myNum > 73) {
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 73) && (myNum > 46){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 46) && (myNum > 20){
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 2 ITEMS***************************************************************
        else if (myNum <= 20) && (myNum > 13){
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 13) && (myNum > 6){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase39"{
        //90% T3 item, 10% T2 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 3 ITEMS***************************************************************
        if (myNum > 70) {
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 70) && (myNum > 40){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 40) && (myNum > 10){
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 2 ITEMS***************************************************************
        else if (myNum <= 10) && (myNum > 7){
            let item = ItemClass.itemInSpace("Sinister_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 7) && (myNum > 4){
            let item = ItemClass.itemInSpace("Nightmare_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Nightfall_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase40"{
        //100% T3 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 3 ITEMS***************************************************************
        if (myNum > 67) {
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 67) && (myNum > 34){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    }
    else if level == "phase41"{
        //10% T4 item, 90% T3 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 4 ITEMS***************************************************************
        if (myNum > 97) {
            let item = ItemClass.itemInSpace("Lust_Of_Lucifer_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 97) && (myNum > 94){
            let item = ItemClass.itemInSpace("The_Jitters_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 94) && (myNum > 90){
            let item = ItemClass.itemInSpace("Tomorrows_End_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 3 ITEMS***************************************************************
        else if (myNum <= 90) && (myNum > 60){
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 60) && (myNum > 30){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase42"{
        //20% T4 item, 80% T3 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 3 ITEMS***************************************************************
        if (myNum > 93) {
            let item = ItemClass.itemInSpace("Lust_Of_Lucifer_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 93) && (myNum > 86){
            let item = ItemClass.itemInSpace("The_Jitters_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 86) && (myNum > 80){
            let item = ItemClass.itemInSpace("Tomorrows_End_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 2 ITEMS***************************************************************
        else if (myNum <= 80) && (myNum > 53){
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 53) && (myNum > 26){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase43"{
        //30% T4 item, 70% T3 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 4 ITEMS***************************************************************
        if (myNum > 90) {
            let item = ItemClass.itemInSpace("Lust_Of_Lucifer_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 90) && (myNum > 80){
            let item = ItemClass.itemInSpace("The_Jitters_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 80) && (myNum > 70){
            let item = ItemClass.itemInSpace("Tomorrows_End_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 3 ITEMS***************************************************************
        else if (myNum <= 70) && (myNum > 47){
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 47) && (myNum > 24){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase44"{
        //40% T4 item, 60% T3 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 4 ITEMS***************************************************************
        if (myNum > 87) {
            let item = ItemClass.itemInSpace("Lust_Of_Lucifer_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 87) && (myNum > 74){
            let item = ItemClass.itemInSpace("The_Jitters_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 74) && (myNum > 60){
            let item = ItemClass.itemInSpace("Tomorrows_End_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 3 ITEMS***************************************************************
        else if (myNum <= 60) && (myNum > 40){
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 40) && (myNum > 20){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase45"{
        //50% T4 item, 50% T3 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 4 ITEMS***************************************************************
        if (myNum > 83) {
            let item = ItemClass.itemInSpace("Lust_Of_Lucifer_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 83) && (myNum > 66){
            let item = ItemClass.itemInSpace("The_Jitters_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 66) && (myNum > 50){
            let item = ItemClass.itemInSpace("Tomorrows_End_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 3 ITEMS***************************************************************
        else if (myNum <= 50) && (myNum > 33){
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 33) && (myNum > 16){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase46"{
        //60% T4 item, 40% T3 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 4 ITEMS***************************************************************
        if (myNum > 80) {
            let item = ItemClass.itemInSpace("Lust_Of_Lucifer_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 80) && (myNum > 60){
            let item = ItemClass.itemInSpace("The_Jitters_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 60) && (myNum > 40){
            let item = ItemClass.itemInSpace("Tomorrows_End_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 3 ITEMS***************************************************************
        else if (myNum <= 40) && (myNum > 27){
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 27) && (myNum > 14){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase47"{
        //70% T4 item, 30% T3 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 4 ITEMS***************************************************************
        if (myNum > 77) {
            let item = ItemClass.itemInSpace("Lust_Of_Lucifer_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 77) && (myNum > 54){
            let item = ItemClass.itemInSpace("The_Jitters_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 54) && (myNum > 30){
            let item = ItemClass.itemInSpace("Tomorrows_End_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 3 ITEMS***************************************************************
        else if (myNum <= 30) && (myNum > 20){
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 20) && (myNum > 10){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase48"{
        //80% T4 item, 20% T3 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 4 ITEMS***************************************************************
        if (myNum > 73) {
            let item = ItemClass.itemInSpace("Lust_Of_Lucifer_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 73) && (myNum > 46){
            let item = ItemClass.itemInSpace("The_Jitters_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 46) && (myNum > 20){
            let item = ItemClass.itemInSpace("Tomorrows_End_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 3 ITEMS***************************************************************
        else if (myNum <= 20) && (myNum > 13){
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 13) && (myNum > 6){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase49"{
        //90% T4 item, 10% T3 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 4 ITEMS***************************************************************
        if (myNum > 70) {
            let item = ItemClass.itemInSpace("Lust_Of_Lucifer_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 70) && (myNum > 40){
            let item = ItemClass.itemInSpace("The_Jitters_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 40) && (myNum > 10){
            let item = ItemClass.itemInSpace("Tomorrows_End_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
            //*****TIER 3 ITEMS***************************************************************
        else if (myNum <= 10) && (myNum > 7){
            let item = ItemClass.itemInSpace("Insidious_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 7) && (myNum > 4){
            let item = ItemClass.itemInSpace("Insomnia_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Twilight_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
        //****************************************************************************
    }
    else if level == "phase50"{
        //100% T4 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 4 ITEMS***************************************************************
        if (myNum > 67) {
            let item = ItemClass.itemInSpace("Lust_Of_Lucifer_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 67) && (myNum > 34){
            let item = ItemClass.itemInSpace("The_Jitters_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Tomorrows_End_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    }
    else if level == "phase51"{
        //100% T4 item
        let myNum = randomWithMin(0, 100)
        
        //*****TIER 4 ITEMS***************************************************************
        if (myNum > 67) {
            let item = ItemClass.itemInSpace("Lust_Of_Lucifer_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 67) && (myNum > 34){
            let item = ItemClass.itemInSpace("The_Jitters_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let item = ItemClass.itemInSpace("Tomorrows_End_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    }


    
    
}


//returns (m, b)
func getLine(point1: CGPoint, point2: CGPoint)-> (CGFloat, CGFloat){
    let m = (point2.y - point1.y) / (point2.x - point1.x)
    let b = point1.y - (m * point1.x)
    return (m, b)
}

//points start closest to point1, first parameter
func generatePointsOnLine(point1: CGPoint, point2: CGPoint) -> [CGPoint]{
    //calculating distance
    let xDistance = point2.x - point1.x
    let yDistance = point2.y - point1.y
    let distance = sqrt(pow(xDistance, 2) + pow(yDistance, 2))
    //divide by smoothness factor
    let numberOfPoints = distance / CGFloat(smoothnessFactor)
    var xPoints: [CGFloat] = []
    for (var k = 1; CGFloat(k) < numberOfPoints; k = k+1){
        xPoints.append(point1.x + CGFloat(CGFloat(k) * (xDistance / CGFloat(numberOfPoints))))
    }
    //use y=mx+b, find x and b
    let myLine = getLine(point1, point2)
    let m = myLine.0
    let b = myLine.1
    //loop through x values, appending final points
    var points: [CGPoint] = []
    var y: CGFloat?
    for xValue in xPoints{
        y = (m * xValue) + b
        points.append(CGPointMake(xValue, y!))
    }
    return points
}

//returns (entryPoint, exitPoint)
func entryExitPoints(node: SKSpriteNode, startSpot: CGPoint, endSpot: CGPoint)->(CGPoint, CGPoint){
    let myLine = getLine(startSpot, endSpot)
    let m = myLine.0
    let b = myLine.1
    let botY = node.frame.minY
    let topY = node.frame.maxY
    let leftX = node.frame.minX
    let rightX = node.frame.maxX
    if m.isInfinite || b.isInfinite {
        return (CGPointMake(node.frame.midX, node.frame.minY), CGPointMake(node.frame.maxY, node.frame.midX))
    }
    //y=mx+b
    let botXIntersection = (botY - b) / m
    let topXIntersection = (topY - b) / m
    let rightYIntersection = m * rightX + b
    let leftYIntersection = m * leftX + b
    var points: [CGPoint] = []
    //check bot
    if (botXIntersection >= leftX && botXIntersection <= rightX){
        points.append(CGPointMake(botXIntersection, botY))
    }
    //check top
    if (topXIntersection >= leftX && topXIntersection <= rightX){
        points.append(CGPointMake(topXIntersection, topY))
    }
    //check right
    if (rightYIntersection >= botY && rightYIntersection <= topY){
        points.append(CGPointMake(rightX, rightYIntersection))
    }
    //check left
    if (leftYIntersection >= botY && leftYIntersection <= topY){
        points.append(CGPointMake(leftX, leftYIntersection))
    }
    if (points.count != 2){
        //println("Entry/Exit Points function fucked up!")
    }
    //points contains the entry.exit points, return in first, second order
    if (distanceBetween(points[0], startSpot) >= distanceBetween(points[1], startSpot)){
        return (points[1], points[0])
    }else{
        return (points[0], points[1])
    }
}

//get infrontOf position of an SKSpritenode
func infrontOf(theNode: SKSpriteNode, startPos: CGPoint)->CGPoint{
    let entrySpots = entryExitPoints(theNode, startPos, theNode.position)
    return entrySpots.0
}


//returns float of angle in radians, with respect to y = 0, returns -1 if angle = 0
func angleFromPoints(point1: CGPoint, point2: CGPoint) -> CGFloat{
    let xDistance = point2.x - point1.x
    let yDistance = point2.y - point1.y
    let hypot = sqrt(pow(xDistance, 2) + pow(yDistance, 2))
    var angle = acos(xDistance / hypot)
    if (yDistance < 0){
        angle = CGFloat(2 * pi) - angle
    }
    if(angle.isNaN){
        return -1
    }
    return CGFloat(angle)
}

//push point out from a node, based on heros shoulder
func pushPointOut(theNode: SKSpriteNode, corner: CGPoint, selfNode: SKSpriteNode) -> CGPoint{
    let pushDistance = selfNode.frame.maxX - selfNode.frame.midX - 8
    //check Right
    if (corner.x > theNode.position.x){
        //checkTop
        if(corner.y > theNode.position.y){
            return CGPointMake(corner.x + pushDistance, corner.y + pushDistance)
        }else{
            return CGPointMake(corner.x + pushDistance, corner.y - pushDistance)
        }
        //is left then
    }else{
        if(corner.y > theNode.position.y){
            return CGPointMake(corner.x - pushDistance, corner.y + pushDistance)
        }else{
            return CGPointMake(corner.x - pushDistance, corner.y - pushDistance)
        }
    }
}

//func getNodeSpeed(node: SKSpriteNode) -> CGFloat{
//    if node.name == "hero"{
//        return CGFloat(nodeSpeeds.heroSpeed.rawValue)
//    }else{
//        return 0
//    }
//}

func getNodeAngle(node: SKSpriteNode) -> CGFloat{
    if node.name == "hero"{
        let myNode = node as! HeroClass
        return CGFloat(myNode.currentAngle!)
    }else{
        return CGFloat(0)
    }
}

func setAngle(myNode: SKSpriteNode, angle: CGFloat){
    if myNode.name == "hero"{
        let aNode = myNode as! HeroClass
        aNode.currentAngle = angle
    }
}

func getMoveAnimations(myNode: SKSpriteNode)->SKAction{
    if myNode.name == "hero"{
        let textures = [SKTexture(imageNamed: "Kraken_Movement_4.png"),
            SKTexture(imageNamed: "Kraken_Movement_3.png"),
            SKTexture(imageNamed: "Kraken_Movement_2.png"),
            SKTexture(imageNamed: "Kraken_Movement_1.png"),
            SKTexture(imageNamed: "Kraken_Movement_2.png"),
            SKTexture(imageNamed: "Kraken_Movement_3.png"),
            SKTexture(imageNamed: "Kraken_Movement_4.png"),
            SKTexture(imageNamed: "Kraken_Movement_5.png"),
            SKTexture(imageNamed: "Kraken_Movement_11.png"),
            SKTexture(imageNamed: "Kraken_Movement_12.png"),
            SKTexture(imageNamed: "Kraken_Movement_13.png"),
            SKTexture(imageNamed: "Kraken_Movement_14.png"),
            SKTexture(imageNamed: "Kraken_Movement_15.png"),
            SKTexture(imageNamed: "Kraken_Movement_16.png"),
            SKTexture(imageNamed: "Kraken_Movement_6.png"),
            SKTexture(imageNamed: "Kraken_Movement_7.png"),
            SKTexture(imageNamed: "Kraken_Movement_8.png"),
            SKTexture(imageNamed: "Kraken_Movement_9.png"),
            SKTexture(imageNamed: "Kraken_Movement_10.png"),
            SKTexture(imageNamed: "Kraken_Movement_9.png"),
            SKTexture(imageNamed: "Kraken_Movement_8.png"),
            SKTexture(imageNamed: "Kraken_Movement_7.png"),
            SKTexture(imageNamed: "Kraken_Movement_6.png"),
            SKTexture(imageNamed: "Kraken_Movement_16.png"),
            SKTexture(imageNamed: "Kraken_Movement_15.png"),
            SKTexture(imageNamed: "Kraken_Movement_14.png"),
            SKTexture(imageNamed: "Kraken_Movement_13.png"),
            SKTexture(imageNamed: "Kraken_Movement_12.png"),
            SKTexture(imageNamed: "Kraken_Movement_11.png"),
            SKTexture(imageNamed: "Kraken_Movement_5.png")]
        let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        return SKAction.repeatActionForever(animation)
    }
    else {return SKAction()}
}

func getStillTexture(myNode: SKSpriteNode)->SKTexture{
    if myNode.name == "hero"{
        return SKTexture(imageNamed: "Kraken_Movement_5.png")
    }else{return SKTexture()}
}

func moveTo(nodeToMove: SKSpriteNode, startPosition: CGPoint, position: CGPoint)-> SKAction{
    if distanceBetween(startPosition, position) < 5 {
        return SKAction()
    }
    let angle = angleFromPoints(startPosition, position)
    var amountToTurn = CGFloat(angle) - getNodeAngle(nodeToMove)
    if (amountToTurn > pi){
        amountToTurn = amountToTurn - (2 * pi)
    }else if(amountToTurn * -1 > pi){
        amountToTurn = amountToTurn + (2 * pi)
    }
    setAngle(nodeToMove, angle)
    let rotateAction = SKAction.rotateByAngle(CGFloat(amountToTurn), duration: 0.2)
    //start new running animation if not already running
    if (nodeToMove.actionForKey("repeatAction") == nil){
        nodeToMove.runAction(getMoveAnimations(nodeToMove), withKey: "repeatAction")
    }
    if (angle > -1){
        nodeToMove.runAction(rotateAction)
    }
    //do math for time
    let xDistance = position.x - startPosition.x
    let yDistance = position.y - startPosition.y
    var distance = sqrt(pow(xDistance, 2) + pow(yDistance, 2))
    let time = NSTimeInterval(distance / CGFloat(heroSpeed))
    return SKAction.moveTo(position, duration: time)
}

//return the action sequence for simple move type
func getSimpleMove(nodeToMove: SKSpriteNode, position: CGPoint)->SKAction{
    if nodeToMove.name == "hero"{
        let myNode = nodeToMove as! HeroClass
        myNode.isAttacking = false
    }
    let completionBlock = SKAction.runBlock(
        {nodeToMove.removeActionForKey("repeatAction")
            nodeToMove.texture = getStillTexture(nodeToMove)
            (nodeToMove as! HeroClass).isMoving = false
    })
    let moveAction = moveTo(nodeToMove, nodeToMove.position, position)
    let sequence = SKAction.sequence([moveAction, completionBlock])
    return sequence
}

//return action sequence for attackMove
func getAttackMove(nodeToMove: SKSpriteNode, nodeToAttack: SKSpriteNode, wasAttacking: Bool)-> SKAction{
    let spotInfront = infrontOf(nodeToAttack, nodeToMove.position)
    let completionBlock = SKAction.runBlock(
        {nodeToMove.removeActionForKey("repeatAction")
            nodeToMove.texture = getStillTexture(nodeToMove)
            if nodeToMove.name == "hero"{
                let myNode = nodeToMove as! HeroClass
                if nodeToAttack.name == "item" {
                    myNode.isAttacking = false
                    myNode.pickupItem(nodeToAttack as! ItemClass)
                }else if nodeToAttack.name == "gold" {
                    nodeToAttack.removeFromParent()
                }else if nodeToAttack.name == "chest" {
                    myNode.isAttacking = false
                    (nodeToAttack as! TreasureChest).openChest()
                }else{
                    myNode.attack()
                    myNode.isAttacking = true
                }
            }
            (nodeToMove as! HeroClass).isMoving = false
    })
    var sequence: SKAction?
    let moveAction = moveTo(nodeToMove, nodeToMove.position, spotInfront)
    if (wasAttacking && nodeToAttack.name != "item" && nodeToAttack.name != "gold" && nodeToAttack.name != "chest"){
        sequence = SKAction.sequence([completionBlock])
    }else{
        sequence = SKAction.sequence([moveAction, completionBlock])
    }
    return sequence!
}

//return action sequence for aroundMove
func getAroundMove(nodeToMove: SKSpriteNode, clickPoint: CGPoint, nodeToGoAround: SKSpriteNode)-> SKAction{
    if nodeToMove.name == "hero"{
        let myNode = nodeToMove as! HeroClass
        myNode.isAttacking = false
    }
    let cornerSide = getGoAroundCorner(nodeToGoAround, nodeToMove.position, clickPoint)
    let cornerPointPushed = pushPointOut(nodeToGoAround, cornerSide.0, nodeToMove)
    var sequence: SKAction?
    
    // sequence needs to be blocks of codes to 
    if (cornerSide.1){
        //need to move to another corner
        let firstCornerMove = moveTo(nodeToMove, nodeToMove.position, cornerPointPushed)
        let secondCornerPushed = pushPointOut(nodeToGoAround, cornerSide.2, nodeToMove)
        //let secondCornerMove = moveTo(nodeToMove, cornerSide.0, secondCornerPushed)
        //let moveToPoint = moveTo(nodeToMove,cornerSide.2, clickPoint)
        let completionBlock2 = SKAction.runBlock(
            {(nodeToMove as! HeroClass).moveHelper(clickPoint)
                //let runAction = moveTo(nodeToMove,cornerSide.2, clickPoint)
                //let innerComplete = SKAction.runBlock({nodeToMove.removeActionForKey("repeatAction")
                //nodeToMove.texture = getStillTexture(nodeToMove)})
                //nodeToMove.runAction(SKAction.sequence([runAction, innerComplete]), withKey: "runAction")

        })
        let completionBlock1 = SKAction.runBlock(
            {let runAction = moveTo(nodeToMove, cornerSide.0, secondCornerPushed)
                let innerComplete = SKAction.runBlock({nodeToMove.runAction(completionBlock2)})
                nodeToMove.runAction(SKAction.sequence([runAction, innerComplete]), withKey: "runAction")
                (nodeToMove as! HeroClass).isMoving = false
        })
        sequence = SKAction.sequence([firstCornerMove, completionBlock1])
    }else{
        let firstCornerMove = moveTo(nodeToMove, nodeToMove.position, cornerPointPushed)
        //let moveToPoint = moveTo(nodeToMove, cornerSide.0, clickPoint)
        let completionBlock = SKAction.runBlock(
            {(nodeToMove as! HeroClass).moveHelper(clickPoint)
                //nodeToMove.runAction(moveTo(nodeToMove, cornerSide.0, clickPoint), completion: {nodeToMove.removeActionForKey("repeatAction")
                //nodeToMove.texture = getStillTexture(nodeToMove)})
                (nodeToMove as! HeroClass).isMoving = false
        })
        sequence = SKAction.sequence([firstCornerMove, completionBlock])
    }
    return sequence!
}




//this function returns the point closest to spot, such that node's physics body doesn't run into spot
func spotToStop(node: SKSpriteNode, spot: CGPoint) -> CGPoint {
    //calculate line
    let point1 = node.position
    let point2 = spot
    let m = (point2.y - point1.y) / (point2.x - point1.x)
    let b = point1.y - (m * point1.x)
    var otherLineX: CGFloat = 0.0
    var otherLineY: CGFloat = 0.0
    //check top or bottom
    let yAtMaxX = m * node.frame.maxX + b
    let yAtMinX = m * node.frame.minX + b
    //check top
    if ((point2.y > point1.y) && ((yAtMaxX > node.frame.maxY) || (yAtMinX > node.frame.maxY))){
        otherLineY = node.frame.maxY
    }
    //check bot
    else if ((yAtMaxX < node.frame.minY) || (yAtMinX < node.frame.minY)){
        otherLineY = node.frame.minY
    }
    //check left or right
    //checking right first
    else if(point2.x > point1.x){
        otherLineX = node.frame.maxX
    }
    else{
        otherLineX = node.frame.minX
    }
    //find intersection of first line and other line
    //leaving boundary point is set
    var leavingPoint: CGPoint
    if (otherLineX == 0){
        let finalY = otherLineY
        let finalX = (finalY - b) / m
        leavingPoint = CGPointMake(finalX, finalY)
    }
    else{
        let finalX = otherLineX
        let finalY = m * finalX + b
        leavingPoint = CGPointMake(finalX, finalY)
    }
    //calculate distance of leaving point to node
    let xDist = leavingPoint.x - node.position.x
    let yDist = leavingPoint.y - node.position.y
    return CGPointMake(spot.x - xDist, spot.y - yDist)
    
}



//takes in startPoint = heroPosition, clickPoint = touchSpot, entry/exit of enemyNodes frame. Return 1 or 2 corners to run to.
func getGoAroundCorner(enemyNode: SKSpriteNode, startPoint: CGPoint, clickPoint: CGPoint)-> (CGPoint, Bool, CGPoint){
    let entryExit = entryExitPoints(enemyNode, startPoint, clickPoint)
    let upperLeft = CGPointMake(enemyNode.frame.minX, enemyNode.frame.maxY)
    let upperRight = CGPointMake(enemyNode.frame.maxX, enemyNode.frame.maxY)
    let lowerLeft = CGPointMake(enemyNode.frame.minX, enemyNode.frame.minY)
    let lowerRight = CGPointMake(enemyNode.frame.maxX, enemyNode.frame.minY)
    let dummyPoint = CGPointMake(0, 0)
    //check if entered bot
    if(entryExit.0.y == enemyNode.frame.minY){
        //check exit left
        if(entryExit.1.x == enemyNode.frame.minX){
            return (lowerLeft, false, dummyPoint)
        }else if(entryExit.1.x == enemyNode.frame.maxX){
            return (lowerRight, false, dummyPoint)
        }else{
            //its coming out of the top
            //compare going left or right
            let firstLeft = distanceBetween(startPoint, lowerLeft)
            let secondLeft = distanceBetween(upperLeft, clickPoint)
            let firstRight = distanceBetween(startPoint, lowerRight)
            let secondRight = distanceBetween(upperRight, clickPoint)
            //println("left \(firstLeft + secondLeft) right \(firstRight + secondRight)")
            if (firstLeft + secondLeft > firstRight + secondRight){
                return (lowerRight, true, upperRight)
            }else{
                return (lowerLeft, true, upperLeft)
            }
        }
    //^^^^^^^^^^^^^^^TODO left and right side clicked all the way through can't determine which way is faster?
    //check if entered left
    }else if(entryExit.0.x == enemyNode.frame.minX){
        //println("entered left")
        //check exit top
        if(entryExit.1.y == enemyNode.frame.maxY){
            return (upperLeft, false, dummyPoint)
        //check exit bot
        }else if(entryExit.1.y == enemyNode.frame.minY){
            return (lowerLeft, false, dummyPoint)
        }else{
            //its coming out of the right
            //compare going top or bot
            let firstLeft = distanceBetween(startPoint, upperLeft)
            let secondLeft = distanceBetween(upperRight, clickPoint)
            let firstRight = distanceBetween(startPoint, lowerLeft)
            let secondRight = distanceBetween(clickPoint, lowerRight)
            //println("upperLeft: \(upperLeft)")
            //println("lowerLeft: \(lowerLeft)")
            //println("start: \(startPoint)")
            //println("click: \(clickPoint)")
            //println("left \(firstLeft) + secondLeft \(secondLeft) right \(firstRight) + secondRight \(secondRight)")
            if (firstLeft + secondLeft > firstRight + secondRight){
                return (lowerLeft, true, lowerRight)
            }else{
                return (upperLeft, true, upperRight)
            }
        }
    //check if entered right
    }else if(entryExit.0.x == enemyNode.frame.maxX){
        //println("entered right")
        //check exit top
        if(entryExit.1.y == enemyNode.frame.maxY){
            return (upperRight, false, dummyPoint)
            //check exit bot
        }else if(entryExit.1.y == enemyNode.frame.minY){
            return (lowerRight, false, dummyPoint)
        }else{
            //its coming out of the left
            //compare going top or bot
            let firstLeft = distanceBetween(startPoint, lowerRight)
            let secondLeft = distanceBetween(lowerLeft, clickPoint)
            let firstRight = distanceBetween(startPoint, upperRight)
            let secondRight = distanceBetween(upperLeft, clickPoint)
            //println("left \(firstLeft + secondLeft) right \(firstRight + secondRight)")
            if (firstLeft + secondLeft > firstRight + secondRight){
                return (upperRight, true, upperLeft)
            }else{
                return (lowerRight, true, lowerLeft)
            }
        }
    //must have entered top
    }else{
        //println("entered top (nothing else)")
        //check exit left
        if(entryExit.1.x == enemyNode.frame.minX){
            return (upperLeft, false, dummyPoint)
        }else if(entryExit.1.x == enemyNode.frame.maxX){
            return (upperRight, false, dummyPoint)
        }else{
            //its coming out of the top
            //compare going left or right
            let firstLeft = distanceBetween(startPoint, upperRight)
            let secondLeft = distanceBetween(lowerRight, clickPoint)
            let firstRight = distanceBetween(startPoint, upperLeft)
            let secondRight = distanceBetween(lowerLeft, clickPoint)
            //println("left \(firstLeft + secondLeft) right \(firstRight + secondRight)")
            if (firstLeft + secondLeft > firstRight + secondRight){
                return (upperLeft, true, lowerLeft)
            }else{
                return (upperRight, true, lowerRight)
            }
        }
    }
}
