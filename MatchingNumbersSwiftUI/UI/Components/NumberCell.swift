//
//  NumberCell.swift
//  MatchingNumbersSwiftUI
//
//  Created by Maxim Lobovich on 24/01/2023.
//

import SwiftUI

struct NumberCell: View {
    
    private var isMatching = false
    private var number: Int = 0
    
    init(data: NumberCellData) {
        self.isMatching = data.isMatching
        self.number = data.number
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                Text("\(number)")
                    .font(.system(size: geometry.size.width / 6))
                    .fontWeight(.medium)
                    .frame(width: geometry.size.width, height: isMatching ? geometry.size.height : geometry.size.height/2)
                    .background(isMatching ? Color.red : Color.orange)
                Spacer()
            }.background(Color.clear)
        }
    }
}

