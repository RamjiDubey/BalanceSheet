//
//  PDFViewModel.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import Combine
import Foundation

final class PDFViewModel: ObservableObject {
    let backEvent = PassthroughSubject<Void, Never>()
    let imageData: ImageData
    
    init(imageData: ImageData) {
        self.imageData = imageData
    }
    
    func backButtonTapped() {
        backEvent.send()
    }
}
