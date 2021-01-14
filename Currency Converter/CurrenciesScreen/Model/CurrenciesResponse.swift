//
//  CurrenciesResponse.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/13/21.
//

import Foundation

struct CurrenciesResponse: Decodable {
    let success: Bool
    let error: CurrenciesResponseError?
    let rates: [String: Double]?
}

struct CurrenciesResponseError: Decodable {
    let code: Int?
    let info: String?
    var message: String?{
        if let code = code{
            if let info = info{
                return info
            }else {
                return Fixer.errorCodes[code] ?? ""
            }
        }else{
            return "UnExpected Error."
        }
    }
}
