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
        if picName == "Seaweed_Mustache_1" || picName == "Shades_1" || picName == "Crab_Claw_Cap" || picName == "Coral_Crown_1"{
            return ItemType.weapon
        }else if picName == "Copper_Ring_1" || picName == "Gold_Ring_1" || picName == "Mossy_Copper_Ring_1" || picName == "Mossy_Gold_Ring_1" || picName == "Mossy_Silver_Ring_1" || picName == "Rusty_Copper_Ring_1" || picName == "Rusty_Gold_Ring_1" || picName == "Rusty_Silver_Ring_1" || picName == "Silver_Ring_1"{
            return ItemType.body
        }else if picName == "Bow_Tie_1"{
            //This is a placeholder type
            return ItemType.neck
        }
        return ItemType.weapon
    }
    //weapons have Damage stat, body armor has Life stat, feet armor has Movement stat
    func getItemStats(picName: String)->[(String, CGFloat)]{
        if picName == "Rusty_Copper_Ring_1"{
            price = 1
            return []
        }else if picName == "Mossy_Copper_Ring_1" {
            price = 1
            return [("Movement", CGFloat(1))]
        }else if picName == "Copper_Ring_1"{
            price = 1
            return [("Movement", CGFloat(2))]
        }else if picName == "Rusty_Silver_Ring_1"{
            price = 150
            return [("Life", CGFloat(2))]
        }else if picName == "Mossy_Silver_Ring_1"{
            price = 300
            return [("Movement", CGFloat(5))]
        }else if picName == "Silver_Ring_1"{
            price = 100
            return [("Movement", CGFloat(4))]
        }else if picName == "Rusty_Gold_Ring_1"{
            price = 500
            return [("Life", CGFloat(3))]
        }else if picName == "Mossy_Gold_Ring_1"{
            price = 700
            return [("Movement", CGFloat(7))]
        }else if picName == "Gold_Ring_1"{
            price = 400
            return [("Movement", CGFloat(6))]
            
        }else if picName == "Crab_Claw_Cap_1"{
            price = 50
            return [("Life", CGFloat(1))]
    
            
        
        
        }else if picName == "Shades_1"{
            price = 400
            return [("Life", CGFloat(2))]
        }else if picName == "Coral_Crown_1"{
            price = 1000
            return [("Life", CGFloat(3))]
        }else if picName == "Seaweed_Mustache_1"{
            price = 5000
            return [("Movement", CGFloat(15))]
        }else if picName == "Bow_Tie_1"{
            price = 100
            return [("Regeneration", CGFloat(2))]
        }
            return []
    }
    
}