//
//  Fixer.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/13/21.
//

import Foundation

class Fixer {
    static let ACCESS_KEY = "2ec3d7328f6feca8e4ce814485c062b2"
    static let SCHEME = "http"
    static let HOST = "data.fixer.io"
    
    
    static let errorCodes: [Int: String] = [
        404: "The requested resource does not exist.",
        101: "No API Key was specified or an invalid API Key was specified.",
        103: "The requested API endpoint does not exist.",
        104: "The maximum allowed API amount of monthly API requests has been reached.",
        105: "The current subscription plan does not support this API endpoint.",
        106: "The current request did not return any results.",
        102: "The account this API request is coming from is inactive.",
        201: "An invalid base currency has been entered.",
        202: "One or more invalid symbols have been specified.",
        301: "No date has been specified.",
        302: "An invalid date has been specified.",
        403: "No or an invalid amount has been specified.",
        501: "No or an invalid timeframe has been specified.",
        502: "No or an invalid start_dae has been specified.",
        503: "No or an invalid end_date has been specified.",
        504: "An invalid timeframe has been specified.",
        505: "The specified timeframe is too long, exceeding 365 days."
    ]
    
    static let isSubscriptionUpgraded: Bool = false
}
