//
//  LabelWithUnits.swift
//  WeatherApp
//
//  Created by PMTIOS on 28/03/21.
//

import UIKit

@IBDesignable
class LabelWithUnits: UIView {

    private lazy var lbl = UILabel()
    private lazy var degreeIconView = UIImageView()
    private lazy var unitsLbl = UILabel()
    
    @IBInspectable var units:String{
        get{ return unitsLbl.text ?? "" }
        set{ unitsLbl.text = newValue}
    }
    
    @IBInspectable var lblText:String{
        get{ return lbl.text ?? ""}
        set{ lbl.text = newValue}
    }
    
    var temperature:(String,String){
        get{ return (lblText,units)}
        set{
            lblText = newValue.0
            units = newValue.1
        }
    }
    
    var tempFont:UIFont{
        get{ return lbl.font}
        set{ lbl.font = newValue }
    }
    
    var color:UIColor{
        get{return lbl.textColor}
        set{ lbl.textColor = newValue
            unitsLbl.textColor = newValue
            degreeIconView.tintColor = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        let view = UIView(frame: frame)
        lbl.textColor = .black
        lbl.font = tempFont
        degreeIconView.image = UIImage(named: "degree")?.withRenderingMode(.alwaysTemplate)
        degreeIconView.tintColor = .black
        view.addSubview(lbl)
        view.addSubview(degreeIconView)
        view.addSubview(unitsLbl)
        addSubview(view)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        degreeIconView.translatesAutoresizingMaskIntoConstraints = false
        unitsLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lbl.centerYAnchor.constraint(equalTo: centerYAnchor),
            lbl.centerXAnchor.constraint(equalTo: centerXAnchor,constant: -10),
            degreeIconView.widthAnchor.constraint(equalToConstant: 8),
            degreeIconView.heightAnchor.constraint(equalToConstant: 8),
            degreeIconView.topAnchor.constraint(equalTo: lbl.topAnchor,constant: 4),
            degreeIconView.leadingAnchor.constraint(equalTo: lbl.trailingAnchor),
            unitsLbl.leadingAnchor.constraint(equalTo: degreeIconView.trailingAnchor),
            unitsLbl.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
