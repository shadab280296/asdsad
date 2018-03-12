//
//  LoginViewController.swift
//  TaskHuman
//
//  Created by Akhilesh gandhi on 01/03/18.
//  Copyright © 2018 Moreyeahs. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
   
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var Continue: UIButton!
    

    @IBAction func OnePostTapped(_ sender: Any) {
        
       
        let parameters = ["email": userName.text, "password": password.text]
//reusable api calling
        let JSONLogin = API.LoginURL
        guard let url = URL(string: JSONLogin)else { return }
//json parsing
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
       request.httpBody = httpBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
      if let response = response {
             print(response)
            }
           
            if let data = data {
                do {
                    let Loginjson = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    
                    print(Loginjson)
 //coredata
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context = appDelegate.persistentContainer.viewContext
                    let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
                    
                    
 //storing api entities
                    
                      let apiKey = Loginjson["apiKey"]
                    newUser.setValue(apiKey,forKey:"apiKey")
                    
                    if let user = Loginjson["user"] as? NSDictionary
                    {
                        if let id = user["id"]
                        {
                            let email = user["email"]
                            newUser.setValue(id,forKey:"id")
                            newUser.setValue(email,forKey:"email")
                            print (id)
                            do{
                                try context.save()
                                print("saved")
                            }catch{
                        }
                        
                        }
                    }
//checking success key from api
                    var dict = [String:AnyObject]()
                    dict = Loginjson as! [String:AnyObject]
                    let keyExists = dict["success"] != nil
                    if keyExists
                    {
                
                    var success = Bool()
                        success = dict["success"] as! Bool
                    print(success)
                if success{
                       print("yes")
            
                        DispatchQueue.main.async(execute: {
 //segue
                            let storyboard = UIStoryboard(name:"Main",bundle:nil)
                            print("storyboard")
                            let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "TableSegueID") as! HOMEViewController
                            
                            self.navigationController?.pushViewController(loginPageView, animated: true)
                            
                        })
                    
                    }else{
                        print("Invalid Username and Password")
                    }
                }
                else{
                    print("Invalid Username and Password")
                }
                    
                    }catch {
                    print(error)
                }
        }
            
            }.resume()
    }

}
        







