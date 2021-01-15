//
//  DataResponseDecoder.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/15/21.
//

import Foundation

enum DataResponseDecodeError: Error {
    case decodeToJsonFailed
}

protocol DataResponseDecoding {
    func decodeJson<F: Feed>(from feed: F, with data: Data) throws -> F.JSONResponseStructure
    func decodeModel<C: Decodable>(from data: Data) throws -> C
}

struct DataResponseDecoder: DataResponseDecoding {

    private let readingOptions: JSONSerialization.ReadingOptions

    init(readingOptions: JSONSerialization.ReadingOptions = .allowFragments) {
        self.readingOptions = readingOptions
    }

    func decodeJson<F: Feed>(from feed: F, with data: Data) throws -> F.JSONResponseStructure {
        let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)
        guard let jsonDict = json as? F.JSONResponseStructure else {
            throw DataResponseDecodeError.decodeToJsonFailed
        }
        return jsonDict
    }

    func decodeModel<C: Decodable>(from data: Data) throws -> C {
        let decoder = JSONDecoder.makeDecoder(with: nil)
        return try decoder.decode(C.self, from: data)
    }
}

extension JSONDecoder {
    static func makeDecoder(with customDateFormat: String?) -> JSONDecoder {
        guard let customDateFormat = customDateFormat else { return JSONDecoder() }
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = customDateFormat
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }
}
