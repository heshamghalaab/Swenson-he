//
//  CurrenciesDataSource.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/14/21.
//

import UIKit

class CurrenciesDataSource: NSObject, UITableViewDataSource{
    
    let CELL_IDENTIFIER = "CurrencyCell"
    var currencies = [Currency]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath)
        let currency = currencies[indexPath.row]
        cell.textLabel?.text = currency.name
        cell.detailTextLabel?.text = currency.rate.description
        
        let image = UIImage(named: currency.flag) ?? UIImage(systemName: "flag")
        cell.imageView?.image = image
        
        return cell
    }
}
