//
//  CurrenciesDataSourceTests.swift
//  Currency ConverterTests
//
//  Created by hesham ghalaab on 1/15/21.
//

import XCTest
@testable import Currency_Converter

class CurrenciesDataSourceTests: XCTestCase {
    
    private var dataSource: CurrenciesDataSource!
    
    override func setUp() {
        
        dataSource = CurrenciesDataSource()
        dataSource.currencies = [Currency(name: "Test", rate: 0.1)]
    }
    
    func testValueInDataSource() {
        
        let tableView = UITableView(frame: UIScreen.main.bounds)
        
        tableView.dataSource = dataSource
        
        XCTAssertEqual(tableView.numberOfSections, 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
    }
}
