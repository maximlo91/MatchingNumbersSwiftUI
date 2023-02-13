//
//  IntroView.swift
//  MatchingNumbersSwiftUI
//
//  Created by Maxim Lobovich on 24/01/2023.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        GeometryReader { geomtry in
            NavigationView {
                VStack {
                    Text("Intro Screen")
                        .font(.system(size: geomtry.size.width*0.05, weight: .bold))
                        .padding([.top],8)
                    Spacer()
                    Text("The next screen will create an API call which will retrieve a list of numbers, the numbers that can be paired and result in a zero sum will be marked red.")
                        .font(.system(size: geomtry.size.width*0.05))
                        .padding([.bottom, .leading,.trailing],36)
                    
                    NavigationLink(destination: LazyView(NumbersView())) {
                        Text("Continue").font(.system(size: geomtry.size.width*0.04))
                    }
                    .buttonStyle(
                        BlueButton(heightPadding: geomtry.size.width*0.02, widthPadding: geomtry.size.width*0.03))
                    Spacer()
                }
            }.navigationViewStyle(StackNavigationViewStyle())
            
        }
    }
}

#if DEBUG
struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
#endif
