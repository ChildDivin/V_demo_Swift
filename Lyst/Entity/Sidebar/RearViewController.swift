//
//  RearViewController.swift
//  Jumbletube
//
//  Created by Tops on 11/18/15.
//  Copyright © 2015 Tops. All rights reserved.
//

import UIKit

class RearViewController: UIViewController {

    @IBOutlet weak var btnCancel:UIButton!
    @IBOutlet weak var scrview: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    //default buttons
    @IBOutlet weak var btnshop:UIButton!
    @IBOutlet weak var btnrecord:UIButton!
    @IBOutlet weak var btnsell:UIButton!
    @IBOutlet weak var btnhowtosell:UIButton!
    @IBOutlet weak var btnTips:UIButton!
    @IBOutlet weak var btnContactus:UIButton!
    @IBOutlet weak var btnAbout:UIButton!
    
    
    var currentSelect:NSInteger!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         btnCancel.addTarget(revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
        currentSelect = 1;
        self.buttonSelect()

        btnshop.layer.cornerRadius = 15
        btnshop.layer.masksToBounds = true

        btnrecord.layer.cornerRadius = 15
        btnrecord.layer.masksToBounds = true
        
        btnsell.layer.cornerRadius = 15
        btnsell.layer.masksToBounds = true
        
        btnhowtosell.layer.cornerRadius = 15
        btnhowtosell.layer.masksToBounds = true
        
        btnTips.layer.cornerRadius = 15
        btnTips.layer.masksToBounds = true

        btnContactus.layer.cornerRadius = 15
        btnContactus.layer.masksToBounds = true
        
        btnAbout.layer.cornerRadius = 15
        btnAbout.layer.masksToBounds = true
        
    }

    override func viewWillLayoutSubviews() {

        if(Global.is_Iphone._4){
            scrview.contentSize = CGSizeMake(scrview.frame.size.width, 500);
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/*
    @IBAction func btnShopClick(sender:AnyObject){
        currentSelect = 1;
        self.buttonSelect()
        
        let shopobj:ShopVC! = ShopVC(nibName:"ShopVC",bundle:nil)
        let nav:UINavigationController = UINavigationController(rootViewController: shopobj)
        nav.navigationBar.hidden = true
        nav.interactivePopGestureRecognizer?.enabled = false
        self.revealViewController().pushFrontViewController(nav,animated: true)


    }
    
    @IBAction func btnRecordClick(sender:AnyObject){
        currentSelect = 2;
        self.buttonSelect()

        let recordvideoobj:RecordVideoVC! = RecordVideoVC(nibName:"RecordVideoVC",bundle:nil)
        let nav:UINavigationController = UINavigationController(rootViewController: recordvideoobj)
        nav.navigationBar.hidden = true
        nav.interactivePopGestureRecognizer?.enabled = false
        self.revealViewController().pushFrontViewController(nav,animated: true)
        
    }
    
    @IBAction func btnSellClick(sender:AnyObject){
        currentSelect = 3;
        self.buttonSelect()
        
        let selllobj:SellVC! = SellVC(nibName:"SellVC",bundle:nil)
        let nav:UINavigationController = UINavigationController(rootViewController: selllobj)
        nav.navigationBar.hidden = true
        nav.interactivePopGestureRecognizer?.enabled = false
        self.revealViewController().pushFrontViewController(nav,animated: true)
        
    }
 
    @IBAction func btnHowtosell(sender: AnyObject) {
        currentSelect = 4;
        self.buttonSelect()
        let howtosellobj:HowToSellVC! = HowToSellVC(nibName:"HowToSellVC",bundle:nil)
        self.revealViewController().pushFrontViewController(howtosellobj, animated: true)
        
    }
    
    @IBAction func btnTipsClick(sender:AnyObject){
    
        let contentPageobj:ContentVC = ContentVC(nibName:"ContentVC",bundle:nil)
        contentPageobj.heading = "Tips & Tricks"
        self.presentViewController(contentPageobj, animated: true) { () -> Void in
        }

    }

    @IBAction func btnTwitterClick(sender:AnyObject){
        UIApplication.sharedApplication().openURL(NSURL(string: "https://twitter.com/Jumbletube?lang=en")!)
    }

    @IBAction func btnYoutubeClick(sender:AnyObject){
        UIApplication.sharedApplication().openURL(NSURL(string: " https://www.youtube.com/channel/UC3FojSe4nLyDiDDJYYIwmGA")!)
    }


    @IBAction func btnFacebookClick(sender:AnyObject){
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.facebook.com/Jumbletube-1064054930301843/timeline/")!)
    }

    @IBAction func btnGoogleClick(sender:AnyObject){
        UIApplication.sharedApplication().openURL(NSURL(string: "https://plus.google.com/100088929679051891511/about")!)
    }

    @IBAction func btnInstagramClick(sender:AnyObject){
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.instagram.com/jumbletube/")!)
    }
    
    @IBAction func btnContactusClick(sender:AnyObject){
        let contentPageobj:ContentVC = ContentVC(nibName:"ContentVC",bundle:nil)
        contentPageobj.heading = "Contact us"
        self.presentViewController(contentPageobj, animated: true) { () -> Void in
        }
    }

    @IBAction func btnAboutusClick(sender:AnyObject){
        let contentPageobj:ContentVC = ContentVC(nibName:"ContentVC",bundle:nil)
        contentPageobj.heading = "About us"
        self.presentViewController(contentPageobj, animated: true) { () -> Void in
            
        }
    }
    
    @IBAction func btnTandcClick(sender:AnyObject){
        let contentPageobj:ContentVC = ContentVC(nibName:"ContentVC",bundle:nil)
        contentPageobj.heading = "T's & C's"
        self.presentViewController(contentPageobj, animated: true) { () -> Void in
    
        }
    }
    */
    
    //MARK: - button select
    func buttonSelect(){
        btnshop.selected = false
        btnrecord.selected = false
        btnsell.selected = false
        btnhowtosell.selected = false
        btnTips.selected = false
        
        if(currentSelect == 1){
            btnshop.selected = true
        }else if(currentSelect == 2){
            btnrecord.selected = true
        }else if(currentSelect == 3){
            btnsell.selected = true
        }else if(currentSelect == 4){
            btnhowtosell.selected = true
        }else if(currentSelect == 5){
            btnTips.selected = true
        }
        
    }
    

    @IBAction func btnLogoutClick(sender:AnyObject){
        let appdel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        StaticClass().saveToUserDefaults("", forKey: Global.g_UserData.USERNAME)
        for key in NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
        }
        appdel.nav?.popToRootViewControllerAnimated(true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
