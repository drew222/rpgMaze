//
//  MineThrowerNode.swift
//  ThrowMine
//
//  Created by Tyler Mullins on 2/2/15.
//  Copyright (c) 2015 Tyler Mullins. All rights reserved.
//

import Foundation
import SpriteKit

class MineThrowerNode: SKSpriteNode  {

    var isDead = false
    var life: CGFloat = 2
    
    
    class func mineThrowerAtPos(position: CGPoint) -> MineThrowerNode {
    let mineThrower = MineThrowerNode(imageNamed: "wizard1.png")
        mineThrower.position = position
        mineThrower.name = "MineThrower"
        return mineThrower
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



