//
//  WebViewPalletes.swift
//  IndoorInBackground
//
//  Created by ishgupta on 3/16/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import UIKit
import WebKit

class WebViewPalletes: UIViewController, WKUIDelegate {

    var palletesWebView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        palletesWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        palletesWebView.uiDelegate = self
        view = palletesWebView
        navigationItem.title = "Palettes"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebsite()


    }
    
    
    func loadWebsite() {
        DispatchQueue.global(qos: .userInitiated).async {
            let palletesURL = URL(string: "http://san-jose.cafebonappetit.com/cafe/palettes/")
            let request = URLRequest(url: palletesURL!)
            DispatchQueue.main.async { 
                self.palletesWebView.load(request)
            }
        }
        
    }

   

}
