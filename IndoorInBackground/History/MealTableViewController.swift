//
//  MealTableViewController.swift
//  IndoorInBackground
//
//  Created by ishgupta on 5/1/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import os.log
import UserNotifications


class MealTableViewController: UITableViewController {
    
    
    
    var meals = [Meal]() // creating an empty arrary of Meal objects
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     // loading data
       loadSampleMeals()
        navigationItem.title = "Your Meals"
        //fetchPredictions()
        runNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
      //  loadSampleMeals()
    }
    
   
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
        
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return meals.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("the cell is not an instance of the MealTableViewCell")
        }

      let meal = meals[indexPath.row]
      cell.rating.rating = meal.rating
      cell.nameLabel.text = meal.mealLocation
      cell.dateLabel.text = getReviewDate(time: meal.date)
        

      cell.nameLabel.textColor = UIColor.white
        
        if meal.groundTruth == "green" {
            cell.nameLabel.backgroundColor = UIColor.green
        } else{
            cell.nameLabel.backgroundColor = UIColor.red
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "showDetail":
            guard let mealDetailViewController = segue.destination as? ReviewViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
        
    }

    
    // Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        print("clicked saved")

        if let sourceViewController = sender.source as? ReviewViewController, let meal = sourceViewController.meal {

            print(meal.rating, "This is the ratingfgwieo")
            print(meal.mealLocation, "This is the meal location")
            print(meal.date, "this is the date")

            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                meals[selectedIndexPath.row] = meal
                print(meals[selectedIndexPath.row],"VERY VERY VERY INTERESTNG343485934#$%#$%#")
                print(meal.rating,"ALSO AALSFJA")
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }



           // ReviewStruct(rating: meal.rating, reviewText: meal.mealReview, location: meal.mealLocation)
        }
    }
    

    

    
        func loadSampleMeals() {
        
       
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("predictions").child(uid)
        
        ref.queryOrdered(byChild: "date").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            
            guard let meal = Meal(rating: dictionary["rating"] as! Int,
                                  mealLocation: dictionary["mealPrediction"] as! String ,
                                  date: dictionary["date"] as! Double ,
                                  groundTruth: dictionary["groundTruth"] as! String ) else {
                fatalError("not able to instatiate")
            }
            
            
            self.meals.insert(meal, at: 0)
          
            print(self.meals.count, "fhuiahfjiewarhfho")
            print(meal.rating, "THIS IS THE CURRENT RATING")
            self.tableView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch ordered posts:", err)
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
        
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: date2, repeats: true)
        //        let request = UNNotificationRequest(identifier: "notification1", content: content, trigger: trigger)
        //        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    

}
