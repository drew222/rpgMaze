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
    
    let allImages: [SKTexture] = [SKTexture(imageNamed: "Quick_Tutorial_Screen_1"), SKTexture(imageNamed: "Quick_Tutorial_Screen_2"), SKTexture(imageNamed: "Quick_Tutorial_Screen_3"), SKTexture(imageNamed: "Quick_Tutorial_Screen_5"), SKTexture(imageNamed: "Quick_Tutorial_Screen_6"), SKTexture(imageNamed: "Tutorial_Screen_7"), SKTexture(imageNamed: "Tutorial_Screen_8"), SKTexture(imageNamed: "Tutorial_Screen_11"), SKTexture(imageNamed: "Tutorial_Screen_21"), SKTexture(imageNamed: "Tutorial_Screen_12"), SKTexture(imageNamed: "Tutorial_Screen_13"), SKTexture(imageNamed: "Tutorial_Screen_9"), SKTexture(imageNamed: "Tutorial_Screen_10"), SKTexture(imageNamed: "Tutorial_Screen_17"), SKTexture(imageNamed: "Tutorial_Screen_14"), SKTexture(imageNamed: "Tutorial_Screen_15"), SKTexture(imageNamed: "Tutorial_Screen_16"), SKTexture(imageNamed: "Tutorial_Screen_18"), SKTexture(imageNamed: "Tutorial_Screen_20")]
    var theImage: SKSpriteNode?
    var count = 0
    var skipButton: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        if soundOn{
            happyMusic!.stop()
        }
        /* Setup your scene here */
        theImage = SKSpriteNode()
        theImage!.texture = allImages[count]
        theImage!.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        theImage!.size = CGSize(width: self.frame.width, height: self.frame.height)
        theImage!.zPosition = 1
        self.addChild(theImage!)
        
        skipButton = SKSpriteNode(imageNamed: "Skip_Tutorial_Button_1")
        skipButton!.size = CGSizeMake(100, 100)
        if is5{
           skipButton!.size = CGSizeMake(80, 80)
        } else if isPad{
            skipButton!.size = CGSizeMake(70, 70)
        }
        skipButton!.position = CGPointMake(self.frame.minX + 55, self.frame.minY + 55)
        if is5{
            skipButton!.position = CGPointMake(self.frame.minX + 45, self.frame.minY + 45)
        } else if isPad{
            skipButton!.position = CGPointMake(self.frame.minX + 40, self.frame.minY + 40)
        }
        skipButton!.zPosition = 2
        self.addChild(skipButton!)
        
        //find the url within the package
        //sets background music using a NSURL
        //-1 sets loops to infinity
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            if skipButton!.contains((touch ).location(in: self)){
                if soundOn {
                    self.run(clickSound)
                }
                let skTransition = SKTransition.fade(withDuration: 1.0)
                var zoneScene: ZoneScene?
                if let aZoneScene = self.userData?.object(forKey: "zoneScene") as? ZoneScene{
                    zoneScene = aZoneScene
                }else{
                    zoneScene = ZoneScene(size: self.frame.size)
                }
                self.view?.presentScene(zoneScene!, transition: skTransition)
            }else{
                count+=1
                if count == allImages.count {
                    var zoneScene: ZoneScene?
                    if let aZoneScene = self.userData?.object(forKey: "zoneScene") as? ZoneScene{
                        zoneScene = aZoneScene
                    }else{
                        zoneScene = ZoneScene(size: self.frame.size)
                    }
                    let skTransition = SKTransition.fade(withDuration: 1.0)
                    self.view?.presentScene(zoneScene!, transition: skTransition)
                }else{
                    if soundOn {
                        self.run(pageSound)
                    }
                    theImage!.texture = allImages[count]
                }
            }
        }
    }
}
