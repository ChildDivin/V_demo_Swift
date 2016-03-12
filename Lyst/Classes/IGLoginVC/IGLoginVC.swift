//
//  IGLoginVC.swift
//  Lyst
//
//  Created by Tops on 3/11/16.
//  Copyright © 2016 Tops. All rights reserved.
//

import UIKit

class IGLoginVC: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var web:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let authURL: NSURL = NSURL(string: "https://api.instagram.com/oauth/authorize/?client_id=\(InstagramEngine.sharedEngine().appClientID)&redirect_uri=\(InstagramEngine.sharedEngine().appRedirectURL)&response_type=token&scope=relationships+likes")!
        web.loadRequest(NSURLRequest(URL: authURL))

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //MARK: - button click
    @IBAction func btnCloseClick(sender:AnyObject){
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    
    
    //MARK: webview delegate
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        Global.appdel.startSpinerWithOverlay(true)
        return true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        let returnurl:String = (webView.request?.URL?.absoluteString)!
        if(returnurl.hasPrefix(Global.IGretunURL) == true){
            //code found
            do {
                let _:Bool = try Bool( InstagramEngine.sharedEngine().receivedValidAccessTokenFromURL((web.request?.URL)!))
                
                if(InstagramEngine.sharedEngine().accessToken?.characters.count >= 5){
                    Global.appdel.startSpinerWithOverlay(true)
                    InstagramEngine.sharedEngine().getSelfUserDetailsWithSuccess({(user: InstagramUser) -> Void in
                        print(user);
                        self.UserDetailFetch()
                        Global.appdel.stopSpiner()
                        }, failure: {(error: NSError, serverStatusCode: Int) -> Void in
                    })
                    
                }
                
            } catch {
                print(error)
            }
        }
        Global.appdel.stopSpiner()
    }
    
    
    func UserDetailFetch(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
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
