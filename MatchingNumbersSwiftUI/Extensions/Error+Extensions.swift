//
//  Error+Extensions.swift
//  MatchingNumbersSwiftUI
//
//  Created by Maxim Lobovich on 24/01/2023.
//

import Foundation

extension Error {
    var description: String {
        let desc = """
        \((self as NSError).domain.split(separator: ".").last ?? "ErrorCode")
        \((self as NSError).description.split(separator: ".").last ?? "")
        """
        return desc
    }
}
