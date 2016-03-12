//
//  AppDelegate.swift
//  Lyst
//
//  Created by Tops on 3/11/16.
//  Copyright © 2016 Tops. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager:CLLocationManager!
    var nav:UINavigationController?
    var Homeobj:HomeVC!
    
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            locationManager.requestWhenInUseAuthorization()
        } else {
            // Fallback on earlier versions
        }
        locationManager.startUpdatingLocation()
        
        IQKeyboardManager.sharedManager().enable = true
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        //Optionally add to ensure your credentials are valid:
        FBSDKLoginManager.renewSystemCredentials { (result:ACAccountCredentialRenewResult, error:NSError!) -> Void in
        }
        
        
        //inapp
        if(IAPShare.sharedHelper().iap == nil){
            let dataSet = Set([Global.inApp.inapp2,Global.inApp.inapp3,Global.inApp.inapp4,Global.inApp.inapp5,Global.inApp.inapp6,Global.inApp.inapp7,Global.inApp.inapp8,Global.inApp.inapp9,Global.inApp.inapp10]);
            IAPShare.sharedHelper().iap = IAPHelper(productIdentifiers: dataSet);
        }
        
        IAPShare.sharedHelper().iap.production = true
        IAPShare.sharedHelper().iap.requestProductsWithCompletion { (requst:SKProductsRequest!, response:SKProductsResponse!) -> Void in
            print(IAPShare.sharedHelper().iap.products)
        }

        
        // PUSH NOTIFICATION
        if #available(iOS 8.0, *) {
            let types: UIUserNotificationType = [UIUserNotificationType.Badge, UIUserNotificationType.Alert, UIUserNotificationType.Sound]
            let settings: UIUserNotificationSettings = UIUserNotificationSettings( forTypes: types, categories: nil )
            application.registerUserNotificationSettings( settings )
            application.registerForRemoteNotifications()
        } else {
            // Fallback on earlier versions
            UIApplication.sharedApplication().registerForRemoteNotificationTypes([.Alert,.Badge,.Sound])
        }
        
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        //  Mainobj = MainVC(nibName: "MainVC", bundle: nil)
        Homeobj = HomeVC(nibName:"HomeVC",bundle: nil)
        nav = UINavigationController(rootViewController: Homeobj!)
        nav?.interactivePopGestureRecognizer?.enabled = false
        nav?.navigationBar.hidden = true;
        window?.rootViewController=nav
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Loader Start/Stop Methods
    func startSpinerWithOverlay (overlay: Bool) {
        self.stopSpiner()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        MBProgressHUD.showHUDAddedTo(appDelegate.window, animated: true)
        
    }
    
    func stopSpiner() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        MBProgressHUD.hideAllHUDsForView(appDelegate.window, animated: true)
        
    }
    
    //MARK: Location
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        let long = userLocation.coordinate.longitude;
        let lat = userLocation.coordinate.latitude;
        StaticClass().saveToUserDefaults(lat, forKey: Global.g_UserDefaultKey.latitude)
        StaticClass().saveToUserDefaults(long, forKey: Global.g_UserDefaultKey.longitude)
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error in location", terminator: "")
        StaticClass().saveToUserDefaults("34.000028", forKey: Global.g_UserDefaultKey.latitude)
        StaticClass().saveToUserDefaults("-118.325213", forKey: Global.g_UserDefaultKey.longitude)
    }
    
    //MARK :Facebook
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        //Even though the Facebook SDK can make this determinitaion on its own,
        //let's make sure that the facebook SDK only sees urls intended for it,
        //facebook has enough info already!
        return FBSDKApplicationDelegate.sharedInstance().application(
            application,
            openURL: url,
            sourceApplication: sourceApplication,
            annotation: annotation)
    }

    //MARK: Push notification
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("Got token data! (deviceToken)")
        let characterSet: NSCharacterSet = NSCharacterSet( charactersInString: "<>" )
        
        let deviceTokenString: String = ( deviceToken.description as NSString )
            .stringByTrimmingCharactersInSet( characterSet )
            .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
        
        print( deviceTokenString )
        StaticClass().saveToUserDefaults(deviceTokenString, forKey: Global.g_UserDefaultKey.DeviceToken)

    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Couldn’t register: (error)")
    }
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        let appState: UIApplicationState = .Active
        if appState == .Active {
            let aps:NSDictionary = userInfo["aps"] as! NSDictionary
            AJNotificationView.showNoticeInView(self.window, type: AJNotificationTypeGreen, title: aps.valueForKey("message") as! String, linedBackground: AJLinedBackgroundTypeStatic, hideAfter: 1.5, offset: 0)
        }
    }


}

