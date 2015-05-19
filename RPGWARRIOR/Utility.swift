//
//  Utility.swift
//  TestRpgGame
//
//  Created by Drew Zoellner on 1/27/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit



let smoothnessFactor = 1.0
let pi = CGFloat(3.1415927)
var isPlus = false


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
}


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

let allStoreItems = ["Shades_1", "Coral_Crown_1", "Crab_Claw_Cap_1", "Seaweed_Mustache_1", "Copper_Ring_1", "Gold_Ring_1", "Mossy_Copper_Ring_1", "Mossy_Gold_Ring_1", "Mossy_Silver_Ring_1", "Rusty_Copper_Ring_1", "Rusty_Gold_Ring_1", "Rusty_Silver_Ring_1", "Silver_Ring_1", "Bow_Tie_1", "Seashell_Charm_Bracelet_1", "Whale_Flesh_Ring_1", "King_Kraken_Tentacle_1", "Inky_Ring_1", "Pearl_Snap_Ring_1", "Watch_1", "Beach_Ball_Fragment_1", "Lifejacket_1", "Pearl_Necklace_1", "Whistle_1", "Top_Hat_1", "Sunhat_1", "Sand_Bucket_1", "Monocle_1", "Seashell_Necklace_1"]


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
        println("myNum: \(myNum)")
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
            scene.addChild(gold)
        }
    }
    else if level == "level2"{
        //50% 1 booty, 50% rusty copper ring
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
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
            scene.addChild(gold)
        }
    }else if level == "level3"{
        //75% booty, 25% mossy copper ring
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
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
            scene.addChild(gold)
        }
    }
    else if level == "level4"{
        //50% mossy copper ring, 50% 1 booty
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum < 50{
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
            scene.addChild(gold)
        }
    }else if level == "level5"{
        //5% beachball fragment ring, 45% mossy copper ring, 50% 2 booty
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 95{
            let item = ItemClass.itemInSpace("Beachball_Fragment_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 95) && (myNum > 45){
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 2
            scene.addChild(gold)
        } else {
            let item = ItemClass.itemInSpace("Mossy_Copper_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    }else if level == "level6"{
        //25% crab claw cap, 25% mossy copper ring, 50% 2 booty
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 75{
            let item = ItemClass.itemInSpace("Crab_Claw_Cap_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 75) && (myNum > 25){
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 2
            scene.addChild(gold)
        } else {
            let item = ItemClass.itemInSpace("Mossy_Copper_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    }else if level == "level7"{
        //25% copper ring, 75% 3 booty
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 75{
            let item = ItemClass.itemInSpace("Copper_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 3
            scene.addChild(gold)
        }
    }else if level == "level8"{
        //10% beach ball fragment, 15% copper ring, 75% 3 booty
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 90{
            let item = ItemClass.itemInSpace("Beachball_Fragment_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 90) && (myNum > 15){
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 3
            scene.addChild(gold)
        } else {
            let item = ItemClass.itemInSpace("Copper_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    }else if level == "level9"{
        //25% crab claw cap, 10% beach ball fragment, 65% 3 booty
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 75{
            let item = ItemClass.itemInSpace("Crab_Claw_Cap_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else if (myNum <= 75) && (myNum > 10){
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 3
            scene.addChild(gold)
        } else {
            let item = ItemClass.itemInSpace("Beachball_Fragment_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }
    }else if level == "level10"{
        //25% copper ring, 75% 3 booty
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 75{
            let item = ItemClass.itemInSpace("Copper_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 3
            scene.addChild(gold)
        }
    }else if level == "level11"{
        //10% pearl necklace, 15% rusty silver ring, 75% 4 booty
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 90{
            let item = ItemClass.itemInSpace("Pearl_Necklace_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 90) && (myNum > 75){
            let item = ItemClass.itemInSpace("Rusty_Silver_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 4
            scene.addChild(gold)
        }
    }else if level == "level12"{
        //5% whale flesh ring, 20% rusty silver ring, 75% 4 booty
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 95{
            let item = ItemClass.itemInSpace("Whale_Flesh_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 95) && (myNum > 75){
            let item = ItemClass.itemInSpace("Rusty_Silver_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 4
            scene.addChild(gold)
        }
    }else if level == "level13"{
        //50% coral crown, 50% 5 booty
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 50{
            let item = ItemClass.itemInSpace("Coral_Crown_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 5
            scene.addChild(gold)
        }
    }else if level == "level14"{
        //10% whale flesh ring, 15% rusty silver ring, 75% 5 booty
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 90{
            let item = ItemClass.itemInSpace("Whale_Flesh_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else if (myNum <= 90) && (myNum > 75){
            let item = ItemClass.itemInSpace("Rusty_Silver_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        }else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 5
            scene.addChild(gold)
        }
    }else if level == "level15"{
        //25% mossy silver ring, 75% 6 booty
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 75{
            let item = ItemClass.itemInSpace("Mossy_Silver_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 6
            scene.addChild(gold)
        }
    }else if level == "level16"{
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            scene.addChild(gold)
        }
    }else if level == "level17"{
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            scene.addChild(gold)
        }
    }else if level == "level18"{
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            scene.addChild(gold)
        }
    }else if level == "level19"{
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            scene.addChild(gold)
        }
    }else if level == "level20"{
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            scene.addChild(gold)
        }
    }else if level == "level21"{
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            scene.addChild(gold)
        }
    }else if level == "level22"{
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            scene.addChild(gold)
        }
    }else if level == "level23"{
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            scene.addChild(gold)
        }
    }else if level == "level24"{
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            scene.addChild(gold)
        }
    }else if level == "level25"{
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            scene.addChild(gold)
        }
    }else if level == "level26"{
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            scene.addChild(gold)
        }
    }else if level == "level27"{
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            scene.addChild(gold)
        }
    }else if level == "level28"{
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            scene.addChild(gold)
        }
    }else if level == "level29"{
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            scene.addChild(gold)
        }
    }else if level == "level30"{
        let myNum = randomWithMin(0, 100)
        println("myNum: \(myNum)")
        if myNum > 50{
            let item = ItemClass.itemInSpace("Rusty_Gold_Ring_1")
            item.position = position
            item.size = size
            scene.addChild(item)
        } else {
            let gold = SKSpriteNode(imageNamed: "Booty_1")
            gold.name = "gold"
            gold.position = position
            gold.size = size
            (scene.userData?.objectForKey("inventory") as! Inventory).gold += 1
            scene.addChild(gold)
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
    //println("111")
    let distance = sqrt(pow(xDistance, 2) + pow(yDistance, 2))
    //divide by smoothness factor
    let numberOfPoints = distance / CGFloat(smoothnessFactor)
    var xPoints: [CGFloat] = []
    for (var k = 1; CGFloat(k) < numberOfPoints; k = k+1){
        xPoints.append(point1.x + CGFloat(CGFloat(k) * (xDistance / CGFloat(numberOfPoints))))
    }
    //println("222")
    //use y=mx+b, find x and b
    let myLine = getLine(point1, point2)
    let m = myLine.0
    let b = myLine.1
    //println("Line of generated Points: m = \(m), b = \(b)")
    //loop through x values, appending final points
    var points: [CGPoint] = []
    //println("333")
    var y: CGFloat?
    for xValue in xPoints{
        y = (m * xValue) + b
        //println("x: \(xValue) y: \(y!)")
        points.append(CGPointMake(xValue, y!))
    }
    //println("444")
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
    //y=mx+b
    let botXIntersection = (botY - b) / m
    let topXIntersection = (topY - b) / m
    let rightYIntersection = m * rightX + b
    let leftYIntersection = m * leftX + b
    var points: [CGPoint] = []
    //check bot
    if (botXIntersection >= leftX && botXIntersection <= rightX){
        points.append(CGPointMake(botXIntersection, botY))
        // println("got bot")
    }
    //check top
    if (topXIntersection >= leftX && topXIntersection <= rightX){
        points.append(CGPointMake(topXIntersection, topY))
        //println("got top")
    }
    //check right
    if (rightYIntersection >= botY && rightYIntersection <= topY){
        points.append(CGPointMake(rightX, rightYIntersection))
        //println("got right")
    }
    //check left
    if (leftYIntersection >= botY && leftYIntersection <= topY){
        points.append(CGPointMake(leftX, leftYIntersection))
        //println("got left")
    }
    if (points.count != 2){
        println("Entry/Exit Points function fucked up!")
        println("m = \(m)")
        println("b = \(b)")
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
    //println("xDist: \(xDistance)")
    //println("yDist: \(yDistance)")
    let hypot = sqrt(pow(xDistance, 2) + pow(yDistance, 2))
    //println("hypot: \(hypot)")
    var angle = acos(xDistance / hypot)
    if (yDistance < 0){
        angle = CGFloat(2 * pi) - angle
    }
    //println(angle)
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
                }else{
                    myNode.attack()
                    myNode.isAttacking = true
                }
            }
            (nodeToMove as! HeroClass).isMoving = false
    })
    var sequence: SKAction?
    let moveAction = moveTo(nodeToMove, nodeToMove.position, spotInfront)
    if (wasAttacking && nodeToAttack.name != "item" && nodeToAttack.name != "gold"){
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
        //println("entered bot")
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
