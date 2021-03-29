//
//  WeatherData.swift
//  WeatherApp
//
//  Created by PMTIOS on 28/03/21.
//

import UIKit

struct WeatherResponse:Codable{
    var coord:Coordinates?
    var weather:[WeatherDetails] = []
    var base:String? = ""
    var main:Temperature?
    var wind:Wind?
    var clouds:Clouds?
    var name:String? = ""
    var sys:Sys?
    var visibility:Int? = 0
    var dt:Double?
    
    func minMaxTemp() -> String {
        if let temp = main{
            return "\(temp.tempMax.temp()) / \(temp.tempMin.temp())"
        }
        return ""
    }
    
    func temp()-> (String, String){
        if let temp = main{
            return ("\(temp.temp.temp())","C")
        }
        return("0","C")
    }
    
    func getVisibilty() -> String {
        if let visibility = visibility {
            return "\(visibility/1000) km"
        }
        return ""
    }
    
}

struct Coordinates:Codable{
    var lon:Double
    var lat:Double
}

struct WeatherDetails:Codable {
    var id:Int
    var weatherType:String
    var description:String
    enum CodingKeys: String, CodingKey {
        case weatherType = "main"
        case id,description
    }
    var weatherIcon:UIImage?{
        get{
            switch weatherType {
            case "Snow":
                return UIImage(named: "snow")
            case "Rain":
                return UIImage(named: "rain")
            case "Clouds":
                return UIImage(named: "cloud")
            default:
                return UIImage(named: "sun")
            }
        }
    }
}

struct Temperature:Codable {
    var temp:CGFloat
    var feelsLike:CGFloat
    var tempMin:CGFloat
    var tempMax:CGFloat
    var pressure:Int
    var humidity:Int
    
    enum CodingKeys:String,CodingKey {
        case temp,pressure,humidity
        case feelsLike = "feels_like",tempMax = "temp_max", tempMin = "temp_min"
    }
}

struct Wind:Codable {
    var speed:CGFloat
    var deg:Int
}

struct Clouds:Codable{
    var all:Int
}

struct Sys:Codable {
    var sunset:Double?
    var sunrise:Double?
}


struct ForecastResponse:Codable {
    var city:City?
    var list:[WeatherResponse] = []
}

struct City:Codable {
    var name:String
}
