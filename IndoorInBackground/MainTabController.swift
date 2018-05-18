//
//  MainTabController.swift
//  IndoorInBackground
//
//  Created by ishgupta on 3/8/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import UIKit

class MainTabController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let templateController = UINavigationController(rootViewController: WebViewTemplate())
        let palletesController = UINavigationController(rootViewController: WebViewPalletes())
        let infoUserProfileController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "testy") as UIViewController
        
        // storyboard recommendation controller
         let recommendationController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "recommendation") as! UIViewController
        
        // storyboard History Controller
        let historyProfileController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "historyy") as! UINavigationController
        
        //
        //
        //        // History Controller
        //        let layout = UICollectionViewFlowLayout()
        //        let historyNavController = HomeController(collectionViewLayout: layout)
        //        let historyProfileNavController = UINavigationController(rootViewController: historyNavController)
        
        
        
        
        
        infoUserProfileController.tabBarItem.image = #imageLiteral(resourceName: "profileUnselected")
        infoUserProfileController.title = "Profile"
        templateController.tabBarItem.image = #imageLiteral(resourceName: "template")
        templateController.title = "Templates"
        palletesController.title = "Palettes"
        palletesController.tabBarItem.image = #imageLiteral(resourceName: "salad")
        infoUserProfileController.tabBarItem.image = #imageLiteral(resourceName: "profileUnselected")
        historyProfileController.tabBarItem.image = #imageLiteral(resourceName: "historychill")
        historyProfileController.title = "History"
        // historyProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "History")
        //        historyProfileNavController.title = "History"
        tabBar.tintColor = .black
        
        recommendationController.tabBarItem.image = #imageLiteral(resourceName: "suggestion")
        recommendationController.title = "Suggestion"
        
        viewControllers = [templateController, palletesController, infoUserProfileController, historyProfileController,recommendationController]
        
        guard let items = tabBar.items else { return }
        for item in items {
            //            item.imageInsets = UIEdgeInsetsMake(4, 4, -4, 0)
        }
        
        
    }
    
    
    
    
    
}
