//
//  WeatherData.swift
//  WeatherApp
//
//  Created by PMTIOS on 28/03/21.
//

import UIKit

struct WeatherResponse:Codable{
    var coord:Coordinates
    var weather:[WeatherDetails]
    var base:String
    var main:Temperature
    var wind:Wind
    var clouds:Clouds
    var name:String
}

struct Coordinates:Codable{
    var lon:CGFloat
    var lat:CGFloat
}

struct WeatherDetails:Codable {
    var id:Int
    var weatherType:String
    var description:String
    enum CodingKeys: String, CodingKey {
        case weatherType = "main"
        case id,description
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

