//
//  NetworkModel.swift
//  MatchingNumbersSwiftUI
//
//  Created by Maxim Lobovich on 24/01/2023.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func send<R: Request>(request: R) -> AnyPublisher<R.ReturnType, NetworkError>
}

protocol NetworkUtils {
    func convertDictionaryToData(with dict: [String: Any]?)->Data?
    func getQueryParamsForRequest(with params: [String: Any]?)->[URLQueryItem]
    func logNetworkDetails(request: URLRequest?, response: HTTPURLResponse?, error: Error?)
}

protocol Request {
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var body: [String: Any]? { get }
    var queryParams: [String: Any]? { get }
    var headers: [String: String]? { get }
    associatedtype ReturnType: Codable
}

extension Request { // default values
    var method: HTTPMethod { return .get }
    var contentType: String { return ContentType.json.rawValue }
    var queryParams: [String: Any]? { return nil }
    var body: [String: Any]? { return nil }
    var headers: [String: String]? { return nil }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum ContentType: String {
    case json = "application/json"
    case xwwwformurlencoded = "application/x-www-form-urlencoded"
}

enum NetworkError: Error {
    case invalidResponse(statusCode: Int)
    case decodingError(String)
    case genericError(String)
    case invalidURL
}

