//
//  RequestManager.swift
//  Currency Converter
//
//  Created by hesham ghalaab on 1/13/21.
//

import Foundation

class RequestManager<R: Decodable> {
    
    typealias Handler<R> = (Result<R, RequestError>) -> ()
    func request(_ endpoint: Endpoint, then handler: @escaping Handler<R>) {
        
        guard let url = endpoint.url else {
            return handler(.failure(.invalidURL))
        }

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in

            if let error = error{
                handler(.failure(.network(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                handler(.failure(.emptyData))
                return
            }
            
            do{
                let response = try JSONDecoder().decode(R.self, from: data)
                handler(.success(response))
                
            }catch{
                handler(.failure(.decoding))
            }
        }

        task.resume()
    }
}

enum RequestError: Error, LocalizedError {
    case invalidURL
    case emptyData
    case decoding
    case network(_ error: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "invalid url , please make sure to use a valid url."
        case .emptyData:  return "Cannot handle the data, please try again later."
        case .decoding:   return "UnExpected decoding Error!"
        case .network(let text): return text
        }
    }
}
