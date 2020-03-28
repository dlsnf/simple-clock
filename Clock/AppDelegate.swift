//
//  AppDelegate.swift
//  Clock
//
//  Created by Nu-Ri Lee on 2017. 4. 3..
//  Copyright © 2017년 nuri lee. All rights reserved.
//

import UIKit
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    //최초 실행 1
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //print("appli");
        
        //UserDefaults.standard.set(UIScreen.main.brightness, forKey: "brightness");
        
        //애드몹
        GADMobileAds.configure(withApplicationID: "ca-app-pub-8919920204791449~8949105750")
        
        
        return true
    }

    //엑티브 떠나기 직전 3
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        //print("willActive");
        
        //UIScreen.main.brightness = UserDefaults.standard.object(forKey: "brightness") as? CGFloat ?? 0.7;
    }

    //백그라운드 진입 4
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //UserDefaults.standard.set(UIScreen.main.brightness, forKey: "brightness");
        
    }

    //백그라운드에서 앱 보여주기 직전 5
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        //print("willForeground");
        
        //UserDefaults.standard.set(UIScreen.main.brightness, forKey: "brightness");
        
        let noti = Notification.init(name : Notification.Name(rawValue: "fore"));
        NotificationCenter.default.post(noti);
        
        
    }

    //엑티브 진입후 2
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //print("didActive");
        //UIScreen.main.brightness = 0.3;
        
    }

    //종료되기 직전
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        //print("willTerminate");
        
        
    }


}

