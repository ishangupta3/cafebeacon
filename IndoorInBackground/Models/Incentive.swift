//
//  Incentive.swift
//  IndoorInBackground
//
//  Created by ishgupta on 6/26/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import Foundation
import Firebase






func extractEmail(completion: @escaping (String?) -> Void) {
    
        let userID = Auth.auth().currentUser?.uid
        let ref: DatabaseReference! = Database.database().reference()
        
            ref.child("users").child(userID ?? "error").observeSingleEvent(of: .value, with: { (snapshot) in
                let userEmail = snapshot.value as? String
                print(userID)
                print(userEmail)
                completion(userEmail)
            })
    
    
}

func incentive(completion: @escaping (Int?) -> Void) {
    
    let prediction = Database.database().reference().child("predictions").child((Auth.auth().currentUser?.uid)!)
    
    prediction.observe(.value, with: { snapshot in
        var count = 0
        for x in snapshot.children.allObjects as! [DataSnapshot] {
            guard let xDict = x.value as? [String: Any] else { return }
            if xDict["groundTruth"] as! String == "green" {
                count+=1
            }
        }
        
        print(snapshot.childrenCount)
        completion(count)
        print("goodboy")
    })
    
}

func redeemPlus1() {
    let redeem = Database.database().reference().child("redeem").child((Auth.auth().currentUser?.uid)!)
    redeem.childByAutoId().setValue(translateUnixTime(time: getCurrentUnixTime()))
    
    
}

func countTotalRedeemed(completion: @escaping (Int?)-> Void) {
    let redeem = Database.database().reference().child("redeem").child((Auth.auth().currentUser?.uid)!)
    
    redeem.observe(.value, with: {
        snapshot in
        print(snapshot.childrenCount, "Total number which have been redeemed")
        let redeemedCount: Int = Int(snapshot.childrenCount)
        completion(redeemedCount)
    })
}





