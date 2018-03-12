//
//  SignUpViewController.swift
//  TaskHuman
//
//  Created by Akhilesh gandhi on 05/03/18.
//  Copyright © 2018 Moreyeahs. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var PassWord: UITextField!
    @IBOutlet weak var signup: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func SignUp(_ sender: UIButton) {
        let parameters = ["email": UserName.text, "password": PassWord.text]
        
        let JSONSignUP = API.SignUpURL
        guard let url = URL(string: JSONSignUP)else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
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
                    let SignUpjson = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    
                    print(SignUpjson)
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context = appDelegate.persistentContainer.viewContext
                    let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
                    
                    
                    let apiKey = SignUpjson["apiKey"]
                    newUser.setValue(apiKey,forKey:"apiKey")
                    
                    if let user = SignUpjson["user"] as? NSDictionary
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
                    var dict = [String:AnyObject]()
                    dict = SignUpjson as! [String:AnyObject]
                    let keyExists = dict["success"] != nil
                    if keyExists
                    {
                        
                        var success = Bool()
                        success = dict["success"] as! Bool
                        print(success)
                        if success{
                            print("yes")
                            
                            DispatchQueue.main.async(execute: {
                                
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

