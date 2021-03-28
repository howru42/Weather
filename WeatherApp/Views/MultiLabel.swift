//
//  MultiLabel.swift
//  WeatherApp
//
//  Created by PMTIOS on 28/03/21.
//

import UIKit

@IBDesignable class MultiLabel: UIView {
    @IBOutlet weak var headerLbl:UILabel!
    @IBOutlet weak var valueLbl:UILabel!
    @IBOutlet weak var seperator:UIView!
    @IBOutlet weak var contentView:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        Bundle.main.loadNibNamed("MultiLabel", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func setDetails(_ header:String,_ value:String){
        headerLbl.text = header.uppercased()
        valueLbl.text = value.uppercased()
    }
}
