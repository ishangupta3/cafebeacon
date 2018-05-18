//
//  LoginViewControllerEstimote.swift
//  estimoteSensors
//
//  Created by ishgupta on 7/13/17.
//  Copyright © 2017 ishgupta. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class LoginViewControllerEstimote: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
     var handle: AuthStateDidChangeListenerHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    

    
    
        override func viewWillAppear(_ animated: Bool) { // move this code to the splash screen
    
            handle = Auth.auth().addStateDidChangeListener { (auth, user) in
               if Auth.auth().currentUser != nil {
                    let mainTab = MainTabController() //your view controller
                    self.present(mainTab, animated: true, completion: nil)
                    //self.performSegue(withIdentifier:"goToHome", sender: self )
    
               } 
    
            }
    
    
        }

 

        override func viewWillDisappear(_ animated: Bool) {
            Auth.auth().removeStateDidChangeListener(handle!)
        }
    
    
     

    
    //////
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func loginButton(_ sender: Any) {
        
    if emailTextField.text != "" && passwordTextField.text != "" {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if user != nil {
                let ref = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
                ref.setValue(self.emailTextField.text!)
                let mainTab = MainTabController() //your view controller
                self.present(mainTab, animated: true, completion: nil)
                //self.performSegue(withIdentifier:"goToHome", sender: self )
                print("User Created")
                
            } else {
                
                
                let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                print((message: (error?.localizedDescription)!))
                
            }
            
            }
            
    } else {
        
        let alert = UIAlertController(title: "Alert", message: "Please input Email or password", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
       
        
        }
        
        
        
        
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        
    
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error != nil {
                    
                    let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    let mainTab = MainTabController() //your view controller
                    self.present(mainTab, animated: true, completion: nil)
                    //self.present(alert, animated: true, completion: nil)
                    print((message: (error?.localizedDescription)!))
                } else {
                    
                    let ref = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
                    ref.setValue(self.emailTextField.text!)
                    let mainTab = MainTabController() //your view controller
                    self.present(mainTab, animated: true, completion: nil)
                    //self.performSegue(withIdentifier:"goToHome", sender: self )
                    print("User Created")
                }
                
                
                // take to the home screen
            }
            
        
        
        
        
        
    }
    
    
    
    
    
    
}