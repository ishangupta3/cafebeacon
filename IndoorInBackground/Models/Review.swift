//
//  Review.swift
//  IndoorInBackground
//
//  Created by ishgupta on 5/6/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseDatabase

//class Review {
//
//    var rating: Int
//    var reviewText: String
//    var location: String
//
//    init(rating: Int, reviewText: String, location: String) {
//
//    }
//
//}

let mealtableInstance = MealTableViewController()

struct ReviewStruct {
    
    var rating: Int
    var reviewText: String
    var location: String
    var date: String
    
    
   
    
    init(rating: Int, reviewText: String, location: String, date: String) {
        
        self.rating = rating
        self.reviewText = reviewText
        self.location = location
        self.date = date
        
        
        
        let userGroundTruth: NSDictionary
        userGroundTruth = [
            "groundTruth" : location,
            "date"        : date,
            "rating"      : rating,
            "reviewText"  : reviewText,
            
        ]
        
        // this is saving it to the ground truth tabs in firebase
        let groundtruthRef = Database.database().reference().child("groundTruth").child((Auth.auth().currentUser?.uid)!).child(self.date)
        groundtruthRef.setValue(userGroundTruth)
       
        print(self.rating, "This is the rating")
        let ratingUpdate = Database.database().reference().child("predictions").child((Auth.auth().currentUser?.uid)!).child(self.date).child("rating")
        ratingUpdate.setValue(rating)

        // changing groundtruth label from red to green
         let groundTruthLabelUpdate = Database.database().reference().child("predictions").child((Auth.auth().currentUser?.uid)!).child(self.date).child("groundTruth")
        groundTruthLabelUpdate.setValue("green")
        
        // changing groundtruth label from red to green
        let locationUpdate = Database.database().reference().child("predictions").child((Auth.auth().currentUser?.uid)!).child(self.date).child("mealPrediction")
        locationUpdate.setValue(location)
        
        
  
        
    }
    
    
}
