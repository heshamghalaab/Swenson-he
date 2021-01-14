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
    
    /**
     Get the latest currencies.

     use Fixer.isSubscriptionUpgraded = true if you need to add the base query item in the api as The current subscription plan does not support this API endpoint with base query item.
     
     - Parameter base: the default base is USD.
     */
    static func latest(base: String) -> FixerEndPoint {
        var items = [URLQueryItem(name: "access_key", value: Fixer.ACCESS_KEY)]
        if Fixer.isSubscriptionUpgraded {
            items.append(URLQueryItem(name: "base", value: base))
        }
        
        return FixerEndPoint(
            path: "/api/latest",
            queryItems: items )
    }
}
