//
//  UserProfileController.swift
//  IndoorInBackground
//
//  Created by ishgupta on 3/8/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import UIKit
import Firebase


class UserProfileController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var redeemButton: UIButton!
    
    @IBOutlet weak var freelunchMessage: UILabel! // how many lunches till
    
    @IBOutlet weak var tillNextFreeCoupon: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
       // extractEmail()
        
        incentive { (count) in
            countTotalRedeemed { total in
                print(total, "this total")
                let totalNumberOfRedeemedLunches: Int = total! * 5
                let totalCount = count! - totalNumberOfRedeemedLunches
                print(totalCount, "THIS IS THE TOTAL COUNT")
                var availibleFreeLunches = (totalCount / 5) as! Int
                print(totalCount % 5, "This is the total Count") // SUBTRACT 5 FOR TOTAL REVIEWS LEFT UNTIL NEW COUPON IS AVAILIBLE
                let modulo = totalCount % 5
                var tillNextFReeCoupon = 5 - modulo
                self.freelunchMessage.text = "\(availibleFreeLunches) coupon(s) availible"
                
                self.tillNextFreeCoupon.text = "\(tillNextFReeCoupon) review(s) until next free lunch"
                
                // calculate totalCount mod 5 which means those are the number of free lunches availible 
                if totalCount >= 5 {
                    self.redeemButton.backgroundColor = .green
                    self.redeemButton.titleLabel?.textColor = .black
                    self.redeemButton.isEnabled = true
                } else {

                    self.redeemButton.backgroundColor = .red
                    self.redeemButton.isEnabled = false
                   
                }
            }
        }
    }
    
    @IBAction func redeem(_ sender: Any) {
        
        let alert = UIAlertController(title: "STOP!", message: "SHOW Screen to cashier if you want to redeem free lunch", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "REDEEM", style: .default, handler: {
            action in
            print("user clicked Redeem")
            redeemPlus1()
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: {
            action in
            print("you clicked cancel")
            
        }))
        
        self.present(alert, animated: true)
        
        
        
    }
    
    

    
    @IBAction func singoutbutton(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    
    
    
}



