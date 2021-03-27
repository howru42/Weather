//
//  HttpManager.swift
//  WeatherApp
//
//  Created by PMTIOS on 28/03/21.
//

import UIKit

class HttpManager: NSObject {
    static let shared = HttpManager()
    
    func fetchURL(){
        let session = URLSession.shared
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=17.461298&lon=78.431648&appid=fae7190d7e6433ec3a45285ffcf55c86"){
            session.dataTask(with: url) { (data, response, error) in
                if let data = data{
                    if let de = try? JSONDecoder().decode(WeatherResponse.self, from: data){
                        print(de)
                    }
//                    print(data)
                }
//                if let response = response{
//                    print(response)
//                }
                if let error = error{
                    print(error)
                }
            }.resume()
        }
        
    }
}
