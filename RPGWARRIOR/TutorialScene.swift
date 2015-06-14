//
//  TutorialScene.swift
//  RPGWARRIOR
//
//  Created by Drew Zoellner on 6/9/15.
//  Copyright (c) 2015 Drew and Zach. All rights reserved.
//

import Foundation
import SpriteKit


class TutorialScene: SKScene {
    
    let allImages: [SKTexture] = [SKTexture(imageNamed: "Tutorial_Screen_1"), SKTexture(imageNamed: "Tutorial_Screen_19"), SKTexture(imageNamed: "Tutorial_Screen_2"), SKTexture(imageNamed: "Tutorial_Screen_3"), SKTexture(imageNamed: "Tutorial_Screen_4"), SKTexture(imageNamed: "Tutorial_Screen_5"), SKTexture(imageNamed: "Tutorial_Screen_7"), SKTexture(imageNamed: "Tutorial_Screen_8"), SKTexture(imageNamed: "Tutorial_Screen_6"), SKTexture(imageNamed: "Tutorial_Screen_11"), SKTexture(imageNamed: "Tutorial_Screen_21"), SKTexture(imageNamed: "Tutorial_Screen_12"), SKTexture(imageNamed: "Tutorial_Screen_13"), SKTexture(imageNamed: "Tutorial_Screen_9"), SKTexture(imageNamed: "Tutorial_Screen_10"), SKTexture(imageNamed: "Tutorial_Screen_17"), SKTexture(imageNamed: "Tutorial_Screen_14"), SKTexture(imageNamed: "Tutorial_Screen_15"), SKTexture(imageNamed: "Tutorial_Screen_16"), SKTexture(imageNamed: "Tutorial_Screen_18"), SKTexture(imageNamed: "Tutorial_Screen_20")]
    var theImage: SKSpriteNode?
    var count = 0
    var skipButton: SKSpriteNode?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theImage = SKSpriteNode()
        theImage!.texture = allImages[count]
        theImage!.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        theImage!.size = CGSize(width: self.frame.width, height: self.frame.height)
        theImage!.zPosition = 1
        self.addChild(theImage!)
        
        skipButton = SKSpriteNode(imageNamed: "Skip_Tutorial_Button_1")
        skipButton!.size = CGSizeMake(70, 70)
        skipButton!.position = CGPointMake(35, self.frame.maxY - 35)
        skipButton!.zPosition = 2
        self.addChild(skipButton!)
        
        //find the url within the package
        //sets background music using a NSURL
        //-1 sets loops to infinity
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in touches{
            if skipButton!.containsPoint((touch as! UITouch).locationInNode(self)){
                let skTransition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(self.userData?.objectForKey("zoneScene") as? ZoneScene, transition: skTransition)
            }else{
                count++
                if count == allImages.count {
                    var zoneScene: ZoneScene?
                    if let aZoneScene = self.userData?.objectForKey("zoneScene") as? ZoneScene{
                        zoneScene = aZoneScene
                    }else{
                        zoneScene = ZoneScene(size: self.frame.size)
                    }
                    let skTransition = SKTransition.fadeWithDuration(1.0)
                    self.view?.presentScene(zoneScene, transition: skTransition)
                }else{
                    theImage!.texture = allImages[count]
                }
            }
        }
    }
}
