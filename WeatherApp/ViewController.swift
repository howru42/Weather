//
//  ViewController.swift
//  WeatherApp
//
//  Created by PMTIOS on 27/03/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Weather Details"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(tappedAdd))
    }

    @IBAction func tappedAdd(_ sender:Any){
        print("Something....")
    }

}

