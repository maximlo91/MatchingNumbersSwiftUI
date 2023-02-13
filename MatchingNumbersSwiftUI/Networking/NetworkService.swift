//
//  NetworkService.swift
//  MatchingNumbersSwiftUI
//
//  Created by Maxim Lobovich on 24/01/2023.
//

import Foundation
import Combine

struct NetworkService: NetworkServiceProtocol {
    
    let urlSession: URLSession!
    let baseURLString: String = "https://pastebin.com/"
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    public func send<R: Request>(request: R) -> AnyPublisher<R.ReturnType, NetworkError> {
        let fullRequestUrl = "\(baseURLString)\(request.endpoint)"
        var urlComponents = URLComponents(string: fullRequestUrl)
        urlComponents?.queryItems = getQueryParamsForRequest(with: request.queryParams)
        
        guard let url = urlComponents?.url else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = convertDictionaryToData(with: request.body)
        
        let publisher: AnyPublisher<R.ReturnType, NetworkError> = dispatch(request: urlRequest)
        return publisher
            .eraseToAnyPublisher()
    }
    
    private func dispatch<ReturnType: Codable>(request: URLRequest) -> AnyPublisher<ReturnType, NetworkError> {
        logNetworkDetails(request: request)
        
        return urlSession.dataTaskPublisher(for: request.url!)
            .tryMap { (data, response) -> Data in
                if let httpResponse = response as? HTTPURLResponse {
                    logNetworkDetails(response: httpResponse)
                    
                    guard 200..<300 ~= httpResponse.statusCode else {
                        throw NetworkError.invalidResponse(statusCode: httpResponse.statusCode)
                    }
                } else {
                    throw NetworkError.invalidResponse(statusCode: 0)
                }
                
                return data
            }
            .decode(type: ReturnType.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if let error = error as? NetworkError {
                    logNetworkDetails(error: error)
                    return error
                }
                
                if let decodingError = error as? DecodingError {
                    logNetworkDetails(error: NetworkError.decodingError((decodingError as NSError).code.description))
                    return .decodingError((decodingError as NSError).code.description)
                }
                
                logNetworkDetails(error: NetworkError.genericError(error.localizedDescription))
                return .genericError(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}

extension NetworkService: NetworkUtils {
    
    func convertDictionaryToData(with dict: [String: Any]?)->Data? {
        guard let dict else { return nil }
        let jsonData = try? JSONSerialization.data(withJSONObject: dict)
        return jsonData
    }
    
    func getQueryParamsForRequest(with params: [String: Any]?)->[URLQueryItem] {
        let queryParams: [String:Any] = params ?? [:]
        return queryParams.map {
            URLQueryItem(name: $0.key, value: $0.value as? String ?? "")
        }
    }

    func logNetworkDetails(request: URLRequest? = nil, response: HTTPURLResponse? = nil, error: Error? = nil) {
        var logs = ""
        
        if let request {
            logs = """
            NetworkService dispatch request:
            headers: \(request.allHTTPHeaderFields ?? [:])
            url: \(request.url?.absoluteString ?? "")
            method: \(request.httpMethod ?? "")
            body: \(request.httpBody ?? Data())
            
            """
        }
        
        if let response {
            logs = """
            NetworkService response:
            url: \(response.url?.absoluteString ?? "")
            status code: \(response.statusCode)
            
            """
        }
        
        if let error {
            logs = """
            NetworkService error:
            \(error.description)
            
            """
        }

        print(logs)
    }
}
