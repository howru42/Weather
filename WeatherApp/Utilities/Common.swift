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
extension UIView{
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 10, scale: Bool = true) {
       layer.masksToBounds = false
       layer.shadowColor = color.cgColor
       layer.shadowOpacity = opacity
       layer.shadowOffset = offSet
       layer.shadowRadius = radius
       layer.cornerRadius = 10
       layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
       layer.shouldRasterize = true
       layer.rasterizationScale = scale ? UIScreen.main.scale : 1
     }
}
