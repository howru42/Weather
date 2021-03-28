//
//  CityWeatherItemCollectionViewCell.swift
//  WeatherApp
//
//  Created by PMTIOS on 28/03/21.
//

import UIKit

class CityWeatherItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cityName:UILabel!
    @IBOutlet weak var weatherImg:UIImageView!
    @IBOutlet weak var tempLbl:LabelWithUnits!
    @IBOutlet weak var tempMaxMinLbl:UILabel!
    @IBOutlet weak var weatherLbl:UILabel!
    @IBOutlet weak var bgView:UIView!
    var colors:[UIColor] = [AppColors.blueColor,AppColors.redColor,AppColors.orangeColor,AppColors.yellowColor]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.backgroundColor = .clear
        layer.cornerRadius = 10
    }
    
    func setDetails(_ city:String, _ temp:String,_ maxTemp:String,_ weatherStatus:String) {
        let random = Int.random(in: 0..<4)
        let color = colors[random]
        backgroundColor = color
        cityName.text = city
        
        cityName.font = .boldSystemFont(ofSize: 20)
        weatherLbl.font = .systemFont(ofSize: 20)
        tempLbl.tempFont = .boldSystemFont(ofSize: 30)
        tempLbl.temperature = (temp,"C")
        
        tempMaxMinLbl.text = maxTemp
        weatherLbl.text = weatherStatus
        weatherImg.image = UIImage(named: "sun")
        setUI()
    }
    
    func setUI() {
        let color:UIColor = .black
        tempLbl.color = color
        cityName.textColor = color
        tempMaxMinLbl.textColor = color
        weatherLbl.textColor = color
    }

}
