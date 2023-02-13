//
//  NumbersModel.swift
//  MatchingNumbersSwiftUI
//
//  Created by Maxim Lobovich on 24/01/2023.
//

import Foundation

struct NumberApiResponse: Codable {
    var numbers: [Number]
}

struct Number: Codable {
    var number: Int
}

struct NumberCellData: Hashable {
    var number: Int = 0
    var isMatching: Bool = false
}

