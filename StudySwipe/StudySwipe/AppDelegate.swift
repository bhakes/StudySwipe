//
//  AppDelegate.swift
//  StudySwipe
//
//  Created by Dillon McElhinney on 7/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let qnc = QuestionNetworkController.shared
        let qfc = CoreDataFetchController()
        
        if Reachability.isConnectedToNetwork(){
//            print("Internet Connection Available!")
            qnc.getQuestions { _,_ in }
            if let newQuestions = qfc.makeTest(with: "TempTest", count: 10)?.questions {
                for _ in newQuestions {
//                    print(q.question ?? "")
                }
            }
            
//            if let correctlyAnsweredQuestions = qfc.getQuestionAnsweredCorrectly() {
//                for c in correctlyAnsweredQuestions {
//                    print(c.answer)
//                }
//            }
            
        }else{
            print("Internet Connection not Available!")
        }
        
        // TODO: Move this somewhere else
        UITabBar.appearance().tintColor = .accentColor
        
        setupTabBarController()
        
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
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    func setupTabBarController() {
        
        // Make the View Controllers
        let reviewVC = ReviewViewController()
        let testSetupVC = TestConfigurationViewController()
        let performanceVC = PerformanceViewController()
        let settingsTVC = SettingsViewController()
        
        let tabBarController = DMCTabBarController()
        
        // Add them to the tab bar controller
        tabBarController.viewControllers = [reviewVC, testSetupVC, performanceVC, settingsTVC]
        
        if let masteryUpdates = loadMasteryUpdatesFromUserDefaults() {
            tabBarController.tabBar.items?[2].badgeValue = "\(masteryUpdates)"
        }
        
        // Set up the tab bar items
        reviewVC.tabBarItem.title = "Study"
        reviewVC.tabBarItem.image = UIImage(named: "literature")
        
        testSetupVC.tabBarItem.title = "Test"
        testSetupVC.tabBarItem.image = UIImage(named: "play")
        
        performanceVC.tabBarItem.title = "Track"
        performanceVC.tabBarItem.image = UIImage(named: "bar_chart")
        
        settingsTVC.tabBarItem.title = "Settings"
        settingsTVC.tabBarItem.image = UIImage(named: "settings")
        
        tabBarController.selectedIndex = 0
        
        // Set up the window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        
        window?.makeKeyAndVisible()
    }
}
