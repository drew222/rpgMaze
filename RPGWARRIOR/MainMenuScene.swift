//
//  MainMenuScene.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 2/8/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import SpriteKit

//import AVFoundation

class MainMenuScene: SKScene {
    var level1Node: SKLabelNode?
    var level2Node: SKLabelNode?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = UIColor.blueColor()
        level1Node = SKLabelNode.init(text: "Level 1")
        level1Node!.position = CGPointMake(self.frame.midX, self.frame.midY - 10)
        level1Node!.name = "level1"
        self.addChild(level1Node!)
        
        level2Node = SKLabelNode.init(text: "Level 2")
        level2Node!.position = CGPointMake(self.frame.midX, self.frame.midY - 60)
        level2Node!.name = "level2"
        self.addChild(level2Node!)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches{
            if level1Node!.containsPoint(touch.locationInNode(self)){
                let gameplayScene = GameScene(size: self.frame.size)
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(gameplayScene, transition: skTransition)
            }else if level2Node!.containsPoint(touch.locationInNode(self)){
                let level2 = Level2Scene(size: self.frame.size)
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(level2, transition: skTransition)
            }
        }
    }
}