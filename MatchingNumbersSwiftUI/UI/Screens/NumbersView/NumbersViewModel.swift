//
//  NumbersViewModel.swift
//  MatchingNumbersSwiftUI
//
//  Created by Maxim Lobovich on 24/01/2023.
//

import Foundation
import Combine

final class NumbersViewModel: ObservableObject {
    
    @Published private(set) var appState: AppState = .loading
    private(set) var data = [NumberCellData]()
    private var observers = Set<AnyCancellable>()
    private var service: NetworkServiceProtocol

    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
    }
    
    func getNumberData() {
        service.send(request: NetworkRoutes.GetNumbers())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.appState = .failure(error)
                case .finished:
                    self?.appState = .finished
                    break
                }
            }, receiveValue: { [weak self] numberDict in
                let numbers = numberDict.numbers.map { $0.number }
                self?.data = self?.buildCellDataFrom(numbers) ?? []
            })
            .store(in: &observers)
    }

    func getZeroSumPairsFrom(_ numbers: [Int]) -> [Int:Bool] {
        var complements = [Int: Int]()
        var matchingNumbersDict = [Int: Bool]()
        
        for number in numbers {
            if let _ = complements[-number] {
                matchingNumbersDict[number] = true
                matchingNumbersDict[-number] = true
            }
            complements[number] = -number
        }
        
        return matchingNumbersDict
    }

    func buildCellDataFrom(_ numbers: [Int])-> [NumberCellData] {
        var data = [NumberCellData]()
        let matchingNumbersDict = getZeroSumPairsFrom(numbers)
        
        for number in numbers {
            let isMatching = matchingNumbersDict[number] ?? false
            let item = NumberCellData(number: number, isMatching: isMatching)
            data.append(item)
        }
        
        return data
    }
}
