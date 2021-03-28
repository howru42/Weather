//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by PMTIOS on 27/03/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var tempLbl:LabelWithUnits!
    @IBOutlet weak var cityLbl:UILabel!
    @IBOutlet weak var weatherLbl:UILabel!
    @IBOutlet weak var minMaxTempLbl:UILabel!
    
    @IBOutlet weak var day1Lbl:LabelWithWeatherIcon!
    @IBOutlet weak var day2Lbl:LabelWithWeatherIcon!
    @IBOutlet weak var day3Lbl:LabelWithWeatherIcon!
    @IBOutlet weak var day4Lbl:LabelWithWeatherIcon!
    @IBOutlet weak var day5Lbl:LabelWithWeatherIcon!
    
    @IBOutlet weak var sunriseLbl:MultiLabel!
    @IBOutlet weak var sunsetLbl:MultiLabel!
    @IBOutlet weak var feelsLbl:MultiLabel!
    @IBOutlet weak var pressureLbl:MultiLabel!
    @IBOutlet weak var humidityLbl:MultiLabel!
    @IBOutlet weak var visibilityLbl:MultiLabel!
    @IBOutlet weak var windLbl:MultiLabel!
    @IBOutlet weak var cloudsLbl:MultiLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        HttpManager.shared.fetchURL()
        
        tempLbl.temperature = ("27","C")
        tempLbl.tempFont = .boldSystemFont(ofSize: 50)
        cityLbl.text = "Hyderabad"
        weatherLbl.text = "Mostly Clear"
        minMaxTempLbl.text = "H:37 L:20"
        
        day1Lbl.setDetails("Mon", "Mar 20", "Haze", "30")
        day2Lbl.setDetails("Tue", "Mar 21", "Haze", "30")
        day3Lbl.setDetails("Wed", "Mar 22", "Haze", "30")
        day4Lbl.setDetails("Thu", "Mar 23", "Haze", "30")
        day5Lbl.setDetails("Fri", "Mar 24", "Haze", "30")
        
     
        sunriseLbl.setDetails("Sunrise","6:12AM")
        sunsetLbl.setDetails("Sunset","6:12PM")
        humidityLbl.setDetails("humidity","6:12AM")
        feelsLbl.setDetails("Sunrise","6:12AM")
        pressureLbl.setDetails("Sunrise","6:12AM")
        visibilityLbl.setDetails("Sunrise","6:12AM")
        windLbl.setDetails("Wind","5 KPH")
        cloudsLbl.setDetails("Clouds","40")
        
    }

   

}

