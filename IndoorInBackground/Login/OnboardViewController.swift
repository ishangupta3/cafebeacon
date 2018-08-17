//
//  OnboardViewController.swift
//  IndoorInBackground
//
//  Created by ishgupta on 7/16/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import UIKit
import Firebase



class OnboardViewController: UIViewController, UIScrollViewDelegate {
    
    let delegate = AppDelegate()
    let loginInstance = LoginViewControllerEstimote()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    // DO A CHECK IF AUTH OBJECT INSTANCE IS AVAILIBLE THEN IF NOT DO ACCORDINGLY
    
    
    
    
    //self.requestNecessaryPermissions() // this is where location is being asked from the user ***********
    
    override func viewDidAppear(_ animated: Bool) {
        print(Auth.auth().currentUser?.uid)
        if Auth.auth().currentUser != nil {
            self.loginInstance.sendToLogin()
            
        }

    }
    
    override func viewDidLoad() {
        scrollView.delegate = self // enables access to methods
        super.viewDidLoad()
        let slides:[Slide] = createSlides()
        setUpSlideScrollView(slides: slides)
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubview(toFront: pageControl)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func createSlides() -> [Slide] {
        let slide1: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        //  slide1.label.text = "Slide 1"
        
        let slide2: Slide = Bundle.main.loadNibNamed("Slide2", owner: self, options: nil)?.first as! Slide
        
        let slide3: Slide = Bundle.main.loadNibNamed("Slide3", owner: self, options: nil)?.first as! Slide
        
        let slide4: Slide = Bundle.main.loadNibNamed("Slide4", owner: self, options: nil)?.first as! Slide
        
        let slide5: Slide = Bundle.main.loadNibNamed("Slide5", owner: self, options: nil)?.first as! Slide
        
        let slide6: Slide = Bundle.main.loadNibNamed("Slide6", owner: self, options: nil)?.first as! Slide
        
        let slide7: Slide = Bundle.main.loadNibNamed("Slide7", owner: self, options: nil)?.first as! Slide
        
        return [slide1, slide4, slide2,slide3,slide5,slide6, slide7]
        
        
        
    }
    
    func setUpSlideScrollView(slides:[Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        scrollView.isDirectionalLockEnabled = true
       
        
        for x in 0..<slides.count {
            slides[x].frame = CGRect(x: view.frame.width * CGFloat(x), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[x])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    
    
    
    
}



