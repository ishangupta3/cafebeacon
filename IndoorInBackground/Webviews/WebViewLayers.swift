//
//  WebViewLayers.swift
//  IndoorInBackground
//
//  Created by ishgupta on 7/25/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import UIKit
import WebKit

class WebViewLayers: UIViewController, WKUIDelegate {

    var layersWebView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        layersWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        layersWebView.uiDelegate = self
        view = layersWebView
        navigationItem.title = "Layers"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebsite()
        
        
    }
    
    
    func loadWebsite() {
        DispatchQueue.global(qos: .userInitiated).async {
            let palletesURL = URL(string: "https://san-jose.cafebonappetit.com/cafe/layers/")
            let request = URLRequest(url: palletesURL!)
            DispatchQueue.main.async {
                self.layersWebView.load(request)
            }
        }
        
    }



}
