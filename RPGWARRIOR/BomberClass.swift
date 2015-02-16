//
//  BomberClass.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 2/8/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit


class BomberClass: SKSpriteNode {
    var currentAngle: CGFloat?
    var isDead = false
    var attackSpeed = 0.8
    var life: CGFloat = 2
    
    class func makeBomber(position: CGPoint) -> BomberClass{
        let bomber = BomberClass(imageNamed: "wizard1.png")
        bomber.position = position
        bomber.anchorPoint = CGPointMake(0.5, 0.5)
        bomber.name = "bomber"
        bomber.currentAngle = 3 * pi / 2.0
        var textures: [SKTexture] = []
        for var i = 1; i <= 24; i=i+1{
            textures.append(SKTexture(imageNamed:"wizard\(i)"))
        }
        let animation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatActionForever(animation)
        bomber.runAction(repeatAction)
        bomber.setupPhysicsBody()
        return bomber
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.dynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryWizard.rawValue
        self.physicsBody?.collisionBitMask = 0 //CollisionBitMasks.collisionCategoryHero.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
    
    //fix this bad code
    func getBombLocation(heroPosition: CGPoint)->CGPoint{
        //generate random x and y within a range of the hero
        let xRange = abs(self.position.x - heroPosition.x)
        let yRange = abs(self.position.y - heroPosition.y)
        let lowerXDiff = round(xRange * 0.45)
        let lowerYDiff = round(yRange * 0.45)
        let upperXDiff = round(xRange * 1)
        let upperYDiff = round(yRange * 1)
        let xDiff = CGFloat(randomWithMin(Int(lowerXDiff), Int(upperXDiff)))
        let yDiff = CGFloat(randomWithMin(Int(lowerYDiff), Int(upperYDiff)))
        var xPosition: CGFloat?
        var yPosition: CGFloat?
        if self.position.x > heroPosition.x{
            xPosition = CGFloat(self.position.x - xDiff)
        }else{
            xPosition = CGFloat(self.position.x + xDiff)
        }
        if self.position.y > heroPosition.y{
            yPosition = CGFloat(self.position.y - yDiff)
        }else{
            yPosition = CGFloat(self.position.y + yDiff)
        }
        return CGPointMake(xPosition!, yPosition!)
    }
    
    func throwBomb(){
        if self.isDead{
            return
        }
        //calculate where to shoot the bomb
        let hero = self.parent!.childNodeWithName("hero") as HeroClass
        let shootAtPoint = getBombLocation(hero.position)
        //shoot the fireball
        let bomb = Bomb.bombAtPosition(getBombLocation(hero.position))
        self.parent!.addChild(bomb)
        bomb.explode(bomb.position)
    }
    
    func takeDamage(howMuch: CGFloat){
        self.life -= howMuch
        if (self.life <= 0){
            self.isDead = true
            self.removeAllActions()
            self.texture = nil
        }
    }
}