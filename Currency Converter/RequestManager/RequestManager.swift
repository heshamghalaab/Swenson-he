//
//  RequestManager.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/13/21.
//

import Foundation
import os.log

enum FetchError: Error {
    case noContentReturned
    case httpError(statusCode: Int)
    case nonFatal
    case fatal
    
    var errorDescription: String? {
        switch self {
        case .nonFatal:
            return "invalid url , please make sure to use a valid url."
        case .fatal:
            return "UnExpected Error!"
        case .noContentReturned:
            return  "Cannot handle the data, please try again later."
        case .httpError(let statusCode):
            return "Error with code: \(statusCode)"
        }
    }
}

protocol CanRequestFeeds {
    func request<F: Feed>(from feed: F, completionHandler: @escaping (Result<F.JSONResponseStructure, FetchError>) -> Void)
}

struct RequestManager: CanRequestFeeds {
    
    private let dataRequester: DataRequesting
    private let responseDecoder: DataResponseDecoding

    init(dataRequester: DataRequesting = DataRequester(), responseDecoder: DataResponseDecoding = DataResponseDecoder()) {
        self.dataRequester = dataRequester
        self.responseDecoder = responseDecoder
    }
    
    func request<F: Feed>(from feed: F, completionHandler: @escaping (Result<F.JSONResponseStructure, FetchError>) -> Void) {
        dataRequester.requestData(from: feed) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    do {

                        let model: F.JSONResponseStructure = try self.responseDecoder.decodeModel(from: data)
                        completionHandler(.success(model))
                    } catch {
                        completionHandler(.failure(.noContentReturned))
                    }
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self.logDecodeError(error, from: feed)
                    completionHandler(.failure(error))
                }

            }
        }
    }

    private func logDecodeError<F: Feed>(_ error: Error, from feed: F) {
        switch error {
        case DataResponseDecodeError.decodeToJsonFailed:
            os_log("Error trying to unwrap feed: %@", log: .requestsLogger, type: .error, "\(F.self)")
            os_log("URL was: %@", log: .requestsLogger, type: .error, feed.absolutePath)
        default:
            os_log("Error trying to decode %@: %@", log: .requestsLogger, type: .error, "\(F.self)", error.localizedDescription)
            os_log("URL was: %@", log: .requestsLogger, type: .error, feed.absolutePath)
        }
    }
}
