//
//  GuideScene.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 6/14/15.
//  Copyright (c) 2015 Drew and Zach. All rights reserved.
//

import Foundation
import SpriteKit


class GuideScene: SKScene {
    
    let allImages: [SKTexture] = [SKTexture(imageNamed: "Guide_Screen_1"), SKTexture(imageNamed: "Guide_Screen_2"), SKTexture(imageNamed: "Guide_Screen_3"), SKTexture(imageNamed: "Guide_Screen_6"), SKTexture(imageNamed: "Guide_Screen_7")]
    var theImage: SKSpriteNode?
    var count = 0
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        if soundOn{
            happyMusic!.stop()
        }
        theImage = SKSpriteNode()
        theImage!.texture = allImages[count]
        theImage!.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        theImage!.size = CGSize(width: self.frame.width, height: self.frame.height)
        theImage!.zPosition = 1
        self.addChild(theImage!)
        
        
        //find the url within the package
        //sets background music using a NSURL
        //-1 sets loops to infinity
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for _ in touches{

                count++
                if count == allImages.count {
                    var zoneScene: MainMenuScene
                    zoneScene = self.userData?.object(forKey: "menu") as! MainMenuScene
                    let skTransition = SKTransition.fade(withDuration: 1.0)
                    self.view?.presentScene(zoneScene, transition: skTransition)
                }else{
                    if soundOn {
                        self.run(pageSound)
                    }
                    theImage!.texture = allImages[count]
                }
        }
    }
}

