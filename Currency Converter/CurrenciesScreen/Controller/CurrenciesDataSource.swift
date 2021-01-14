//
//  CurrenciesDataSource.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/14/21.
//

import UIKit

class CurrenciesDataSource: NSObject, UITableViewDataSource{
    
    var currencies = [Currency]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifier, for: indexPath) as! CurrencyCell
        let currency = currencies[indexPath.row]
        cell.configure(with: currency)
        return cell
    }
}
