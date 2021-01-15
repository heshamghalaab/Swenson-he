//
//  CurrencyCell.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/14/21.
//

import UIKit

class CurrencyCell: UITableViewCell {

    @IBOutlet weak var currencyFlagImageView: UIImageView!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currencyRateLabel: UILabel!
    
    static let identifier = "CurrencyCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with currency: Currency){
        currencyNameLabel.text = currency.name
        currencyRateLabel.text = currency.rate.description
        
        let image = UIImage(named: currency.flag) ?? UIImage(systemName: "flag")
        currencyFlagImageView.image = image
    }
    
}
