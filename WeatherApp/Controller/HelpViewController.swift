//
//  HelpViewController.swift
//  WeatherApp
//
//  Created by PMTIOS on 29/03/21.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {
    @IBOutlet weak var webView:WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pdf = Bundle.main.url(forResource: "help", withExtension: "pdf"){
            webView.load(URLRequest(url: pdf))
        }
    }

}
