//
//  AppDelegate.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit
import FirebaseCore
import RevenueCat
import GoogleMobileAds
import ProgressHUD

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //MARK: - Firebase
        FirebaseApp.configure()

        //MARK: - Revenue Cat
        Purchases.logLevel = .debug
        if let customValue = Bundle.main.object(forInfoDictionaryKey: "RevenueCatAPIKey") as? String {
            Purchases.configure(withAPIKey: customValue)
            RevenueCatManager.shared.checkSubscriptionStatus { _ in }
        }
        
        //MARK: - AdMob Init
        GADMobileAds.sharedInstance().start(completionHandler: nil)
//                GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "c59450b07318dc57a0013843cd8b9d6e" ]
        
        //MARK: - Core Data Init
        CoreDataManager.shared.load()
        
        
        //MARK: - Setup Keyboard Manager
        KeyboardManager.shared.setupKeyboard()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

