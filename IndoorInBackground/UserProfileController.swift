//
//  UserProfileController.swift
//  IndoorInBackground
//
//  Created by ishgupta on 3/8/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class UserProfileController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewWillAppear(_ animated: Bool) {
        extractEmail()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
       fileprivate func extractEmail() {
        
        DispatchQueue.global(qos: .userInitiated).async { // 1
            let userID = Auth.auth().currentUser?.uid
            let ref: DatabaseReference! = Database.database().reference()
            
            DispatchQueue.main.async { // 2
                ref.child("users").child(userID ?? "error").observeSingleEvent(of: .value, with: { (snapshot) in
                    let userEmail = snapshot.value as? String
                    self.navBar.topItem?.title = userEmail
                })

               
            }
        }
    }
    
    
    
}



