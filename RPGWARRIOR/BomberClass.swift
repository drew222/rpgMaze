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
    var life: CGFloat = 1
    
    class func makeBomber(position: CGPoint) -> BomberClass{
        let bomber = BomberClass(imageNamed: "Crab_Boss_12")
        bomber.position = position
        bomber.anchorPoint = CGPointMake(0.5, 0.5)
        bomber.name = "bomber"
        bomber.setScale(0.15)
        bomber.currentAngle = 3 * pi / 2.0
        var textures: [SKTexture] = []
        //for var i = 1; i <= 24; i=i+1{
        //    textures.append(SKTexture(imageNamed:"wizard\(i)"))
        //}
        textures.append(SKTexture(imageNamed: "Crab_Boss_12"))
        textures.append(SKTexture(imageNamed: "Crab_Boss_5"))
        textures.append(SKTexture(imageNamed: "Crab_Boss_1"))
        textures.append(SKTexture(imageNamed: "Crab_Boss_2"))
        textures.append(SKTexture(imageNamed: "Crab_Boss_1"))
        textures.append(SKTexture(imageNamed: "Crab_Boss_5"))
        let animation = SKAction.animate(with: textures, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatForever(animation)
        bomber.run(repeatAction)
        bomber.setupPhysicsBody()
        return bomber
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.isDynamic = false
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
        if (xRange == 0 || yRange == 0){
            return CGPointMake(heroPosition.x, heroPosition.y + 80)
        }
        let lowerXDiff = round(xRange * 0.45)
        let lowerYDiff = round(yRange * 0.45)
        let upperXDiff = round(xRange * 1)
        let upperYDiff = round(yRange * 1)
        let xDiff = CGFloat(randomWithMin(min: Int(lowerXDiff), max: Int(upperXDiff)))
        let yDiff = CGFloat(randomWithMin(min: Int(lowerYDiff), max: Int(upperYDiff)))
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
        
        //Gauntlet sends bombs around the hero
        if let _ = self.parent as? World1Level30 {
            xPosition = CGFloat(randomWithMin(min: Int(heroPosition.x - 150), max: Int(heroPosition.x + 150)))
            yPosition = CGFloat(randomWithMin(min: Int(heroPosition.y - 150), max: Int(heroPosition.y + 150)))
        }
        
        return CGPointMake(xPosition!, yPosition!)
    }
    
    func throwBomb(){
        if self.isDead{
            return
        }
        
        let codeBlock0 = SKAction.run({
            var textures: [SKTexture] = []
            //for var i = 1; i <= 4; i=i+1{
               // textures.append(SKTexture(imageNamed:"Clam_Boss_\(i)"))
            //}
            textures.append(SKTexture(imageNamed:"Crab_Boss_2"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_3"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_4"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_6"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_7"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_8"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_9"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_10"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_11"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_10"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_9"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_8"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_7"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_6"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_4"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_3"))
            let animation = SKAction.animate(with: textures, timePerFrame: 0.05)
            let repeatAction0 = SKAction.repeatForever(animation)
            self.run(repeatAction0, withKey: "repeatAction")
        })
        let codeBlock = SKAction.run({
            var textures: [SKTexture] = []
            textures.append(SKTexture(imageNamed: "Crab_Boss_12"))
            textures.append(SKTexture(imageNamed: "Crab_Boss_5"))
            textures.append(SKTexture(imageNamed: "Crab_Boss_1"))
            textures.append(SKTexture(imageNamed: "Crab_Boss_2"))
            textures.append(SKTexture(imageNamed: "Crab_Boss_1"))
            textures.append(SKTexture(imageNamed: "Crab_Boss_5"))
            let animation2 = SKAction.animate(with: textures, timePerFrame: 0.1)
            let sequenceRepeat = SKAction.sequence([animation2])
            let repeatAction = SKAction.repeatForever(sequenceRepeat)
            self.run(repeatAction , withKey: "repeatAction")
            let hero = self.parent!.childNode(withName: "hero") as! HeroClass
            _ = self.getBombLocation(heroPosition: hero.position)
            //shoot the fireball
            let bomb = Bomb.bombAtPosition(position: self.getBombLocation(heroPosition: hero.position))
            self.parent!.addChild(bomb)
            bomb.explode(position: bomb.position)
        })
        let sequence = SKAction.sequence([codeBlock0, SKAction.wait(forDuration: 0.9), codeBlock])
        self.run(sequence)
        
        
        //calculate where to shoot the bomb
        //let hero = self.parent!.childNodeWithName("hero") as HeroClass
        //let shootAtPoint = getBombLocation(hero.position)
        //shoot the fireball
        //let bomb = Bomb.bombAtPosition(getBombLocation(hero.position))
       // self.parent!.addChild(bomb)
        //bomb.explode(bomb.position)
    }
    func throwBeachBall(){
        if self.isDead{
            return
        }
        
        let codeBlock0 = SKAction.run({
            var textures: [SKTexture] = []
            //for var i = 1; i <= 4; i=i+1{
            // textures.append(SKTexture(imageNamed:"Clam_Boss_\(i)"))
            //}
            textures.append(SKTexture(imageNamed:"Crab_Boss_2"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_3"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_4"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_6"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_7"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_8"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_9"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_10"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_11"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_10"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_9"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_8"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_7"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_6"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_4"))
            textures.append(SKTexture(imageNamed:"Crab_Boss_3"))
            let animation = SKAction.animate(with: textures, timePerFrame: 0.05)
            let repeatAction0 = SKAction.repeatForever(animation)
            self.run(repeatAction0, withKey: "repeatAction")
        })
        let codeBlock = SKAction.run({
            var textures: [SKTexture] = []
            textures.append(SKTexture(imageNamed: "Crab_Boss_12"))
            textures.append(SKTexture(imageNamed: "Crab_Boss_5"))
            textures.append(SKTexture(imageNamed: "Crab_Boss_1"))
            textures.append(SKTexture(imageNamed: "Crab_Boss_2"))
            textures.append(SKTexture(imageNamed: "Crab_Boss_1"))
            textures.append(SKTexture(imageNamed: "Crab_Boss_5"))
            let animation2 = SKAction.animate(with: textures, timePerFrame: 0.1)
            let sequenceRepeat = SKAction.sequence([animation2])
            let repeatAction = SKAction.repeatForever(sequenceRepeat)
            self.run(repeatAction , withKey: "repeatAction")
            let hero = self.parent!.childNode(withName: "hero") as! HeroClass
            _ = self.getBombLocation(heroPosition: hero.position)
            //shoot the fireball
            let beachBall = BeachBall.bombAtPosition(position: self.getBombLocation(heroPosition: hero.position))
            self.parent!.addChild(beachBall)
            beachBall.explode(position: beachBall.position)
        })
        let sequence = SKAction.sequence([codeBlock0, SKAction.wait(forDuration: 0.9), codeBlock])
        self.run(sequence)
       
    }

    
    func takeDamage(howMuch: CGFloat){
        if soundOn {
            (self.parent as! SKScene).run(poofSound)
            let waitDuration = SKAction.wait(forDuration: 1)
            let runBlock = SKAction.run({beachMusic!.play()})
            let sequence = SKAction.sequence([waitDuration, runBlock])
            (self.parent as! SKScene).run(sequence)
            levelMusic!.stop()
        }
        self.life -= howMuch
        if (self.life <= 0) && !self.isDead{
            self.isDead = true
            self.removeAllActions()
            var inkAttack: SKEmitterNode?
            let explodeCode = SKAction.run({let litePath = Bundle.main.path(forResource: "SmokeParticle", ofType: "sks")
                inkAttack = (NSKeyedUnarchiver.unarchiveObject(withFile: litePath!) as! SKEmitterNode)
                inkAttack!.position = CGPointMake(self.position.x, self.position.y - 10)
                inkAttack!.zPosition = 4
                inkAttack!.name = "inkAttack"
                inkAttack!.setScale(1)
                self.parent!.addChild(inkAttack!)
            })
            let waitAction = SKAction.wait(forDuration: 1)
            let removeBlock = SKAction.run({
                self.texture = SKTexture(imageNamed: "Crab_Boss_Dead_1")
                inkAttack?.removeFromParent()})
            let sequence = SKAction.sequence([explodeCode, waitAction, removeBlock])
            self.run(sequence)
        }
    }
}
