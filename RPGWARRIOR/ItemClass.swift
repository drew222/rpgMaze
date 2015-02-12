//
//  ItemClass.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 2/9/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit

class ItemClass: SKSpriteNode {
    var itemName: String?
    var itemType: ItemType?
    var itemStats: [(String, CGFloat)]?
    
    class func itemInSpace(nameOfTexture: String) -> ItemClass{
        let item = ItemClass(imageNamed: nameOfTexture)
        item.name = "item"
        item.itemType = item.getItemType(nameOfTexture)
        item.itemName = nameOfTexture
        item.itemStats = item.getItemStats(nameOfTexture)
        item.zPosition = 2
        return item
    }
    
    func statString() -> String{
        var myString = ""
            for stat in itemStats!{
                myString += "\(stat.0):\(stat.1) "
            }
        return myString
    }
    
    func getItemType(picName: String)->ItemType{
        if picName == "noobSword"{
            return ItemType.weapon
        }
        return ItemType.weapon
    }
    //weapons have Damage stat, body armor has Life stat, feet armor has Movement stat
    func getItemStats(picName: String)->[(String, CGFloat)]{
        if picName == "noobSword"{
            return [("Damage", CGFloat(1))]
        }
        return []
    }
    
}