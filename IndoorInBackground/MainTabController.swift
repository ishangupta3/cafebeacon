//
//  MainTabController.swift
//  IndoorInBackground
//
//  Created by ishgupta on 3/8/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import Foundation
import Firebase

import UIKit
import UserNotifications

class MainTabController: UITabBarController {
    
    
    
    let profileInstance = UserProfileController()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
       // runNotification()
        
        let templateController = UINavigationController(rootViewController: WebViewTemplate())
        let palletesController = UINavigationController(rootViewController: WebViewPalletes())
        let layersController = UINavigationController(rootViewController: WebViewLayers())
        let infoUserProfileController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "testy") as UIViewController
        
        // storyboard recommendation controller
         let recommendationController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "recommendation") as! UIViewController
        
        // storyboard History Controller
        let historyProfileController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "historyy") as! UINavigationController
        
        let chartViewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chart") as! UIViewController
        
        
        let faqViewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "faq") as! UIViewController
        

        
        
        
        infoUserProfileController.tabBarItem.image = #imageLiteral(resourceName: "profileUnselected")
       // infoUserProfileController.title = self.profileEmail
        
        
        infoUserProfileController.title = "Redeem"
        templateController.tabBarItem.image = #imageLiteral(resourceName: "template")
        templateController.title = "Templates"
        palletesController.title = "Palettes"
        palletesController.tabBarItem.image = #imageLiteral(resourceName: "salad")
        infoUserProfileController.tabBarItem.image = #imageLiteral(resourceName: "profileUnselected")
        historyProfileController.tabBarItem.image = #imageLiteral(resourceName: "historychill")
        historyProfileController.title = "Review"
        
        chartViewController.tabBarItem.image = #imageLiteral(resourceName: "historychill")
        chartViewController.title = "Waiting Time "
        
        layersController.tabBarItem.image = #imageLiteral(resourceName: "sandwhich")
        layersController.title = "Layers"
        
        
        faqViewController.tabBarItem.image = #imageLiteral(resourceName: "historychill")
        faqViewController.title = "Facts and Questions"
        
        
        // historyProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "History")
        //        historyProfileNavController.title = "History"
        tabBar.tintColor = .black
        
        recommendationController.tabBarItem.image = #imageLiteral(resourceName: "suggestion")
        recommendationController.title = "Suggestion - Under Development"
        
        viewControllers = [templateController, palletesController,layersController, historyProfileController, infoUserProfileController,chartViewController,faqViewController]
        
        guard let items = tabBar.items else { return }
        for item in items {
            //            item.imageInsets = UIEdgeInsetsMake(4, 4, -4, 0)
        }
        
    }
    
        func runNotification() {  // need to create 5 different notifications
    
            var date2 = DateComponents()
            let content = UNMutableNotificationContent()
            content.title = "How was lunch?"
            content.body = "Write a review"
    
            content.sound = UNNotificationSound.default()
            createNotification(index: 1, content: content)
            print(date2.weekday)
            
            
            let morningContent = UNMutableNotificationContent()
            morningContent.title = "Check out today's lunch menu"
            morningContent.sound = UNNotificationSound.default()
            createNotificationMorning(index: 1, content: morningContent)
           
    
            //        let trigger = UNCalendarNotificationTrigger(dateMatching: date2, repeats: true)
            //        let request = UNNotificationRequest(identifier: "notification1", content: content, trigger: trigger)
            //        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    
        }
    
    
}
