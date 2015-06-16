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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        var gameplayScene = ZoneScene(size: self.frame.size)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let alreadyOpened = defaults.objectForKey("firstOpen") as? Bool {
            //already opened the app
            let skTransition = SKTransition.fadeWithDuration(1.0)
            self.view?.presentScene(gameplayScene, transition: skTransition)
        }else {
            defaults.setBool(true, forKey: "firstOpen")
            defaults.setBool(true, forKey: "sound")
            //present tutorial here instead
            let skTransition = SKTransition.fadeWithDuration(1.0)
            let tutorial = TutorialScene(size: self.frame.size)
            self.view?.presentScene(tutorial, transition: skTransition)
        }
    }
}