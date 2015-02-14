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
        if picName == "noobSword" || picName == "level2sword" || picName == "level3sword" || picName == "level4dagger" || picName == "level6dagger"{
            return ItemType.weapon
        }else if picName == "level1armor" || picName == "level1setarmor" || picName == "level2armor" || picName == "level2setarmor" || picName == "level3armor" || picName == "level3setarmor" || picName == "level4armor" || picName == "level4setarmor"{
            return ItemType.body
        }else if picName == "level1boots" || picName == "level1setboots" || picName == "level2setboots" || picName == "lvevl3setboots" || picName == "level4setboots"{
            return ItemType.feet
        }
        return ItemType.weapon
    }
    //weapons have Damage stat, body armor has Life stat, feet armor has Movement stat
    func getItemStats(picName: String)->[(String, CGFloat)]{
        if picName == "noobSword"{
            return [("Damage", CGFloat(1))]
        }else if picName == "level2sword"{
            return [("Damage", CGFloat(2))]
        }else if picName == "level3sword"{
            return [("Damage", CGFloat(3))]
        }else if picName == "level4dagger" {
            return [("Damage", CGFloat(4))]
        }else if picName == "level6dagger"{
            return [("Damage", CGFloat(6))]
        }else if picName == "level1armor"{
            return [("Life", CGFloat(1))]
        }else if picName == "level2armor"{
            return [("Life", CGFloat(2))]
        }else if picName == "level2setarmor"{
            return [("Life", CGFloat(2))]
        }else if picName == "level3armor"{
            return [("Life", CGFloat(3))]
        }else if picName == "level3setarmor"{
            return [("Life", CGFloat(3))]
        }else if picName == "level4armor"{
            return [("Life", CGFloat(4))]
        }else if picName == "level4setarmor"{
            return [("Life", CGFloat(4))]
        }else if picName == "level1boots"{
            return [("Movement", CGFloat(10))]
        }else if picName == "level1setboots"{
            return [("Movement", CGFloat(10))]
        }else if picName == "level2setboots"{
            return [("Movement", CGFloat(20))]
        }else if picName == "level3setboots"{
            return [("Movement", CGFloat(30))]
        }else if picName == "level4setboots"{
            return [("Movement", CGFloat(40))]
        }
        return []
    }
    
}