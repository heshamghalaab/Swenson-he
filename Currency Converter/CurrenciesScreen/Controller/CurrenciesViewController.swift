//
//  CurrenciesViewController.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/13/21.
//

import UIKit

class CurrenciesViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var baseCurrencyView: BaseCurrencyView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    var currenciesDataSource: CurrenciesDataSource!
    var currenciesDelegate: CurrenciesDelegate!
    var baseCurrency = Currency(name: "USD", rate: 0)
    let DEFAULT_ERROR_Message = "Error while getting currencies"
    
    // MARK: Override Functions
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currenciesConfiguration()
        baseCurrencyConfiguration()
        setBaseCurrency(with: baseCurrency)
        getLatestCurrencies()
    }
    
    /// Configure Data source and delegate for currencies table view and its closures.
    private func currenciesConfiguration(){
        currenciesDataSource = CurrenciesDataSource()
        currenciesDelegate = CurrenciesDelegate()
        currenciesDelegate.didSelectCurrencyAt = { [weak self] indexPath in
            guard let self = self else {return}
            self.didSelectCurrency(at: indexPath)
        }
        
        tableView.dataSource = currenciesDataSource
        tableView.delegate = currenciesDelegate
    }
    
    /// Configure base Currency View and its closures.
    private func baseCurrencyConfiguration(){
        baseCurrencyView.editBaseCurrencyTapped = { [weak self] in
            guard let self = self else {return}
            let alert = UIAlertController(
                title: "Edit Base Currency",
                message: "Please make sure to write a correct currency",
                preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.placeholder = "Currency name"
            }
            
            let doneAction = UIAlertAction(title: "Done", style: .default) { (action) in
                let text = alert.textFields?.first?.text?.uppercased()
                self.editBaseCurrency(with: text)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            
            alert.addAction(doneAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /// Edit base currency with a value of string to validate that the user input is right.
    private func editBaseCurrency(with value: String?){
        guard let value = value else {
            self.alert(title: "Oups!", message: "Currency cannot be empty", handler: {})
            return
        }
        
        // validate the user input by searching
        // for his input in the last array of currencies.
        if let currency = currenciesDataSource.currencies.first(where: { $0.name == value}){
            self.setBaseCurrency(with: currency)
            self.getLatestCurrencies()
        }else{
            self.alert(
                title: "This currency is not found",
                message: "Please try another currency", handler: {})
        }
    }
    
    private func getLatestCurrencies(){
        let manager = RequestManager<CurrenciesResponse>()
        self.activityIndicator.startAnimating()
        manager.request(FixerEndPoint.latest(base: baseCurrency.name)) { [weak self] (result) in
            guard let self = self else {return}
            self.activityIndicator.stopAnimating()
            switch result{
            case .failure(let error):
                self.alert(
                    title: self.DEFAULT_ERROR_Message,
                    message: error.errorDescription ?? "", handler: {})
            case .success(let response):
                self.handleCurrenciesResponse(with: response)
            }
        }
    }
    
    private func handleCurrenciesResponse(with response: CurrenciesResponse){
        guard response.success else {
            let errorMessage = response.error?.message ?? DEFAULT_ERROR_Message
            self.alert(title: errorMessage , message: "", handler: {})
            return
        }
        
        guard let rates = response.rates else {
            self.alert(title: DEFAULT_ERROR_Message, message: "", handler: {})
            return
        }
        
        let currencies = rates.map({ Currency(name: $0.key, rate: $0.value) })
        self.setCurrencies(with: currencies)
    }
    
    private func setCurrencies(with currencies: [Currency]){
        self.currenciesDataSource.currencies = currencies
        self.tableView.reloadData()
        
        if let currency = currencies.first(where: { $0.name == self.baseCurrency.name}){
            self.setBaseCurrency(with: currency)
        }
    }
    
    private func setBaseCurrency(with currency: Currency){
        self.baseCurrency = currency
        self.baseCurrencyView.setBaseCurrency(with: currency)
    }
    
    private func didSelectCurrency(at indexPath: IndexPath){
        let currency = currenciesDataSource.currencies[indexPath.row]
        print("didSelectCurrency: \(currency)")
    }
}
