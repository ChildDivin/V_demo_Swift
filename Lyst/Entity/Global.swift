//
//  Global.swift
//  SwiftDemo
//
//  Created by TopsTech on 02/03/2015.
//  Copyright (c) 2015 tops. All rights reserved.
//

struct Global {
    
    // API base Url
    static let g_APIBaseURL = "http://www.jumbletube.com/api/"
    static let appdel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    //Instagram
    static let IGretunURL =  "http://topsdemo.in/"
    
    struct g_UserData {
        static let USERID = "id"
        static let USERPASSWORD = "password"
        static let USEREMAIL = "EmailAddress"
        static let USERFIRSTNAME = "FirstName"
        static let USERLASTNAME = "Surname"
        static let USERNAME = "Username"
        static let USERWEBSITEURL = "WebsiteUrl"
        static let USERPROFILEIMAGEURL = "ProfileImageUrl"
        static let USERPOSTCODE = "Postcode"
        static let USERPHONENO = "PhoneNo"
        static let USERPHONISPUBLIC = "PhoneNoPublic"
        static let USERPOSTCODEISPUBLIC = "PostcodePublic"
        static let USEREMAILISPUBLIC = "EmailAddressPublic"
        static let USERACCOUNTTYPE = "accounttype"
        
    }
    
    struct g_UserDefaultKey {
     static let latitude = "latitude"
     static let longitude = "longitude"
     static let DeviceToken = "DeviceToken"
 
    }
    
    struct directoryPath {
        static let Documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        static let Tmp = NSTemporaryDirectory()
    }
    
    //Device Compatibility
    struct is_Device {
        static let _iPhone = (UIDevice.currentDevice().model as NSString).isEqualToString("iPhone") ? true : false
        static let _iPad = (UIDevice.currentDevice().model as NSString).isEqualToString("iPad") ? true : false
        static let _iPod = (UIDevice.currentDevice().model as NSString).isEqualToString("iPod touch") ? true : false
    }
    //IOS Version Compatibility
    struct is_Ios {
        static let _8 = ((UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0) ? true : false
        static let _7 = ((UIDevice.currentDevice().systemVersion as NSString).floatValue >= 7.0 && (UIDevice.currentDevice().systemVersion as NSString).floatValue < 8.0) ? true : false
        static let _6 = ((UIDevice.currentDevice().systemVersion as NSString).floatValue <= 6.0 ) ? true : false
    }
    
    //Display Size Compatibility
    struct is_Iphone {
        static let _6p = (UIScreen.mainScreen().bounds.size.height >= 736.0 ) ? true : false
        static let _6 = (UIScreen.mainScreen().bounds.size.height <= 667.0 && UIScreen.mainScreen().bounds.size.height > 568.0) ? true : false
        static let _5 = (UIScreen.mainScreen().bounds.size.height <= 568.0 && UIScreen.mainScreen().bounds.size.height > 480.0) ? true : false
        static let _4 = (UIScreen.mainScreen().bounds.size.height <= 480.0) ? true : false
    }
    
    struct inApp {
        static let inapp2  = "com.jumbletube.inApp2"
        static let inapp3  = "com.jumbletube.inApp3"
        static let inapp4  = "com.jumbletube.inApp4"
        static let inapp5  = "com.jumbletube.inApp5"
        static let inapp6  = "com.jumbletube.inApp6"
        static let inapp7  = "com.jumbletube.inApp7"
        static let inapp8  = "com.jumbletube.inApp8"
        static let inapp9  = "com.jumbletube.inApp9"
        static let inapp10 = "com.jumbletube.inApp10"
    }
    
}

