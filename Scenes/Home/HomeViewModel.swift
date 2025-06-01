//
//  HomeViewModel.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import Combine
import Foundation
import SwiftUI

enum ImageData {
    case imageURL(URL)
    case image(UIImage)
}

final class HomeViewModel: ObservableObject {
    let openPDFViwerEvent = PassthroughSubject<ImageData, Never>()
    let fetchingEvent = PassthroughSubject<[DummyDataResponse], Never>()
    private var cancellables = Set<AnyCancellable>()
    @Published var data: [DummyDataResponse]?
    @Published var errorMessage: String?
    
    func openPDFViwer(imageData: ImageData) {
        openPDFViwerEvent.send(imageData)
    }
    
    func fetchData() {
        APIService.shared.fetchUsers()
            .sink { completion in
                if case let .failure(error) = completion {
                    print("\(error.localizedDescription)")
                }
            } receiveValue: {[weak self] response in
                self?.data = response
                guard let data = self?.data else { return }
                self?.fetchingEvent.send(data)
            }
            .store(in: &cancellables)
    }
}
