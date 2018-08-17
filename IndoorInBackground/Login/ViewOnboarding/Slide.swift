//
//  Slide.swift
//  IndoorInBackground
//
//  Created by ishgupta on 7/16/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import UIKit

class Slide: UIView {
    
    let x = LoginViewControllerEstimote()
    let appDelegateInstance = AppDelegate()

    @IBOutlet weak var label: UILabel!
    let locationManager = CLLocationManager()
    @IBAction func doneButton(_ sender: Any) {
        print("Button done is clicked now")
        x.sendToLogin()
        locationManager.requestAlwaysAuthorization()
        
      
    }
    

}
