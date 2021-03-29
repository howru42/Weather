//
//  HttpManager.swift
//  WeatherApp
//
//  Created by PMTIOS on 28/03/21.
//

import UIKit

class HttpManager: NSObject {
    static let shared = HttpManager()
    typealias CompletionHandler = (_ response:Any?,_ error:String?) -> Void
    
    func fetchWeather(_ coordinate:Coordinates,completion:@escaping CompletionHandler){
        let session = URLSession.shared
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.lat)&lon=\(coordinate.lon)&appid=fae7190d7e6433ec3a45285ffcf55c86&units=metric"){
            session.dataTask(with: url) { (data, response, error) in
                if let data = data{
                    if let response = try? JSONDecoder().decode(WeatherResponse.self, from: data){
                        completion(response,nil)
                    }
                }
                if let error = error{
                    print(error)
                    completion(nil,error.localizedDescription)
                }
            }.resume()
        }
        
    }
    
    func fetchForecast(_ coordinate:Coordinates,completion:@escaping CompletionHandler){
        let session = URLSession.shared
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=\(coordinate.lat)&lon=\(coordinate.lon)&appid=fae7190d7e6433ec3a45285ffcf55c86&units=metric"){
            session.dataTask(with: url) { (data, response, error) in
                if let data = data{
                    if let response = try? JSONDecoder().decode(ForecastResponse.self, from: data){
                        print(response)
                        completion(response,nil)
                    }
                }
                if let error = error{
                    print(error)
                    completion(nil,error.localizedDescription)
                }
            }.resume()
        }
        
    }
}
