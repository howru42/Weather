//
//  Common.swift
//  WeatherApp
//
//  Created by PMTIOS on 27/03/21.
//

import UIKit

extension UIViewController{
    public func getNib(_ name:String) -> UINib{
        return UINib(nibName: name, bundle: nil)
    }
    
}
