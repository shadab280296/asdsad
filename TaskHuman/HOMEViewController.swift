//
//  HOMEViewController.swift
//  TaskHuman
//
//  Created by Akhilesh gandhi on 08/03/18.
//  Copyright © 2018 Moreyeahs. All rights reserved.
//

import UIKit
import CoreData


class HOMEViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    
    @IBOutlet weak var tableView: UITableView!
    

    //@IBOutlet weak var sideView: UIView!
    //@IBOutlet weak var sideBar: UITableView!
    
    //LOGOUT
        //self.deleteAllRecords()
       
        // create the alert
      //  let alert = UIAlertController(title: "Logout", message: "Are you sure you want to LogOut?", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        //alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in self.deleteAllRecords()}))
        //alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        //self.present(alert, animated: true, completion: nil)

    
   let Name = ["Nutrition","Paleo Diet","Bentch Press","Yoga","Weight loss","Health Plan"]
    
   let Label = ["23 people available","19 people available","7 people available","Unavailable Schedule call","33 people available","12 people available"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //deleteAllRecords()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Users")
             request.returnsObjectsAsFaults = false
                do{
                    let results = try context.fetch(request)
                   if results.count > 0
            {
                   for result in results as! [NSManagedObject]
                    {
                            if let id = result.value(forKey: "id") as? Int{
                                 print(id)
                        }
                            if let apiKey = result.value(forKey: "apiKey") as? String
                            {
                                 print(apiKey)
                                }
                           if  let email = result.value(forKey: "email") as? String
                           {
                            print(email)
                                }
                       
                    }
        
                    }
                    }
                    catch{
                        print()
                    }
        print("hisd")
       
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
         let cell=tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
       cell.Name.text = Name[indexPath.row]
       cell.Label.text = Label[indexPath.row]
         cell.cell_view.layer.cornerRadius = cell.cell_view.frame.height/8
        
        return cell
        
        
    }
    
    func deleteAllRecords() {
        //delete all data
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
        DispatchQueue.main.async(execute: {
            //segue
            let storyboard = UIStoryboard(name:"Main",bundle:nil)
            print("storyboard")
            let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "LoginSegueID") as! LoginViewController
            
            self.navigationController?.pushViewController(loginPageView, animated: true)
            
        })
        
    }
}


