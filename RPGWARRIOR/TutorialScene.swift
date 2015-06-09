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
    
    let allImages: [SKTexture] = [SKTexture(imageNamed: "Tutorial_Screen_1")]
    var theImage: SKSpriteNode?
    var count = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        theImage = SKSpriteNode()
        theImage!.texture = allImages[count]
        theImage!.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        theImage!.size = CGSize(width: self.frame.width, height: self.frame.height)
        self.addChild(theImage!)
        
        //find the url within the package
        //sets background music using a NSURL
        //-1 sets loops to infinity
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        count++
        if count == allImages.count {
            let gameplayScene = ZoneScene(size: self.frame.size)
            let skTransition = SKTransition.fadeWithDuration(1.0)
            self.view?.presentScene(gameplayScene, transition: skTransition)
        }else{
            theImage!.texture = allImages[count]
        }
    }
}
