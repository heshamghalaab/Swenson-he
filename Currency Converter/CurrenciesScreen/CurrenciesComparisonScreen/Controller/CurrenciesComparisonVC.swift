//
//  CurrenciesComparisonVC.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/14/21.
//

import UIKit

class CurrenciesComparisonVC: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var baseCurrencyView: CurrencyDetailsView!
    @IBOutlet weak var selectedCurrencyView: CurrencyDetailsView!
    
    // MARK: Properties
    
    var baseCurrency: Currency?
    var selectedCurrency: Currency?
    
    // MARK: - View controller lifecycle methods
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        configuration()
    }
    
    private func setupData(){
        baseCurrencyView.setCurrency(with: baseCurrency)
        selectedCurrencyView.setCurrency(with: selectedCurrency)
    }
    
    private func configuration(){
        view.isUserInteractionEnabled = true
        let tabGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(onTapDismiss(_:)))
        view.addGestureRecognizer(tabGesture)
    }
    
    @objc private func onTapDismiss(_ sender: UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
}
