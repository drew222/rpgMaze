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

enum CollisionBitMasks: UInt32{
    case collisionCategoryHero = 1
    case collisionCategoryProjectile = 2
    case collisionCategoryWizard = 4
    case collisionCategoryGround = 8
}

enum nodeSpeeds: Int{
    case heroSpeed = 125
}

func distanceBetween(point1: CGPoint, point2: CGPoint)-> CGFloat{
    let xDist = point2.x - point1.x
    let yDist = point2.y - point1.y
    return sqrt(pow(xDist, 2) + pow(yDist ,2))
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
    println("Line of generated Points: m = \(m), b = \(b)")
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

func getNodeSpeed(node: SKSpriteNode) -> CGFloat{
    if node.name == "hero"{
        return CGFloat(nodeSpeeds.heroSpeed.rawValue)
    }else{
        return 0
    }
}

func getNodeAngle(node: SKSpriteNode) -> CGFloat{
    if node.name == "hero"{
        let myNode = node as HeroClass
        return CGFloat(myNode.currentAngle!)
    }else{
        return CGFloat(0)
    }
}

func setAngle(myNode: SKSpriteNode, angle: CGFloat){
    if myNode.name == "hero"{
        let aNode = myNode as HeroClass
        aNode.currentAngle = angle
    }
}

func getMoveAnimations(myNode: SKSpriteNode)->SKAction{
    if myNode.name == "hero"{
        let textures = [SKTexture(imageNamed: "walkman2.png"),
            SKTexture(imageNamed: "walkman3.png"),
            SKTexture(imageNamed: "walkman4.png"),
            SKTexture(imageNamed: "walkman5.png"),
            SKTexture(imageNamed: "walkman6.png"),
            SKTexture(imageNamed: "walkman1.png")]
        let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        return SKAction.repeatActionForever(animation)
    }
    else {return SKAction()}
}

func getStillTexture(myNode: SKSpriteNode)->SKTexture{
    if myNode.name == "hero"{
        return SKTexture(imageNamed: "walkman4.png")
    }else{return SKTexture()}
}

func moveTo(nodeToMove: SKSpriteNode, startPosition: CGPoint, position: CGPoint)-> SKAction{
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
    if (nodeToMove.hasActions() == false){
        nodeToMove.runAction(getMoveAnimations(nodeToMove), withKey: "repeatAction")
    }
    if (angle > -1){
        nodeToMove.runAction(rotateAction)
    }
    //do math for time
    let xDistance = position.x - startPosition.x
    let yDistance = position.y - startPosition.y
    var distance = sqrt(pow(xDistance, 2) + pow(yDistance, 2))
    let time = NSTimeInterval(distance / getNodeSpeed(nodeToMove))
    return SKAction.moveTo(position, duration: time)
}

//return the action sequence for simple move type
func getSimpleMove(nodeToMove: SKSpriteNode, position: CGPoint)->SKAction{
    if nodeToMove.name == "hero"{
        let myNode = nodeToMove as HeroClass
        myNode.isAttacking = false
    }
    let completionBlock = SKAction.runBlock(
        {nodeToMove.removeActionForKey("repeatAction")
            nodeToMove.texture = getStillTexture(nodeToMove)
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
                let myNode = nodeToMove as HeroClass
                myNode.attack()
                myNode.isAttacking = true
            }
    })
    var sequence: SKAction?
    let moveAction = moveTo(nodeToMove, nodeToMove.position, spotInfront)
    if (wasAttacking){
        sequence = SKAction.sequence([completionBlock])
    }else{
        sequence = SKAction.sequence([moveAction, completionBlock])
    }
    return sequence!
}

//return action sequence for aroundMove
func getAroundMove(nodeToMove: SKSpriteNode, clickPoint: CGPoint, nodeToGoAround: SKSpriteNode)-> SKAction{
    if nodeToMove.name == "hero"{
        let myNode = nodeToMove as HeroClass
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
        let secondCornerMove = moveTo(nodeToMove, cornerSide.0, secondCornerPushed)
        let moveToPoint = moveTo(nodeToMove,cornerSide.2, clickPoint)
        let completionBlock = SKAction.runBlock(
            {nodeToMove.removeActionForKey("repeatAction")
                nodeToMove.texture = getStillTexture(nodeToMove)
        })
        sequence = SKAction.sequence([firstCornerMove, secondCornerMove, moveToPoint, completionBlock])
    }else{
        let firstCornerMove = moveTo(nodeToMove, nodeToMove.position, cornerPointPushed)
        let moveToPoint = moveTo(nodeToMove, cornerSide.0, clickPoint)
        let completionBlock = SKAction.runBlock(
            {nodeToMove.removeActionForKey("repeatAction")
                nodeToMove.texture = getStillTexture(nodeToMove)
        })
        sequence = SKAction.sequence([firstCornerMove, moveToPoint, completionBlock])
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
