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
    @IBOutlet weak var selectionView:UIView!
    var isItemSelecte:Bool = false{
        didSet{
            selectionView.isHidden = !isItemSelecte
        }
    }
    
    var colors:[UIColor] = [AppColors.blueColor,AppColors.redColor,AppColors.orangeColor,AppColors.yellowColor]
    
    var randomColor:UIColor{
        get{
            return colors[Int.random(in: 0..<4)]
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionView.isHidden = true
        bgView.backgroundColor = randomColor
        bgView.layer.cornerRadius = 20
        backgroundColor = .clear
        cityName.font = .boldSystemFont(ofSize: 20)
        weatherLbl.font = .systemFont(ofSize: 20)
        tempLbl.tempFont = .boldSystemFont(ofSize: 30)
        
    }
    
    func setDetails(_ weather:WeatherResponse) {
        
        tempLbl.temperature = weather.temp()
        cityName.text = weather.name
        tempMaxMinLbl.text = weather.minMaxTemp()
        weatherLbl.text = weather.weather.first?.description ?? ""
        if let temp = weather.weather.first{
            weatherImg.image = temp.weatherIcon
        }
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
