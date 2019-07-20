//
//  ViewController.swift
//  login
//
//  Created by Solayman Rana on 18/7/19.
//  Copyright © 2019 Solayman Rana. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBAction func logOut(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do {
            
            let results = try context.fetch(request)
         
            if results.count > 0 {
            
                for result in results as! [NSManagedObject] {
                
                context.delete(result)
                
                do {
                    
                    try context.save()
                    
                } catch {
                    
                    print("Individual delete failed")
                    
                }
                
            }
                
                label.alpha = 0
                
                logOutButton.alpha = 0
                
                logInButton.setTitle("Login", for: [])
                
                isLoggedIn = false
                
                textField.alpha = 1
            
        }
            
        } catch {
            
            print("delete Failed")
        }
        
    }
    
    
    @IBOutlet weak var logOutButton: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var logInButton: UIButton!
    
    var isLoggedIn = false
    
    @IBAction func logIn(_ sender: Any) {
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        if isLoggedIn {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            
            do {
                
                let results = try context.fetch(request)
                
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject]{
                        
                        context.setValue(textField.text, forKey: "name")
                        
                        do {
                            
                            try context.save()
                            
                        } catch {
                            
                            print("Update username save failed")
                        }
                        
                    }
                    
                    label.text = "Hi There" + textField.text! + "!"
                }
                
                
                
            } catch {
                
                print("Update Failed")
            }
            
        } else {
        
            let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
            newValue.setValue (textField.text, forKey: "name")
        
            do {
            
                try context.save()
            
                logInButton.setTitle("Update Username", for: [])
            
                label.alpha = 1
            
                label.text = "Hi There " + textField.text! + "!"
            
                isLoggedIn = true
                
                logOutButton.alpha = 1
            
            
           
            } catch {
            
                print("Failed to Save")
            
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject] {
                
                if let username = result.value(forKey: "name") as? String {
                    
                    textField.alpha = 0
                    logInButton.setTitle("Update Username", for: [])
                    logOutButton.alpha = 1
                    label.alpha = 1
                    label.text = "Hi There" + username + "!"
                   
                    
                }
                
            }
            
        } catch {
            
            print("Request failed")
        }
        
    }
    
    
}
