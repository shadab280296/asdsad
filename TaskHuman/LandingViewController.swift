//
//  LandingViewController.swift
//  TaskHuman
//
//  Created by Akhilesh gandhi on 27/02/18.
//  Copyright © 2018 Moreyeahs. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import CoreData



class LandingViewController: UIViewController,FBSDKLoginButtonDelegate {

    
    @IBAction func FBbtn(_ sender: UIButton) {
            loginButton.setImage(UIImage(named: "facebook.png"),for: UIControlState.normal)
    }
    let loginButton: FBSDKLoginButton = {
     
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
       }()
    

        override func viewDidLoad() {
            super.viewDidLoad()
            print("h1")
              // loginButton.setImage(UIImage(named: "facebook.png"),for: UIControlState.normal)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Users")
            request.returnsObjectsAsFaults = false
            do{
                print("h2")
                let results = try context.fetch(request)
                if results.count == 0
                {
                    
                    print("coredata has no data")
                    let storyboard = UIStoryboard(name:"Main",bundle:nil)
                    print("storyboard")
                    let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "LoginSegueID") as! LoginViewController
                    
                    self.navigationController?.pushViewController(loginPageView, animated: true)
                    
                }
                else
                {
                    print("core data has data")
                    let storyboard = UIStoryboard(name:"Main",bundle:nil)
                    print("storyboard")
                    let HomePageView = self.storyboard?.instantiateViewController(withIdentifier: "TableSegueID") as! HOMEViewController
                    
                    self.navigationController?.pushViewController(HomePageView, animated: true)
                    
                }
                
            }catch{
                print("core data error")
            }
            
        
        // Do any additional setup after loading the view, typically from a nib.
        //view.addSubview(loginButton)
        loginButton.center = view.center
  
            
        if (FBSDKAccessToken.current()) != nil
        {
            print("user is not logged in")
            fetchProfile()
        }else
        {
            print("user is logged in")
        }
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile,","email" ,"user_friends"]
            loginButton.setImage(UIImage(named: "facebook.png"),for: UIControlState.normal)
       
    }
    func fetchProfile(){
        print("fetch profile")
        
        //let parameters = ["fields":"email,first_name,last_name,picture.type(large)"]
       // FBSDKGraphRequest(graphPath:"me",parameters:parameters).start {(connection,result,error) -> Void in
           // if error != nil {
           //   print(error)
           //    return
          // }
          //  if let email = self.result["email"] as? String {
          //    print(email)
         //  }
           // if let picture = self.result["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary,let url = data["url"] as? String{
           //   print(url)
                
          //  }
    
    }
    func loginButton(_ loginButton:FBSDKLoginButton!,didCompleteWith result: FBSDKLoginManagerLoginResult!,error:Error!){
        loginButton.setImage(UIImage(named: "facebook.png"),for: UIControlState.normal)
        if error != nil{
            print(error.localizedDescription)
            return
        }
        if let userToken = result.token{
            //get user access token
            let token:FBSDKAccessToken = result.token
            print("Token = \(FBSDKAccessToken.current().tokenString)")
            print("User ID = \(FBSDKAccessToken.current().userID)")
            
        }
        print("completed login")
       // fetchProfile()
    }
   func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    func loginButtonWillLogin( loginButton: FBSDKLoginButton!) -> Bool {
       
        return true
    }
    
}


