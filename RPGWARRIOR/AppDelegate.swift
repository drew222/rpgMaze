//
//  AppDelegate.swift
//  TestRpgGame
//
//  Created by Drew Zoellner on 1/26/15.
//  Copyright (c) 2015 Drew Zoellner. All rights reserved.
//

import UIKit
import CoreData
import SpriteKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var happyStopped = false
    var gauntletStopped = false
    var beachStopped = false
    var introStopped = false
    var levelStopped = false


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        let gamecontroller = window?.rootViewController as! GameViewController
        
        if gamecontroller.happyMusic!.playing {
            gamecontroller.happyMusic!.stop()
            happyStopped = true
        }
        if gamecontroller.gauntletMusic!.playing {
            gamecontroller.gauntletMusic!.stop()
            gauntletStopped = true
        }
        if gamecontroller.beachMusic!.playing {
            gamecontroller.beachMusic!.stop()
        }
        if gamecontroller.introMusic!.playing {
            gamecontroller.introMusic!.stop()
            introStopped = true
        }
        if gamecontroller.levelMusic!.playing {
            gamecontroller.levelMusic!.stop()
        }
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        let gamecontroller = window?.rootViewController as! GameViewController
        let view = gamecontroller.view as! SKView
        if (view.scene as? Inventory != nil) || (view.scene as? MainMenuScene != nil) || (view.scene as? IntroScene != nil) || (view.scene as? StoreScene != nil) || (view.scene as? GuideScene != nil) || (view.scene as? TutorialScene != nil) || (view.scene as? ZoneScene != nil) || (view.scene as? ItemDisplayScene != nil){
            if happyStopped {
                gamecontroller.happyMusic!.play()
                happyStopped = false
            }
            if gauntletStopped {
                gamecontroller.gauntletMusic!.play()
                gauntletStopped = false
            }
            if introStopped {
                gamecontroller.introMusic!.play()
                introStopped = false
            }
            
        }else{
            view.presentScene(gamecontroller.titleScene)
        }
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        /*
        let gamecontroller = window?.rootViewController as! GameViewController
        let view = gamecontroller.view as! SKView
        if (view.scene as? Inventory != nil) || (view.scene as? MainMenuScene != nil) || (view.scene as? IntroScene != nil) || (view.scene as? StoreScene != nil) || (view.scene as? GuideScene != nil) || (view.scene as? TutorialScene != nil) || (view.scene as? ZoneScene != nil) || (view.scene as? ItemDisplayScene != nil){
            if happyStopped {
                happyMusic.play()
                happyStopped = false
            }
            if gauntletStopped {
                gauntletMusic.play()
                gauntletStopped = false
            }
            if introStopped {
                introMusic.play()
                introStopped = false
            }
            
        }else{
            view.presentScene(gamecontroller.titleScene)
        }
        */
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        //self.saveContext()
    }
    
    // MARK: - Core Data stack
    /*
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "doesn-texist.com.CoreDataAppTest" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as! NSURL
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("CoreDataAppTest", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("CoreDataAppTest.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }

    */


}

