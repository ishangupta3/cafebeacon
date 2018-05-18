//
//  Meal.swift
//  IndoorInBackground
//
//  Created by ishgupta on 4/30/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//


import UIKit


class Meal {
    
    
    var rating: Int
    var mealLocation: String
    var date: Double
    var groundTruth: String
    
    init?( rating: Int, mealLocation: String, date: Double, groundTruth: String) {
        
        self.date = date
        self.rating = rating
        self.mealLocation = mealLocation
        self.groundTruth = groundTruth
    }
    
    
    
    
    
    
}

