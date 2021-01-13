//
//  CurrencyRatesResponse.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/13/21.
//

import Foundation

struct CurrencyRatesResponse: Decodable {
    let success: Bool
    let timestamp: TimeInterval
    let base: String
    let date: String
    let rates: [String: Double]
}
