//
//  AppDelegate.swift
//  IndoorInBackground


import UIKit
import UserNotifications
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, EILBackgroundIndoorLocationManagerDelegate, MessagingDelegate {

    var window: UIWindow?
    
    
    var backgroundIndoorLocationManager: EILBackgroundIndoorLocationManager!
    var fetchLocationTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
    
    let asia = EILPoint(x: 6.37, y: 12.96)
    let india = EILPoint(x: 6.16, y: 0.62)
    let  burger = EILPoint(x: 0.59, y: 0.59)
    let homeStyle = EILPoint(x: 0.59, y: 13.47)
    
    let asia2 = EILPoint(x: 5.28, y: 5.80025)
    let india2 = EILPoint(x: 5.2612, y: 0.236183)
    let burger2 = EILPoint(x: 0.53, y: 0.41)
    let homeStyle2 = EILPoint(x: 0.205725, y: 5.80025)
   
    let radius = 3.0
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
       
        FirebaseApp.configure()
        ESTConfig.setupAppID("final-version-id-lf0", andAppToken:"de1ecbedb98044d6fbf8ad35f19200bf")
        
      
        self.backgroundIndoorLocationManager = EILBackgroundIndoorLocationManager()
        self.backgroundIndoorLocationManager.delegate = self
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size:21.0)!, NSForegroundColorAttributeName:UIColor.black]
        
        
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.9) {
            self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
        
      //  self.requestNecessaryPermissions() // this is where location is being asked from the user
        
        
        self.fetchLocationAndStartPositioninig()
    
        
        
//        window = UIWindow()
//        window?.rootViewController = MainTabController()
//        
        attemptRegisterNotifications(application: application)
        return true
    }
    

    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("registered for notifications", deviceToken)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        let ref = Database.database().reference().child("tokens").child(Auth.auth().currentUser?.uid ?? "error")
        ref.setValue(fcmToken)
        
//        let ref2 = Database.database().reference().child("users").child(Auth.auth().currentUser?.uid ?? "error")
//        ref2.setValue("ishangupta3@gmail.com")
        
        print("Registered with FCM Token", fcmToken)
    }
    
            func attemptRegisterNotifications(application: UIApplication) {
        print("attempting to register notifications")
        Messaging.messaging().delegate = self
        // user authorization notif
        
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, error) in
            if let error = error {
                print("Failed to give authorship", error)
                return
            }
            
            if granted {
                print("testing granted")
            } else {
                print("not granted")
            }
        }
        
        application.registerForRemoteNotifications()
        
    }
    
    func requestNecessaryPermissions() {
        
        // In order to relaunch the application (if it is killed by operating system or user) as the user enters the location “Always in use” Location Services authorization is required.
   
        
        // In this example notifications are used for showing the current position, but are not required for Indoor Location to work
        let notificationOptions: UNAuthorizationOptions = [.alert, .sound];
        UNUserNotificationCenter.current().requestAuthorization(options: notificationOptions) { (granted, error) in
            if !granted {
                print("notification permission not granted")
                self.requestNecessaryPermissions()
            }
        }
    }
    
    func fetchLocationAndStartPositioninig() {
        
        UIApplication.shared.beginBackgroundTask {
            print("can't fetch location")
            UIApplication.shared.endBackgroundTask(self.fetchLocationTask)
            self.fetchLocationTask = UIBackgroundTaskInvalid
        }
        
        
        // You will find the identifier on https://cloud.estimote.com/#/locations
        // The Indoor Location SDK can work fully offline. Locations can be fetched only once (or bundled with the app) and later stored in NSUserDefault or similar storage as they conform to NSCoding
        
        // fetch orginal location
        let fetchLocation = EILRequestFetchLocation(locationIdentifier: "templates4")
        fetchLocation.sendRequest { (location, error) in
            if let location = location {
                self.backgroundIndoorLocationManager.startPositionUpdates(for: location)
                print(location, "this is the location for templates")
            } else {
                 let estimoterror = Database.database().reference().child("Error").child((Auth.auth().currentUser?.uid)!)
                estimoterror.childByAutoId().setValue(error)
                
                print("can't fetch location: \(error!)")
            }
            UIApplication.shared.endBackgroundTask(self.fetchLocationTask)
            self.fetchLocationTask = UIBackgroundTaskInvalid
        }
        
        let fetchLocationPalletes = EILRequestFetchLocation(locationIdentifier: "boomboom")
        fetchLocationPalletes.sendRequest { (location, error) in
            if let location = location {
                print(location, "THIS IS THE LOCATION")
                self.backgroundIndoorLocationManager.startPositionUpdates(for: location)
            } else {
                print("can't fetch location: \(error!)")
                let estimoterror = Database.database().reference().child("Error").child((Auth.auth().currentUser?.uid)!)
                estimoterror.childByAutoId().setValue(error)
            }
            UIApplication.shared.endBackgroundTask(self.fetchLocationTask)
            self.fetchLocationTask = UIBackgroundTaskInvalid
        }
        
        
        let fetchLocationLayers = EILRequestFetchLocation(locationIdentifier: "layers")
        fetchLocationLayers.sendRequest { (location, error) in
            if let location = location {
                print(location, "THIS IS THE LOCATION")
                self.backgroundIndoorLocationManager.startPositionUpdates(for: location)
            } else {
                print("can't fetch location: \(error!)")
                let estimoterror = Database.database().reference().child("Error").child((Auth.auth().currentUser?.uid)!)
                estimoterror.childByAutoId().setValue(error)
            }
            UIApplication.shared.endBackgroundTask(self.fetchLocationTask)
            self.fetchLocationTask = UIBackgroundTaskInvalid
        }
        
        
        
        
    }
    
    func backgroundIndoorLocationManager(_ locationManager: EILBackgroundIndoorLocationManager, didFailToUpdatePositionWithError error: Error) {
        print("failed to update position: \(error)")
    }
    
    func backgroundIndoorLocationManager(_ locationManager: EILBackgroundIndoorLocationManager, didUpdatePosition position: EILOrientedPoint, with positionAccuracy: EILPositionAccuracy, in location: EILLocation) {
        
        print(location.name)
      
            if  location.name == "boomboom" {
                _ = FirebaseStruct(user: (Auth.auth().currentUser?.uid)!, timestamp: Int(Date().timeIntervalSince1970), xCoordinate: position.x, yCoordinate: position.y , location: "Palletes")
            }
            if location.name == "templates4" {
                _ = FirebaseStruct(user: (Auth.auth().currentUser?.uid)!, timestamp: Int(Date().timeIntervalSince1970), xCoordinate: position.x, yCoordinate: position.y , location: "Templates")
            }
        
        if location.name == "layers" {
            print("currently in layers")
            _ = FirebaseStruct(user: (Auth.auth().currentUser?.uid)!, timestamp: Int(Date().timeIntervalSince1970), xCoordinate: position.x, yCoordinate: position.y , location: "Layers")
        }
    
    
        
            
            
            
//                                let content = UNMutableNotificationContent()
//                                content.title = "Templates"
//                                content.body = "\(position)"
//                                content.sound = UNNotificationSound.default()
//                                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
//                                let identifier = "location"
//                                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
//                                UNUserNotificationCenter.current().add(request, withCompletionHandler: {
//                                    (error) in
//                                })
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
      // need to create 5 different notifications
            
          
            
            //        let trigger = UNCalendarNotificationTrigger(dateMatching: date2, repeats: true)
            //        let request = UNNotificationRequest(identifier: "notification1", content: content, trigger: trigger)
            //        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
    
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


