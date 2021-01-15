//
//  Feed.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/15/21.
//

import Foundation

protocol Feed {
    associatedtype JSONResponseStructure: Decodable
    
    var absolutePath: String { get }
    var parameters: [String: String]? { get }
    var customDateFormat: String? { get }
}

extension Feed {
    var customDateFormat: String? { return nil }
}
