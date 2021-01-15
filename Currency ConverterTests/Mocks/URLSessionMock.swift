//
//  URLSessionMock.swift
//  Currency ConverterTests
//
//  Created by hesham ghalaab on 1/15/21.
//

import XCTest
@testable import Currency_Converter

class URLSessionMock: URLSessionRequesting {
    
    var timeoutIntervalForRequest: TimeInterval = 29
    var timeoutIntervalForResource: TimeInterval = 59
    
    // Properties that enable us to set exactly what data or error
    // we want our mocked URLSession to return for any request.
    var data: Data?
    var error: Error?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        let data = self.data
        let error = self.error
        return URLSessionDataTaskMock { completionHandler(data, nil, error) }
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        closure()
    }
}

extension FetchError: Equatable {
    public static func == (lhs: FetchError, rhs: FetchError) -> Bool {
        switch (lhs, rhs) {
        case (.noContentReturned, .noContentReturned):
            return true
        case (.httpError(statusCode: let lhsStatusCode), .httpError(statusCode: let rhsStatusCode)):
            return lhsStatusCode == rhsStatusCode
        case (.fatal, .fatal):
            return true
        case (.nonFatal, .nonFatal):
            return true
        default:
            return false
        }
    }
}
