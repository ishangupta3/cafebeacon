//
//  EditController.swift
//  IndoorInBackground
//
//  Created by ishgupta on 4/17/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import UIKit
import os.log

import Firebase
import UserNotifications

class ReviewViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    
    var stations = [""]
    
    
    var meal: Meal?
    let date = Date()
    var locationChosen = ""
    
    var currentDateInstance = translateUnixTime(time: getCurrentUnixTime())
    override func viewDidLoad() {
        
        extractEntrees()
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        reviewTextField.delegate = self
        navigationItem.title = "Update | Review"
        
        createDate()
        
        
        if let meal = meal {
            ratingControl.rating = meal.rating
            
            
            print(meal.mealLocation)
            print(meal.groundTruth)
            print("this is the ground truth")
            locationChosen = meal.mealLocation
            thankyouOutlet.text = meal.mealLocation
            
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var thankyouOutlet: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var save: UIBarButtonItem!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var reviewTextField: UITextField!
    
    @IBOutlet weak var dateForReview: UILabel!
    
    
    // creates customizeable date for Review Screen
    
    func createDate() {
        dateForReview.text = date.getDayMonthInfo()
        if let meal = meal {
            var cellDate = meal.date
            dateForReview.text = getReviewDate(time: meal.date)
        }
        
    }
    
    // returns the number of 'columns' to display.
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
        else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = stations[row]
        return pickerLabel!
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(stations[row])
        if stations[row] != "" {
            locationChosen = stations[row] // setting the users location preference to location chosen
            thankyouOutlet.text = locationChosen
        }
        
        
    }
    
    // Below code for Review Text Field
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func textFieldAction(_ sender: Any) {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        
    }
    
    func updateSaveState() {
        
        
    }
    
    @IBOutlet weak var textField: UITextField!
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: Any?)
        
        let mealtableInstance = MealTableViewController()
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === save else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let review = reviewTextField.text ?? ""
        let rating = ratingControl.rating
        let location = locationChosen
        
        if let meal = meal {
            currentDateInstance = translateUnixTime(time: meal.date)
        }
        
        print(review,rating,location, currentDateInstance, "THIS IS EVERYTHING TURNT")
        meal = Meal(rating: rating, mealLocation: location, date: (meal?.date)!, groundTruth: "green")
        
        
        
        print(currentDateInstance, "THIS IS THE MOST TURNT DATE IN THE WORLD")
        //        mealtableInstance.loadSampleMeals()
        
        let x = ReviewStruct(rating: rating, reviewText: review, location: location, date: currentDateInstance)
        
    }
    
    func extractEntrees() { // extracting the entrees
        
        if let meal = meal {
            currentDateInstance = translateUnixTime(time: meal.date)
        }
        
        let date = Date()
        
        print(date.getDayMonthInfo())
        let ref = Database.database().reference().child("entree").child(currentDateInstance)
        
        ref.queryOrdered(byChild: "label").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            self.stations.append(String(describing: dictionary["label"]!))
            
            
            self.pickerView.reloadAllComponents()
            
        }) { (err) in
            print("Failed to fetch ordered posts:", err)
        }
        
        
        self.pickerView.reloadAllComponents()
    }
    
    
    
    
    
    
    
}
