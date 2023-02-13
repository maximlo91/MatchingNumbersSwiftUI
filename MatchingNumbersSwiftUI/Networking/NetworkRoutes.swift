//
//  NetworkRoutes.swift
//  MatchingNumbersSwiftUI
//
//  Created by Maxim Lobovich on 24/01/2023.
//

import Foundation

struct NetworkRoutes {
    
    struct GetNumbers: Request {
        let endpoint: String = "raw/cKT8eYt5"
        let method: HTTPMethod = .get
        var body: [String : Any]?
        var queryParams: [String : Any]?
        var headers: [String : String]?
        typealias ReturnType = NumberApiResponse
    }
    
}
