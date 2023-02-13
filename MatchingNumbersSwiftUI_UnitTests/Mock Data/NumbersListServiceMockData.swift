//
//  NumbersListServiceMock.swift
//  MatchingNumbersSwiftUI
//
//  Created by Maxim Lobovich on 24/01/2023.
//

import Foundation
import Combine

class NumbersListServiceMockData: NetworkServiceProtocol {
    func send<R: Request>(request: R) -> AnyPublisher<R.ReturnType, NetworkError> {
        return Just(NumberApiResponse(numbers: [Number(number: 2),Number(number: 3),Number(number: -2)]) as! R.ReturnType)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}
