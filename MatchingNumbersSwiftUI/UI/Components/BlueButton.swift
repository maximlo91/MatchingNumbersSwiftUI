//
//  BlueButton.swift
//  MatchingNumbersSwiftUI
//
//  Created by Maxim Lobovich on 24/01/2023.
//

import SwiftUI

struct BlueButton: ButtonStyle {
    
    private var heightPadding = 10.0
    private var widthPadding = 20.0
    
    init(heightPadding: CGFloat = 10, widthPadding: CGFloat = 20) {
        self.heightPadding = heightPadding
        self.widthPadding = widthPadding
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.top,.bottom],heightPadding)
            .padding([.leading,.trailing],widthPadding)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

    }
}
