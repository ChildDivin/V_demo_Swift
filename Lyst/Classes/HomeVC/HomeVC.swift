//
//  HomeVC.swift
//  Lyst
//
//  Created by Tops on 3/11/16.
//  Copyright © 2016 Tops. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: - button click
    @IBAction func btnfbClick(sender:AnyObject){
        FBSDKLoginManager().logOut()
        let facebookReadPermissions = ["public_profile", "email", "user_friends"]
        let login:FBSDKLoginManager = FBSDKLoginManager()
        login.logInWithReadPermissions(facebookReadPermissions, fromViewController: self) { (result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
            if error != nil {
                FBSDKLoginManager().logOut()
            }else if(result.isCancelled){
                FBSDKLoginManager().logOut()
            }else{
                print(result.token)
                
                if((FBSDKAccessToken.currentAccessToken()) != nil){
                    let request: FBSDKGraphRequest = FBSDKGraphRequest.init(graphPath: "me?fields=id,first_name,last_name,email,picture.type(large)", parameters: nil)
                    request.startWithCompletionHandler({ (connection:FBSDKGraphRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
                        print(result)
                        let dict : NSMutableDictionary = result as! NSMutableDictionary
                        //self.fbsingupwscall(dict)
                    })
                    
                }
                
            }
        }

    }
    
    @IBAction func btnIGClick(sender:AnyObject){

        let igloginobj:IGLoginVC = IGLoginVC(nibName:"IGLoginVC",bundle: nil)
        self.presentViewController(igloginobj, animated: true) { () -> Void in
            
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
