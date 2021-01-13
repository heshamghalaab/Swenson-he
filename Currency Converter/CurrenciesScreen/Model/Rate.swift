//
//  Rate.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/13/21.
//

import Foundation

struct Currency {
    let name: String
    let rate: Double
    var flag: String {name.lowercased()}
}
