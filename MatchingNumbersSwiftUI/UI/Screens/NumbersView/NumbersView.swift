//
//  NumbersView.swift
//  MatchingNumbersSwiftUI
//
//  Created by Maxim Lobovich on 24/01/2023.
//

import SwiftUI

struct NumbersView: View {
    
    @ObservedObject private(set) var viewModel: NumbersViewModel
    private let columns = Array(repeating: GridItem(), count: 3)
    
    init(viewModel: NumbersViewModel = NumbersViewModel()) {
        self.viewModel = viewModel
        self.viewModel.getNumberData()
    }
    
    var body: some View {
        ZStack {
            switch viewModel.appState {
            case .loading:
                loadingView
                
            case .finished:
                numbersGridView
                    .transition(.opacity
                        .animation(.easeIn(duration: 0.3)))
                
            case .failure(let error):
                ErrorView(error: error)
            }
        }.navigationBarTitle("Numbers Screen")
    }
}

extension NumbersView {
    private var loadingView: some View {
        ProgressView().scaleEffect(2)
    }
    
    private var numbersGridView: some View {
        GeometryReader { geometry in
            ScrollView() {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.data, id: \.self) { item in
                        NumberCell(data: item)
                            .frame(width: (geometry.size.width+24)/4, height: geometry.size.height/6)
                            .padding(4)
                    }
                }.padding([.top,.trailing,.leading],12)
            }.padding([.bottom], 1)
        }
    }
}

#if DEBUG
struct NumbersView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersView()
    }
}
#endif
