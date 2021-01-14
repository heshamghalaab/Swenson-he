//
//  CurrenciesDelegate.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/14/21.
//

import UIKit

class CurrenciesDelegate: NSObject, UITableViewDelegate{
    
    var didSelectCurrencyAt: ((_ indexPath: IndexPath) -> ())?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCurrencyAt?(indexPath)
    }
}
