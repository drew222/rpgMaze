//
//  TreasureChest.swift
//  RPGWARRIOR
//
//  Created by Cody Witt on 4/5/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit

class TreasureChest: SKSpriteNode {
    var open = false
    
    class func chestAtPosition(position: CGPoint) ->TreasureChest {
        let chest = TreasureChest(imageNamed:"Treasure_Chest_1.png")
        chest.position = position
        chest.name = "chest"
        chest.size = CGSizeMake(65, 65)
        chest.zPosition = 3
        //chest.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //chest.setScale(0.1)
        //chest.setupPhysicsBody()
        //chest.currentAngle = 3 * pi / 2.0
        return chest
        
    }
    
    func openChest() {
        //sound
        if soundOn {
            //let waitAction = SKAction.waitForDuration(0.2)
            //let sequence = SKAction.sequence([bootySound, waitAction, bootySound, waitAction, bootySound, waitAction, bootySound, waitAction, bootySound])
            if let parent = self.parent as? SKScene{
                parent.run(chestSound)
                parent.run(fireworksSound)
            }
        }
        
        open = true
        
        var liteAttack: SKEmitterNode?
        let explodeCode = SKAction.run({let litePath = Bundle.main.path(forResource: "TreasureChestSpark", ofType: "sks")
            liteAttack = (NSKeyedUnarchiver.unarchiveObject(withFile: litePath!) as! SKEmitterNode)
            liteAttack!.position = self.position
            liteAttack!.zPosition = 4
            liteAttack!.setScale(0.5)
            self.parent!.addChild(liteAttack!)
            //self.removeActionForKey("fire")
            //self.texture = nil
        })
        let textures = [SKTexture (imageNamed: "Treasure_Chest_2.png"), SKTexture (imageNamed: "Treasure_Chest_3.png"), SKTexture (imageNamed: "Treasure_Chest_4.png"), SKTexture (imageNamed: "Treasure_Chest_5.png")]
        let chestAnimation = SKAction.animate(with: textures, timePerFrame: 0.15)
        let codeBlock = SKAction.run({
            liteAttack!.removeFromParent()
            self.removeFromParent()})
        let sequence = SKAction.sequence([explodeCode, chestAnimation, codeBlock])
        self.run(sequence)
    }

    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionBitMasks.collisionCategoryChest.rawValue
        self.physicsBody?.collisionBitMask = 0 //CollisionBitMasks.collisionCategoryHero.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMasks.collisionCategoryHero.rawValue
    }
}
