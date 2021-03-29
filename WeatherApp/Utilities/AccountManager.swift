//
//  AccountManager.swift
//  WeatherApp
//
//  Created by PMTIOS on 28/03/21.
//

import Foundation

class AccountManager {
    static let shared = AccountManager()
    var weatherData:WeatherResponse?
    
    var locations:[WeatherResponse]{
        get{
            return UserDefaults.standard.structArrayData(WeatherResponse.self, forKey: "locations")
        }
        set{
            UserDefaults.standard.setStructArray(newValue, forKey: "locations")
        }
    }
}
