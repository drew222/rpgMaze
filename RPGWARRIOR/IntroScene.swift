//
//  IntroScene.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 3/8/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import Foundation
import SpriteKit


class IntroScene: SKScene {
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let background = SKSpriteNode(imageNamed: "Opening_Screen_1")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        self.addChild(background)
        //find the url within the package
        //sets background music using a NSURL
        //-1 sets loops to infinity
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let gameplayScene = MainMenuScene(size: self.frame.size)
        let skTransition = SKTransition.fadeWithDuration(1.0)
        self.view?.presentScene(gameplayScene, transition: skTransition)
    }
}