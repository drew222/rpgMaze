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
        if let path = Bundle.main.path(forResource: file as String, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .mappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWith: sceneData as Data)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! GameScene
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
            let url = Bundle.main.url(forResource: "Gauntlet_Music", withExtension: "mp3")
            try gauntletMusic = AVAudioPlayer(contentsOf: url!, fileTypeHint: "mp3")}
        catch{}
        do{
            let url2 = Bundle.main.url(forResource: "Rap_Funk_Music", withExtension: "mp3")
            try happyMusic = AVAudioPlayer(contentsOf: url2!, fileTypeHint: "mp3")
        }catch{}
        do{
            let url3 = Bundle.main.url(forResource: "Beach_Noise", withExtension: "mp3")
            try beachMusic = AVAudioPlayer(contentsOf: url3!, fileTypeHint: "mp3")
        }catch{}
        do{
            let url4 = Bundle.main.url(forResource: "Intro_Music", withExtension: "mp3")
            try introMusic = AVAudioPlayer(contentsOf: url4!, fileTypeHint: nil)
        }catch{}
        do{
            let url5 = Bundle.main.url(forResource: "Level_Music2", withExtension: "mp3")
            try levelMusic = AVAudioPlayer(contentsOf: url5!, fileTypeHint: "mp3")
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
        titleScene!.scaleMode = .resizeFill
            //inventoryScene = Inventory(size: self.view.frame.size)
            skView.presentScene(titleScene)
       // }
    }

    override var shouldAutorotate: Bool {
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
        return [.portrait, .portraitUpsideDown]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
