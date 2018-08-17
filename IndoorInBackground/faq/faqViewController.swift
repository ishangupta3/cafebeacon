//
//  faqViewController.swift
//  IndoorInBackground
//
//  Created by ishgupta on 8/7/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import UIKit
import FAQView


class faqViewController: UIViewController {
    
     var faqView: FAQView!

    override func viewDidLoad() {
        super.viewDidLoad()

    
   
  
//        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: nil)
//        navigationItem.leftBarButtonItem = rightBarButton
        self.automaticallyAdjustsScrollViewInsets = false
        
        let items = [FAQItem(question: "Who is running the café app project?", answer: "The Café App pilot is a project of Adobe Research. Bon Appétit is our strategic partner."),
                     
                    
                     
                     FAQItem(question: "Where can I redeem my free lunch coupon?", answer: " You can redeem the coupon at any café or coffee bar in the San Jose office."),
                     
                     
                      FAQItem(question: "In which Adobe office locations is this app being piloted?", answer: "This pilot is only available in the San Jose location."),
                      
                      FAQItem(question: "Why didn’t I get the chance to review my meal, even if I went to a café and have successfully downloaded the app?", answer: "Most likely your phone’s Bluetooth was not turned on, or while setting up the application you did not click on “Always Allow” for the permissions."),

                      
                      
                      FAQItem(question: "How do I redeem the coupon?", answer: "Go under the /('Redeem') section. When the “Redeem” dialog box appears, show it to the cashier. Cashier will click the “Redeem” button for you."),
                      
                      FAQItem(question: "How much is my coupon worth?", answer: "The coupon is worth $8."),
                      
                      
                      FAQItem(question: " If I don’t spend the full $8 in one purchase, can I use it later?", answer: "No, the coupon value is “use it or lose it.” Any amount not spent is forfeited."),
                      
                      FAQItem(question: "Will the free lunch incentive be available for an unlimited time?", answer: "No, the incentive will last a limited time and each user will be explicitly notified when the incentivized period is over."),
                      
                      
                          FAQItem(question: "Why do I need to agree to “Always Allow” for location permissions?", answer: "This allows the sensors to communicate with your phone, even while the app is terminated, allowing for easier use of the app’s functionality."),
                          
                            FAQItem(question: "What type of data is being collected?", answer: "The data collected consists of geofence data produced by the beacons installed in the cafés, the time you entered the café, and the particular station you visited within the café."),
                            
                             FAQItem(question: "Will the free lunch incentive be available for an unlimited time?", answer: "No, the incentive will last a limited time and each user will be explicitly notified when the incentivized period is over."),
                             
                              FAQItem(question: "Who can I contact for more information related to this project?", answer: " Ishan Gupta: ishgupta@adobe.com or Georgios Theocharous: theochar@adobe.com")
                      
                      
                      
                     
        
        
        
        
        
        
        ]
        faqView = FAQView(frame: view.frame, items: items)
        faqView.translatesAutoresizingMaskIntoConstraints = false
        faqView.titleLabelTextFont =  UIFont(name: "Avenir-Book", size: 25)
        faqView.cellBackgroundColor = UIColor.white
        faqView.backgroundColor = UIColor.white
        
        
        
        faqView.answerTextFont = UIFont(name: "Avenir-Book", size: 15)
        faqView.viewBackgroundColor = UIColor.white
        
        view.addSubview(faqView)
        addFaqViewConstraints()
    }

    
    func addFaqViewConstraints() {
        let faqViewTrailing = NSLayoutConstraint(item: faqView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailingMargin, multiplier: 1, constant: 17)
        let faqViewLeading = NSLayoutConstraint(item: faqView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1, constant: -17)
        let faqViewTop = NSLayoutConstraint(item: faqView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 50)
        let faqViewBottom = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: faqView, attribute: .bottom, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([faqViewTop, faqViewBottom, faqViewLeading, faqViewTrailing])
    }
}
