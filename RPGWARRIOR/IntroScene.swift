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
    
    let defaults = NSUserDefaults.standardUserDefaults()
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //ADJUST SOUND VOLUMES HERE
        introMusic.volume = 0.7
        happyMusic.volume = 0.5
        beachMusic.volume = 0.7
        
        
        
        let background = SKSpriteNode(imageNamed: "Opening_Screen_1")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        self.addChild(background)
        
        if let alreadyOpened = defaults.objectForKey("firstOpen") as? Bool {
            if defaults.objectForKey("sound") as! Bool {
                introMusic.play()
            }
        }else{
            introMusic.play()
        }
        
        //find the url within the package
        //sets background music using a NSURL
        //-1 sets loops to infinity
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        var gameplayScene = ZoneScene(size: self.frame.size)
        introMusic.stop()
        if let alreadyOpened = defaults.objectForKey("firstOpen") as? Bool {
            //already opened the app
            let skTransition = SKTransition.fadeWithDuration(1.0)
            self.view?.presentScene(gameplayScene, transition: skTransition)
        }else {
            defaults.setBool(true, forKey: "firstOpen")
            defaults.setBool(true, forKey: "sound")
            defaults.setBool(false, forKey: "beatgame")
            //present tutorial here instead
            let skTransition = SKTransition.fadeWithDuration(1.0)
            let tutorial = TutorialScene(size: self.frame.size)
            self.view?.presentScene(tutorial, transition: skTransition)
        }
    }
}