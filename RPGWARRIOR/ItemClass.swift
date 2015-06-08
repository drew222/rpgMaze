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
    
    func getStats() -> [(String, CGFloat)]{
        return itemStats!
    }
   
    
    
    func getItemType(picName: String)->ItemType{
        if  picName == "Shades_1" || picName == "Crab_Claw_Cap_1" || picName == "Coral_Crown_1" || picName == "Top_Hat_1" || picName == "Sunhat_1" || picName == "Sand_Bucket_1" || picName == "Monocle_1" || picName == "Sweatband_1" || picName == "Visor_1" || picName == "Afro_Seaweed_1"{
            return ItemType.weapon
        }else if picName == "Copper_Ring_1" || picName == "Gold_Ring_1" || picName == "Mossy_Copper_Ring_1" || picName == "Mossy_Gold_Ring_1" || picName == "Mossy_Silver_Ring_1" || picName == "Rusty_Copper_Ring_1" || picName == "Rusty_Gold_Ring_1" || picName == "Rusty_Silver_Ring_1" || picName == "Silver_Ring_1" || picName == "Beach_Ball_Fragment_1" || picName == "Seashell_Charm_Bracelet_1" || picName == "Inky_Ring_1" || picName == "Pearl_Snap_Ring_1" || picName == "Watch_1" || picName == "Sweaty_Wristband_1" || picName == "Water_Wing_1" || picName == "Bling_Ring_1" || picName == "Whale_Flesh_Ring_1" || picName == "King_Kraken_Tentacle_Ring_1"
        {
            return ItemType.body
        }else if picName == "Bow_Tie_1" || picName == "Lifejacket_1" || picName == "Pearl_Necklace_1" || picName == "Seashell_Necklace_1" || picName == "Seaweed_Mustache_1" || picName == "Whistle_1" || picName == "Beach_Towel_1" || picName == "Floatie_1" || picName == "Sun_Screen_1" || picName == "Barnacles_1"{
            //This is a placeholder type
            return ItemType.neck
        }
        return ItemType.weapon
    }
    //weapons have Damage stat, body armor has Life stat, feet armor has Movement stat
    func getItemStats(picName: String)->[(String, CGFloat)]{
        //TENTACLE ITEMS
        if picName == "Rusty_Copper_Ring_1"{
            price = 10
            return [("Movement", CGFloat(2))]
        }else if picName == "Mossy_Copper_Ring_1" {
            price = 10
            return [("Movement", CGFloat(4))]
        }else if picName == "Copper_Ring_1"{
            price = 10
            return [("Movement", CGFloat(6))]
        }else if picName == "Sweaty_Wristband_1"{
            price = 15
            return [("Movement", CGFloat(9))]
        }else if picName == "Rusty_Silver_Ring_1"{
            price = 20
            return [("Movement", CGFloat(8))]
        }else if picName == "Mossy_Silver_Ring_1"{
            price = 20
            return [("Movement", CGFloat(10))]
        }else if picName == "Silver_Ring_1"{
            price = 20
            return [("Movement", CGFloat(12))]
        }else if picName == "Water_Wing_1"{
            price = 30
            return [("Movement", CGFloat(15))]
        }else if picName == "Rusty_Gold_Ring_1"{
            price = 50
            return [("Movement", CGFloat(16))]
        }else if picName == "Mossy_Gold_Ring_1"{
            price = 50
            return [("Movement", CGFloat(18))]
        }else if picName == "Gold_Ring_1"{
            price = 50
            return [("Movement", CGFloat(20))]
        }else if picName == "Seashell_Charm_Bracelet_1"{
            price = 25
            return [("Movement", CGFloat(5)), ("Regeneration", CGFloat(1)),("Life", CGFloat(1))]
        }else if picName == "Whale_Flesh_Ring_1"{
            price = 25
            return [("Movement", CGFloat(10)), ("Regeneration", CGFloat(1))]
        }else if picName == "King_Kraken_Tentacle_Ring_1"{
            price = 25
            return [("Life", CGFloat(1)), ("Movement", CGFloat(10))]
        }else if picName == "Inky_Ring_1"{
            price = 50
            return [("Movement", CGFloat(10)), ("Life", CGFloat(2))]
        }else if picName == "Pearl_Snap_Ring_1"{
            price = 50
            return [("Movement", CGFloat(17)), ("Life", CGFloat(1)), ("Regeneration", CGFloat(1))]
        }else if picName == "Watch_1"{
            price = 100
            return [("Movement", CGFloat(12)), ("Life", CGFloat(2)), ("Regeneration", CGFloat(1))]
        }else if picName == "Beach_Ball_Fragment_1"{
            price = 25
            return [("Movement", CGFloat(15))]
        }else if picName == "Bling_Ring_1"{
            price = 200
            return [("Life", CGFloat(3)), ("Regeneration", CGFloat(2)), ("Movement", CGFloat(15))]

            
        //NOGGIN ITEMS
        }else if picName == "Crab_Claw_Cap_1"{
            price = 5
            return [("Movement", CGFloat(1))]
        }else if picName == "Top_Hat_1"{
            price = 200
            return [("Life", CGFloat(3)), ("Regeneration", CGFloat(1)), ("Movement", CGFloat(10))]
        }else if picName == "Sunhat_1"{
            price = 70
            return [("Life", CGFloat(1)), ("Regeneration", CGFloat(1)), ("Movement", CGFloat(5))]
        }else if picName == "Sand_Bucket_1"{
            price = 40
            return [("Life", CGFloat(1)), ("Movement", CGFloat(10))]
        }else if picName == "Monocle_1"{
            price = 200
            return [("Life", CGFloat(2)), ("Regeneration", CGFloat(2)), ("Movement", CGFloat(10))]
        }else if picName == "Coral_Crown_1"{
            price = 25
            return [("Life", CGFloat(1)), ("Movement", CGFloat(5))]
        }else if picName == "Shades_1"{
            price = 100
            return [("Life", CGFloat(2)), ("Movement", CGFloat(7))]
        }else if picName == "Sweatband_1"{
            price = 10
            return [("Movement", CGFloat(5))]
        }else if picName == "Visor_1"{
            price = 20
            return [("Life", CGFloat(1))]
        }else if picName == "Afro_Seaweed_1"{
            price = 25
            return [("Life", CGFloat(1)), ("Regeneration", CGFloat(2))]
            
        
        //NECK ITEMS
        }else if picName == "Lifejacket_1"{
            price = 20
            return [("Movement", CGFloat(5)), ("Regeneration", CGFloat(1))]
        }else if picName == "Pearl_Necklace_1"{
            price = 50
            return [("Movement", CGFloat(15))]
        }else if picName == "Seashell_Necklace_1"{
            price = 50
            return [("Movement", CGFloat(12)), ("Regeneration", CGFloat(1)), ("Life", CGFloat(1))]
        }else if picName == "Whistle_1"{
            price = 10
            return [("Movement", CGFloat(5))]
        }else if picName == "Seaweed_Mustache_1"{
            price = 25
            return [("Regeneration", CGFloat(2)), ("Life", CGFloat(1))]
        }else if picName == "Bow_Tie_1"{
            price = 200
            return [("Movement", CGFloat(10)), ("Regeneration", CGFloat(2)), ("Life", CGFloat(3))]
        }else if picName == "Beach_Towel_1"{
            price = 40
            return [("Movement", CGFloat(17))]
        }else if picName == "Floatie_1"{
            price = 70
            return [("Life", CGFloat(1)), ("Regeneration", CGFloat(2))]
        }else if picName == "Sun_Screen_1"{
            price = 100
            return [("Movement", CGFloat(5)), ("Regeneration", CGFloat(1)), ("Life", CGFloat(2))]
        }else if picName == "Barnacles_1"{
            price = 5
            return [("Regeneration", CGFloat(1))]
    }
            return []
    }
    
}