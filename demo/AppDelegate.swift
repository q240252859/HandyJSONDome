//
//  AppDelegate.swift
//  demo
//
//  Created by luoming on 2019/12/3.
//  Copyright © 2019 SingleVideo. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import ESTabBarController_swift
import SnapKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var ATOPTabBarC : CYLTabBarController = {
        let tab = CYLTabBarController()
        
        let images = ["menu_ico_home","menu_ico_market","menu_ico_trans","menu_ico_asset","menu_ico_user"]
        let imagesel = ["menu_ico_home_active","menu_ico_market_active","menu_ico_trans_active","menu_ico_asset_active","menu_ico_user_active"]
        let titleArr = ["首页","行情","交易","财务","我的"]
        
        var taBarItemArr   = [] as! [Dictionary<String, Any>]
        
        for (i,srr) in images.enumerated(){
            let dic :Dictionary = [CYLTabBarItemTitle:titleArr[i],CYLTabBarItemImage:images[i],CYLTabBarItemSelectedImage:imagesel[i]]
            taBarItemArr.append(dic)
        }
        
        
        
        
        
        tab.tabBarItemsAttributes = taBarItemArr
        tab.setViewControllers([HoemViewController(),HoemViewController(),HoemViewController(),HoemViewController(),HoemViewController()], animated: true)
        return tab
    }()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        
        let tabBarController = ESTabBarController()
        let v1 = ViewController()
        let v2 = HoemViewController()
        let v3 = HoemViewController()
        let v4 = HoemViewController()
        let v5 = HoemViewController()
        
        /// MARK: 原生和系统混和设置  不常见
        v1.tabBarItem = UITabBarItem.init(title: "1", image: UIImage(named: "menu_ico_home"), selectedImage: UIImage(named: "menu_ico_home_active"))
        
        
        v2.tabBarItem = ESTabBarItem.init(title: "2", image: UIImage(named: "menu_ico_market")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "menu_ico_market_active"))
        v3.tabBarItem = ESTabBarItem.init(title: "3", image: UIImage(named: "menu_ico_trans"), selectedImage: UIImage(named: "menu_ico_trans_active"))
        v4.tabBarItem = ESTabBarItem.init(title: "4", image: UIImage(named: "menu_ico_asset"), selectedImage: UIImage(named: "menu_ico_asset_active"))
        v5.tabBarItem = ESTabBarItem.init(title: "5", image: UIImage(named: "menu_ico_user"), selectedImage: UIImage(named: "menu_ico_user_active")?.withRenderingMode(.alwaysOriginal))
        
//        UITabBar.appearance().tintColor = UIColor.red;
        
        v2.tabBarItem.image = UIImage(named: "menu_ico_market")?.withRenderingMode(.alwaysOriginal)
        v2.tabBarItem.selectedImage = UIImage(named: "menu_ico_market_active")?.withRenderingMode(.alwaysOriginal)
        tabBarController.viewControllers = [v1, v2, v3, v4, v5]
        
        let navigationController = UINavigationController.init(rootViewController: tabBarController)
 
        
        self.window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
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


}

