//
//  GameData.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 6/8/15.
//  Copyright (c) 2015 Drew and Zach. All rights reserved.
//

import Foundation

class GameData: NSObject {
    var maxLevel: Int = 1
    var gold: Int = 0
    var headName: String = ""
    var neckName: String = ""
    var leftName: String = ""
    var rightName: String = ""
    var inventoryContents: [String] = []
    
    //class func createNewGameData() -> GameData {
    //    let theGame = GameData()
    //    return theGame
    //}
}
