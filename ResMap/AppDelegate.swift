//
//  AppDelegate.swift
//  ResMap
//
//  Created by hirosawak on 2015/06/27.
//  Copyright (c) 2015年 hirosawak. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var myTabBarController : UITabBarController!
    var myNavigationController : UINavigationController!

    // Tabに設定するViewControllerのインスタンスを生成.
    let myFirstTab: UIViewController   =  MapViewController()
    let mySecondTab: UIViewController  =  SearchViewController()
    let mySettingTab: UIViewController =  SettingViewController()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)

        //タブのiconを設定
        myFirstTab.tabBarItem.image = UIImage(named: "Mag.png")
        myFirstTab.tabBarItem.title = "Map"
        
        //タブのiconを設定
        mySecondTab.tabBarItem.image = UIImage(named: "Loc.png")
        mySecondTab.tabBarItem.title = "Search"
        
        //タブのiconを設定
        mySettingTab.tabBarItem.image = UIImage(named: "Gear.png")
        mySettingTab.tabBarItem.title = "Setting"
        
        //mySecondTab.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // タブを要素に持つArrayを作成する
        let myTabs = NSArray(objects: addNaviView(myFirstTab), mySecondTab,addNaviView(mySettingTab))
        // UITabControllerの作成する.
        myTabBarController = UITabBarController()
        // ViewControllerを設定する.
        myTabBarController?.setViewControllers(myTabs as [AnyObject], animated: false)
        // RootViewControllerに設定する.
        self.window!.rootViewController = myTabBarController
        self.window!.makeKeyAndVisible()

        return true
    }

    func addNaviView(myVC:UIViewController) -> UINavigationController{
        // Navication Controllerを生成する.
        let myNavigationController: UINavigationController = UINavigationController(rootViewController: myVC)
        // 検索ボタンを設置
        //myVC.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: myNavigationController, action: "")
        // NavigationBarの表示する.
        myNavigationController.setNavigationBarHidden(false, animated: false)
        return myNavigationController
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }

}