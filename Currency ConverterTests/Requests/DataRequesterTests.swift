//
//  DataRequesterTests.swift
//  Currency ConverterTests
//
//  Created by hesham ghalaab on 1/15/21.
//

import XCTest
@testable import Currency_Converter

class DataRequesterTests: XCTestCase {
    
    let absolutePath = "http://data.fixer.io/api/latest"
    let invalidAbsolutePath = "htp://data.fer.io/api/lest"
    
    func testRequestingData_whenTheRequestIsSucceed() {
        let session = URLSessionMock()
       
        // Create data and tell the session to always return it
        let data = Data([0, 1, 0, 1])
        session.data = data
        
        let dataRequester = DataRequester(urlSession: session)
        let feed = FixerFeed(absolutePath: absolutePath, parameters: [:])
        
        var responseData: Data?
        dataRequester.requestData(from: feed) {
            switch $0 {
            case .success(let response):
                responseData = response
            case .failure(_):
                XCTFail("Shouldn't have called")
            }
        }
        XCTAssertEqual(responseData, data)
    }
    
    func testRequestingData_whenTheRequestIsFailedWithNonFatalError() {
        let session = URLSessionMock()
        let dataRequester = DataRequester(urlSession: session)
        
        let feed = FixerFeed(absolutePath: invalidAbsolutePath, parameters: [:])
        
        var fetchError: FetchError?
        dataRequester.requestData(from: feed) {
            switch $0 {
            case .success(_):
                XCTFail("Shouldn't have called")
            case .failure(let error):
                fetchError = error
            }
        }
        XCTAssertEqual(fetchError, .nonFatal)
    }

}
