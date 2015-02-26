//
//  Block.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 2/18/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit


class Block: SKSpriteNode {
    
    class func blockAtPosition(position: CGPoint, vertical: Bool) -> Block{
        var size: CGSize?
        if vertical{
            size = CGSizeMake(40,200)
        }else{
            size = CGSizeMake(200,40)
        }
        let block = Block(color: UIColor.blackColor(), size: size!)
        block.position = position
        
        
        return block
        
    }
}
