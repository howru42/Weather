//
//  LabelWithWeatherIcon.swift
//  WeatherApp
//
//  Created by PMTIOS on 28/03/21.
//

import UIKit

class LabelWithWeatherIcon: UIView {

    @IBOutlet weak var dayLbl:UILabel!
    @IBOutlet weak var dateLbl:UILabel!
    @IBOutlet weak var weatherIcon:UIImageView!
    @IBOutlet weak var weatherLbl:LabelWithUnits!
    @IBOutlet weak var contentView:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        Bundle.main.loadNibNamed("LabelWithWeatherIcon", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func setDetails(_ day:String,_ date:String,_ weatherType:String,_ temp:String,_ icon:UIImage?) {
        dayLbl.text = day
        dateLbl.text = date
        weatherLbl.temperature = (temp,"C")
        if let icon = icon{
            weatherIcon.image = icon
        }
    }
}
