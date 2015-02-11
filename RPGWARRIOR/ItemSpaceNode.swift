//
//  ItemSpaceNode.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 2/9/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit

class ItemSpaceNode: SKSpriteNode {
    var item: ItemClass?
    var wasClicked = false
    var hasItem = false
    
    class func spaceAtPosition(position: CGPoint) -> ItemSpaceNode{
        let space = ItemSpaceNode(color: UIColor.whiteColor(), size: CGSizeMake(40,40))
        space.position = position
        return space
        
    }
    
    func insertItem(anItem: ItemClass){
        self.item = anItem
        self.hasItem = true
        self.item!.position = self.position
        self.item!.size = self.frame.size
        if self.parent!.childNodeWithName(self.item!.name!) != nil{
            self.item!.name = "\(self.item!.name)\(self.name)"
        }
        self.item!.removeFromParent()
        self.parent!.addChild(self.item!)
    }
    
    func removeItem(){
        item = nil
    }
    
    func getItem()-> ItemClass?{
        return item
    }
}