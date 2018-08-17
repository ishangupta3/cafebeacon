//
//  LoginViewControllerEstimote.swift
//  estimoteSensors
//
//  Created by ishgupta on 7/13/17.
//  Copyright © 2017 ishgupta. All rights reserved.
//

import UIKit
import Firebase



class LoginViewControllerEstimote: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
     var handle: AuthStateDidChangeListenerHandle?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    
    func sendToLogin() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "login")
        self.present(controller, animated: true, completion: nil)
        
        
        // Safe Present
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as? LoginViewControllerEstimote
        {
             UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
    
        
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
                    
                    let alert = UIAlertController(title: "Too short", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
//                    let mainTab = MainTabController() //your view controller
//                    self.present(mainTab, animated: true, completion: nil)
                    
                    print((message: (error?.localizedDescription)!))
                } else {
                    
                    let alert = UIAlertController(title: "Good Job", message: "Account Successfully Created", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print("User Created")
                    
                    let ref = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
                    ref.setValue(self.emailTextField.text!)
                    let mainTab = MainTabController() //your view controller
                    self.present(mainTab, animated: true, completion: nil)
                    //self.performSegue(withIdentifier:"goToHome", sender: self )
                    
                  
                }
                
                
                // take to the home screen
            }
            
        
        
        
        
        
    }
    
    
}

extension UIApplication {
    class func topViewController(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(viewController: nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(viewController: selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(viewController: presented)
        }
        return viewController
    }
}



