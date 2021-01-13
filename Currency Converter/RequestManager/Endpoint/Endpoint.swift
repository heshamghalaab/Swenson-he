//
//  Endpoint.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/13/21.
//

import Foundation

protocol Endpoint {
    var path: String { get set }
    var queryItems: [URLQueryItem] { get set }
    
    // We have to keep 'url' as an optional, since we're
    // dealing with dynamic components that could be invalid.
    var url: URL? { get }
}
