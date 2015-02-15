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
    var price: CGFloat?
    
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
        }else if picName == "level1boots" || picName == "level1setboots" || picName == "level2setboots" || picName == "level3setboots" || picName == "level4setboots"{
            return ItemType.feet
        }
        return ItemType.weapon
    }
    //weapons have Damage stat, body armor has Life stat, feet armor has Movement stat
    func getItemStats(picName: String)->[(String, CGFloat)]{
        if picName == "noobSword"{
            price = 0
            return [("Damage", CGFloat(1))]
        }else if picName == "level2sword"{
            price = 40
            return [("Damage", CGFloat(2))]
        }else if picName == "level3sword"{
            price = 100
            return [("Damage", CGFloat(3))]
        }else if picName == "level4dagger" {
            price = 250
            return [("Damage", CGFloat(4))]
        }else if picName == "level6dagger"{
            price = 1000
            return [("Damage", CGFloat(6))]
        }else if picName == "level1armor"{
            price = 15
            return [("Life", CGFloat(1))]
        }else if picName == "level1setarmor"{
            price = 15
            return [("Life", CGFloat(1))]
        }else if picName == "level2armor"{
            price = 40
            return [("Life", CGFloat(2))]
        }else if picName == "level2setarmor"{
            price = 40
            return [("Life", CGFloat(2))]
        }else if picName == "level3armor"{
            price = 100
            return [("Life", CGFloat(3))]
        }else if picName == "level3setarmor"{
            price = 100
            return [("Life", CGFloat(3))]
        }else if picName == "level4armor"{
            price = 250
            return [("Life", CGFloat(4))]
        }else if picName == "level4setarmor"{
            price = 250
            return [("Life", CGFloat(4))]
        }else if picName == "level1boots"{
            price = 15
            return [("Movement", CGFloat(10))]
        }else if picName == "level1setboots"{
            price = 15
            return [("Movement", CGFloat(10))]
        }else if picName == "level2setboots"{
            price = 40
            return [("Movement", CGFloat(20))]
        }else if picName == "level3setboots"{
            price = 100
            return [("Movement", CGFloat(30))]
        }else if picName == "level4setboots"{
            price = 250
            return [("Movement", CGFloat(40))]
        }
        return []
    }
    
}