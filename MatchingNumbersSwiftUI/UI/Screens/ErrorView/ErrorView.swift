//
//  ErrorView.swift
//  MatchingNumbersSwiftUI
//
//  Created by Maxim Lobovich on 24/01/2023.
//

import SwiftUI

struct ErrorView: View {
    
    private var errorMessage: String
    
    init(error: Error) {
        errorMessage = error.description
    }
    
    var body: some View {
        Text(errorMessage)
            .font(.system(size: UIScreen.main.bounds.width * 0.04))
            .fontWeight(.regular)
            .padding(36)
    }
}

#if DEBUG
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: NetworkError.invalidURL)
    }
}
#endif
