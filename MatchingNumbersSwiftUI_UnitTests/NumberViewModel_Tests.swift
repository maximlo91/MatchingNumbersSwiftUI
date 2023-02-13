//
//  NumberViewModelSpec.swift
//  MatchingNumbersSwiftUI
//
//  Created by Maxim Lobovich on 24/01/2023.
//

import XCTest

final class NumberViewModel_Tests: XCTestCase {
    var mockService: NumbersListServiceMockData!
    var viewModel: NumbersViewModel!
    
    override func setUp() {
        mockService = NumbersListServiceMockData()
        viewModel = .init(service: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        viewModel = nil
    }

    func test_NumberViewModel_getZeroSumPairsFrom_returnMatchingPairs() {
        let numbers = [5,4,-4,2]
        let expectedResult = [4: true, -4: true]
        let matchingNumbers = viewModel.getZeroSumPairsFrom(numbers)
        
        XCTAssertEqual(matchingNumbers, expectedResult)
    }
    
    func test_NumberViewModel_buildCellData_returnEqualData() {
        let numbers = [5,4,-4,2]
        
        let cellData = viewModel.buildCellDataFrom(numbers)
        
        let resultData = [
            NumberCellData(number: 5, isMatching: false),
            NumberCellData(number: 4, isMatching: true),
            NumberCellData(number: -4, isMatching: true),
            NumberCellData(number: 2, isMatching: false)
        ]
        XCTAssertEqual(resultData, cellData)
    }
    
    
    func test_NumberViewModel_getNumberData_isLoadingFalse() {
        XCTAssertEqual(viewModel.appState, AppState.loading)
        viewModel.getNumberData()
        _ = XCTWaiter.wait(for: [XCTestExpectation(description: "Async Call")], timeout: 2)
        
        XCTAssertEqual(viewModel.appState, AppState.finished)
    }
}
