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
    
    var selectedCity:WeatherResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = selectedCity else { return  }
        fetchForecast()
        
        tempLbl.temperature = city.temp()
        tempLbl.tempFont = .boldSystemFont(ofSize: 50)
        cityLbl.text = city.name
        weatherLbl.text = city.weather.first?.description
        minMaxTempLbl.text = city.minMaxTemp()
        visibilityLbl.setDetails("Visibility",city.getVisibilty())
        
        if let details = city.main{
            humidityLbl.setDetails("humidity","\(details.humidity)%")
            feelsLbl.setDetails("feels like","\(details.feelsLike.temp())")
            pressureLbl.setDetails("Pressure","\(details.pressure) hPa")
        }
        
        if let sys = city.sys,let sunset = sys.sunset,let sunrise = sys.sunrise{
            sunriseLbl.setDetails("Sunrise",sunset.toDate().time())
            sunsetLbl.setDetails("Sunset",sunrise.toDate().time())
        }

        if let wind = city.wind{
            windLbl.setDetails("Wind","\(wind.speed) KPH")
        }
        if let cloud = city.clouds{
            cloudsLbl.setDetails("Clouds","\(cloud.all)")
        }
    }

    func fetchForecast() {
        guard let coordinates = selectedCity?.coord else { return  }
        HttpManager.shared.fetchForecast(coordinates) { [weak self] (response, error) in
            if let error = error{
                self?.showAlert(title: error, msg: "", btn1Name: "OK")
            }else if let response = response as? ForecastResponse{
                var uniqueItems:[String:WeatherResponse]
                    = [:]
                var uniqueDates:[String] = []
                response.list.forEach { (item) in
                    if let date = item.dt?.toDate().time("MM/dd/yyyy"),!Array(uniqueItems.keys).contains(date){
                        uniqueItems[date] = item
                        uniqueDates.append(date)
                    }
                }
                
                let sortedItems = uniqueDates.sorted(by: {$0 < $1})
                debugPrint(sortedItems)
                DispatchQueue.main.async {
                    self?.updateForecastTemp(uniqueDates,uniqueItems)
                }
                
            }
        }
    }
   
    func updateForecastTemp(_ uniqueDates:[String],_ items:[String:WeatherResponse]) {
        let labels = [day1Lbl,day2Lbl,day3Lbl,day4Lbl,day5Lbl]
        for idx in 0..<labels.count {
            let date = uniqueDates[idx]
            if let item = items[date]{
                setDetails(labels[idx], item)
            }
        }
    }
    
    func setDetails(_ lbl:LabelWithWeatherIcon?,_ item:WeatherResponse){
        let dayDate = dayAndDate(item.dt)
        let weather = item.weather.first?.weatherType ?? ""
        lbl?.setDetails(dayDate.1,dayDate.0, weather, item.temp().0,item.weather.first?.weatherIcon ?? nil)
    }
    
    func dayAndDate(_ time:Double?) -> (String,String) {
        guard let time = time else { return ("","") }
        let displayDate = time.toDate().time("MMM d")
        let displayDay = time.toDate().time("E")
        return (displayDate,displayDay)
    }
}

