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
    
    let defaults = UserDefaults.standard
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        //ADJUST SOUND VOLUMES HERE
        introMusic!.volume = 0.3
        happyMusic!.volume = 0.3
        beachMusic!.volume = 0.3
        levelMusic!.volume = 0.3
        gauntletMusic!.volume = 0.3
        levelMusic!.numberOfLoops = -1
        introMusic!.numberOfLoops = -1
        beachMusic!.numberOfLoops = -1
        happyMusic!.numberOfLoops = -1
        gauntletMusic!.numberOfLoops = -1
        
        
        
        let background = SKSpriteNode(imageNamed: "Opening_Screen_1")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        self.addChild(background)
        
        if let _ = defaults.object(forKey: "firstOpen") as? Bool {
            if defaults.object(forKey: "sound") as! Bool {
                introMusic!.play()
            }
        }else{
            introMusic!.play()
        }
        
        //find the url within the package
        //sets background music using a NSURL
        //-1 sets loops to infinity
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let gameplayScene = ZoneScene(size: self.frame.size)
        introMusic!.stop()
        if let _ = defaults.object(forKey: "firstOpen") as? Bool {
            //already opened the app
            let skTransition = SKTransition.fade(withDuration: 1.0)
            if uniZoneScene != nil {
                self.view?.presentScene(uniZoneScene!, transition: skTransition)
            }else{
                uniZoneScene = gameplayScene
                self.view?.presentScene(gameplayScene, transition: skTransition)
            }
        }else {
            defaults.set(true, forKey: "firstOpen")
            defaults.set(true, forKey: "sound")
            defaults.set(false, forKey: "beatgame")
            //present tutorial here instead
            let skTransition = SKTransition.fade(withDuration: 1.0)
            let tutorial = TutorialScene(size: self.frame.size)
            self.view?.presentScene(tutorial, transition: skTransition)
        }
    }
}
