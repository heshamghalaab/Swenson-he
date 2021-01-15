//
//  FixerFeed.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/15/21.
//

import Foundation

struct FixerFeed: Feed {
    typealias JSONResponseStructure = CurrenciesResponse
    
    let absolutePath: String
    let parameters: [String: String]?
    
    init(absolutePath: String, parameters: [String: String]?) {
        self.absolutePath = absolutePath
        self.parameters = parameters
    }
}
