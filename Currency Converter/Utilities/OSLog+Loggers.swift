//
//  OSLog+Loggers.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/15/21.
//

import Foundation
import os.log

extension OSLog {

    private static let subsystem = Bundle.main.bundleIdentifier!
    static let modelsLogger = OSLog(subsystem: OSLog.subsystem, category: "Models")
    static let requestsLogger = OSLog(subsystem: OSLog.subsystem, category: "Requests")
}
