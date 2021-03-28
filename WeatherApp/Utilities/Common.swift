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
