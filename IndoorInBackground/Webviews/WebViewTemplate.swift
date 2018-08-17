//
//  Webviews.swift
//  IndoorInBackground
//
//  Created by ishgupta on 3/15/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import UIKit
import WebKit

class WebViewTemplate: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var webViewTemplate: WKWebView!
    var templateWebView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        
        templateWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        templateWebView.uiDelegate = self
        view = templateWebView
        navigationItem.title = "Templates"
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebsite()
    }
    
    
    
    func loadWebsite() {
        DispatchQueue.global(qos: .userInitiated).async { // 1
            let templateURL = URL(string: "https://san-jose.cafebonappetit.com/cafe/templates/")
            let request = URLRequest(url: templateURL!)
            DispatchQueue.main.async { // 2
                self.templateWebView.load(request)
            }
        }
        
    }
    
    
    
}
