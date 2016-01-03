//
//  GameViewController.swift
//  TestRpgGame
//
//  Created by Drew Zoellner on 1/26/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

var levelMusic: AVAudioPlayer?
var gauntletMusic: AVAudioPlayer?
var happyMusic: AVAudioPlayer?
var introMusic: AVAudioPlayer?
var beachMusic: AVAudioPlayer?

class GameViewController: UIViewController {
    
    
    
    var titleScene: SKScene?
    var inventoryScene: Inventory?
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
        let url = NSBundle.mainBundle().URLForResource("Gauntlet_Music", withExtension: "mp3")
            try gauntletMusic = AVAudioPlayer(contentsOfURL: url!, fileTypeHint: "mp3")}
        catch{}
        do{
        let url2 = NSBundle.mainBundle().URLForResource("Rap_Funk_Music", withExtension: "mp3")
        try happyMusic = AVAudioPlayer(contentsOfURL: url2!, fileTypeHint: "mp3")
        }catch{}
        do{
        let url3 = NSBundle.mainBundle().URLForResource("Beach_Noise", withExtension: "mp3")
        try beachMusic = AVAudioPlayer(contentsOfURL: url3!, fileTypeHint: "mp3")
        }catch{}
        do{
        let url4 = NSBundle.mainBundle().URLForResource("Intro_Music", withExtension: "mp3")
        try introMusic = AVAudioPlayer(contentsOfURL: url4!, fileTypeHint: nil)
        }catch{}
        do{
        let url5 = NSBundle.mainBundle().URLForResource("Level_Music2", withExtension: "mp3")
        try levelMusic = AVAudioPlayer(contentsOfURL: url5!, fileTypeHint: "mp3")
        }catch{}
        
        //set isPlus if its an iPhone 6+
        if self.view.frame.maxX == 414.0{
            isPlus = true
        }else if self.view.frame.maxY == 480.0{
            isPad = true
        }
        else if self.view.frame.maxY == 568.0{
            is5 = true
        }
        print("maxX = \(self.view.frame.maxX)")
        print("maxY = \(self.view.frame.maxY)")

      //  if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            titleScene = IntroScene(size: self.view.frame.size)
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            //scene.scaleMode = .AspectFill
            titleScene!.scaleMode = .ResizeFill
            //inventoryScene = Inventory(size: self.view.frame.size)
            skView.presentScene(titleScene)
       // }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }
/*
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
*/
    
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        return [.Portrait, .PortraitUpsideDown]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
