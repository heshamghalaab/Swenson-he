//
//  BaseCurrencyView.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/14/21.
//

import UIKit

class BaseCurrencyView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet weak private var flagImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    
    private let IDENTIFIER = "BaseCurrencyView"
    var editBaseCurrencyTapped: (() -> Void)?
    
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
        baseCurrencyConfiguration()
    }
    
    private func baseCurrencyConfiguration(){
        contentView.isUserInteractionEnabled = true
        let tabGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(onTapEditBaseCurrency(_:)))
        contentView.addGestureRecognizer(tabGesture)
    }
    
    @objc private func onTapEditBaseCurrency(_ sender: UITapGestureRecognizer){
        editBaseCurrencyTapped?()
    }
    
    func setBaseCurrency(with currency: Currency){
        nameLabel.text = currency.name
        let image = UIImage(named: currency.flag) ?? UIImage(systemName: "flag")
        flagImageView.image = image
    }
}
