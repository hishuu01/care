//
//  AppDelegate.swift
//  care
//
//  Created by yo hishuu on 2018/07/04.
//  Copyright © 2018年 yo hishuu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DataManager.initDB()
        selectTab()
 
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        /*
        if let tabvc = self.window!.rootViewController as? UITabBarController  {
            //各NavigationがRootに戻る
            if let navi0 = tabvc.customizableViewControllers![0] as? UINavigationController {
                navi0.popToRootViewController(animated: false)
            }
            if let navi1 = tabvc.customizableViewControllers![1] as? UINavigationController {
                navi1.popToRootViewController(animated: false)
            }
            if let navi2 = tabvc.customizableViewControllers![2] as? UINavigationController {
                navi2.popToRootViewController(animated: false)
            }
        }*/
        selectTab()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
    
    func selectTab() {
        //再起動時には、時間再計算
        if let tabvc = self.window!.rootViewController as? UITabBarController  {
            let now = Date()
            let cal = Calendar.current
            let comp = cal.dateComponents([.hour], from:now)
            
            if comp.hour! < 12 {
                tabvc.selectedIndex = 0
            }
            else if comp.hour! < 18 {
                tabvc.selectedIndex = 1
            }
            else{
                tabvc.selectedIndex = 2
            }
        }
        
    }
}

