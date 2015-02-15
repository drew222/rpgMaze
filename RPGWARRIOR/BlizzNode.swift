//
//  BlizzNode.swift
//  RPGWARRIOR
//
//  Created by Tyler Mullins on 2/15/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit

class BlizzNode: SKEmitterNode {
    
    class func blizzAtPos(position: CGPoint) -> SKEmitterNode {
        let blizzPath = NSBundle.mainBundle().pathForResource("BlizzParticle", ofType: "sks")
        let blizz = NSKeyedUnarchiver.unarchiveObjectWithFile(blizzPath!) as SKEmitterNode
        blizz.position = position
        blizz.zPosition = 10
        blizz.name = "Blizzard"
        return blizz
    }
    
    class func blizzContactNode() -> SKSpriteNode {
        let blizzPath = NSBundle.mainBundle().pathForResource("BlizzParticle", ofType: "sks")
        let blizz = NSKeyedUnarchiver.unarchiveObjectWithFile(blizzPath!) as SKEmitterNode
        let blizzContactNode = SKSpriteNode(color: SKColor.blackColor(), size: blizz.frame.size)
        blizzContactNode.zPosition = -2.0
        blizzContactNode.position = blizz.position
        return blizzContactNode
        
    }
    
}
