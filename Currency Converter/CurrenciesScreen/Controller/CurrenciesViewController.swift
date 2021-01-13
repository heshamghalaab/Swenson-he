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
    
    // MARK: Properties
    let cellIdentifier = "RateCell"
    var currencies = [Currency]()
    
    // MARK: Override Functions
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
        setupUI()
        getCurrencies()
    }
    
    // MARK: Methods
    // configuration: to configure any protocols
    private func configuration(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // setupUI: to setup data or make a custom design
    private func setupUI(){
        
    }
    
    // MARK: Actions
    private func getCurrencies(){
        let manager = RequestManager<CurrenciesResponse>()
        manager.request(FixerEndPoint.latest()) { [weak self] (result) in
            guard let self = self else {return}
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                DispatchQueue.main.async {
                    self.currencies = response.rates.map({ Currency(name: $0.key, rate: $0.value) })
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension CurrenciesViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let currency = currencies[indexPath.row]
        cell.textLabel?.text = currency.name
        cell.detailTextLabel?.text = currency.rate.description
        cell.imageView?.image = UIImage(named: currency.flag)
        return cell
    }
}

