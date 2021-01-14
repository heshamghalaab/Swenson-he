//
//  CurrencyDetailsView.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/14/21.
//

import UIKit

class CurrencyDetailsView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet weak private var rateLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    
    private let IDENTIFIER = "CurrencyDetailsView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(IDENTIFIER, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    func setCurrency(with currency: Currency?){
        rateLabel.text = currency?.rate.description
        nameLabel.text = currency?.name
    }
}


