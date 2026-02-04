//
//  AppDelegate.swift
//  UrwayDemoApp
//
//
import UIKit
//import iOS_Hosted_plu÷gin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController")
        self.window?.rootViewController = UINavigationController(rootViewController: controller)
        return true
    }
 

    

}

