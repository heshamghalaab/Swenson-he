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
    let currencyComparisonSegueId = "currencyComparisonSegue"
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Fixer.SCHEME
        components.host = Fixer.HOST
        components.path = "/api/latest"
        return components.url
    }
    
    // MARK: - View controller lifecycle methods

    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currenciesConfiguration()
        baseCurrencyConfiguration()
        setBaseCurrency(with: baseCurrency)
        getLatestCurrencies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == currencyComparisonSegueId,
           let destination = segue.destination as? CurrenciesComparisonVC,
           let selectedCurrency = sender as? Currency{
            destination.baseCurrency = self.baseCurrency
            destination.selectedCurrency = selectedCurrency
        }
    }
    
    // MARK: - Configuration methods

    /// Configure Data source and delegate for currencies table view and its closures.
    private func currenciesConfiguration(){
        currenciesDataSource = CurrenciesDataSource()
        currenciesDelegate = CurrenciesDelegate()
        currenciesDelegate.didSelectCurrencyAt = { [weak self] indexPath in
            guard let self = self else {return}
            self.didSelectCurrency(at: indexPath)
        }
        
        let nib = UINib(nibName: CurrencyCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CurrencyCell.identifier)
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
    
    // MARK: - Currency API handling methods.
    
    private func getLatestCurrencies(){
        
        guard let feed = prepareFixerFeed() else {return}
        
        let manager = RequestManager()
        self.activityIndicator.startAnimating()
        
        manager.request(from: feed) { [weak self] in
            guard let self = self else {return}
            self.activityIndicator.stopAnimating()
            switch $0{
            case .failure(let error):
                self.alert(
                    title: self.DEFAULT_ERROR_Message,
                    message: error.errorDescription ?? "" , handler: {})
            case .success(let response):
                self.handleCurrenciesResponse(with: response)
            }
        }
    }
    
    /**
     Prepare Fixer Feed to get the latest currencies.

     use Fixer.isSubscriptionUpgraded = true if you need to add the base query item in the api as The current subscription plan does not support this API endpoint with base query item.
     
     -  base: the default base is USD.
     */
    private func prepareFixerFeed() -> FixerFeed?{
        guard let absoluteURL = url?.absoluteURL.absoluteString else { return nil }
        
        var parameters: [String: String] = [:]
        parameters["access_key"] = Fixer.ACCESS_KEY

        if Fixer.isSubscriptionUpgraded {
            parameters["base"] = baseCurrency.name
        }

        return FixerFeed(absolutePath: absoluteURL, parameters: parameters)
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
    
    // MARK: - Other methods
    
    private func setBaseCurrency(with currency: Currency){
        self.baseCurrency = currency
        self.baseCurrencyView.setBaseCurrency(with: currency)
    }
    
    private func didSelectCurrency(at indexPath: IndexPath){
        let currency = currenciesDataSource.currencies[indexPath.row]
        performSegue(withIdentifier: currencyComparisonSegueId, sender: currency)
    }
}
