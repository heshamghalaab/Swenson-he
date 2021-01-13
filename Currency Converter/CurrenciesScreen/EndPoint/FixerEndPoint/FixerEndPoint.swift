//
//  FixerEndPoint.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/13/21.
//

import Foundation

struct FixerEndPoint: Endpoint{
    var path: String
    var queryItems: [URLQueryItem]
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = Fixer.SCHEME
        components.host = Fixer.HOST
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
    
    static func latest() -> FixerEndPoint {
        return FixerEndPoint(
            path: "/api/latest",
            queryItems: [
                URLQueryItem(name: "access_key", value: Fixer.ACCESS_KEY)
            ]
        )
    }
}
