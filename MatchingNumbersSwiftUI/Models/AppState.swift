//
//  AppState.swift
//  MatchingNumbersSwiftUI
//
//  Created by Maxim Lobovich on 24/01/2023.
//

import Foundation

enum AppState: Equatable {
    case loading
    case failure(Error)
    case finished
    
    var value: String? {
        return String(describing: self).components(separatedBy: "(").first
    }
    
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        lhs.value == rhs.value
    }
}
