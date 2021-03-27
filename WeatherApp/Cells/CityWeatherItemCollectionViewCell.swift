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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .darkGray
        layer.cornerRadius = 10
    }
    
    func setDetails(_ city:String, _ temp:String,_ maxTemp:String,_ weatherStatus:String) {
        cityName.text = city
        cityName.font = .boldSystemFont(ofSize: 20)
        weatherLbl.font = .systemFont(ofSize: 20)
        tempLbl.tempFont = .boldSystemFont(ofSize: 30)
        tempLbl.temperature = (temp,"C")
        tempMaxMinLbl.text = maxTemp
        weatherLbl.text = weatherStatus
        weatherImg.image = UIImage(named: "sun")
    }

}
