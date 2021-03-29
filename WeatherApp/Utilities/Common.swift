//
//  Common.swift
//  WeatherApp
//
//  Created by PMTIOS on 27/03/21.
//

import UIKit
import CoreLocation

extension UIViewController{
    public func getNib(_ name:String) -> UINib{
        return UINib(nibName: name, bundle: nil)
    }
    
    func showAlert(title: String, msg: String, btn1Name:String, btn2Name:String = "",btn1Action:(()->Void)? = nil,btn2Action:(()->Void)? = nil){
        let controller = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: btn1Name, style: .default, handler: { (_) in
            btn1Action?()
        }))
        
        if !btn2Name.isEmpty {
            controller.addAction(UIAlertAction(title: btn2Name, style: .default, handler: { (_) in
                btn2Action?()
            }))
        }
        present(controller, animated: true, completion: nil)
    }
}

extension UIView{
    func dropShadow(color: UIColor, opacity: Float = 0.5,  radius: CGFloat = 1, scale: Bool = true) {
       layer.masksToBounds = false
       layer.shadowColor = color.cgColor
       layer.shadowOpacity = opacity
       layer.shadowOffset = CGSize(width: -1, height: 1)
       layer.shadowRadius = radius
       layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
       layer.shouldRasterize = true
       layer.rasterizationScale = scale ? UIScreen.main.scale : 1
     }
}

extension UIColor{
    func rgb(red:CGFloat,green:CGFloat,blue:CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 0.7)
    }
}

extension UserDefaults {
    open func setStructArray<T: Codable>(_ value: [T], forKey defaultName: String){
        let data = value.map { try? JSONEncoder().encode($0) }
        
        set(data, forKey: defaultName)
    }
    
    open func structArrayData<T>(_ type: T.Type, forKey defaultName: String) -> [T] where T : Decodable {
        guard let encodedData = array(forKey: defaultName) as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
}

extension CGFloat{
    func temp() -> String {
        return "\(Int(rounded()))"
    }
}

extension Double{
    func toDate() -> Date{
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}

extension Date{
    func time(_ format:String = "h:mm a") -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func toString(_ format:String = "ddd" ) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension String{
    func toDate(format:String = "MMM d") -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date!
    }
}
