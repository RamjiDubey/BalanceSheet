//
//  PDFCoordinator.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import UIKit
import Combine

final class PDFCoordinator: BaseCoordinator<Void> {
    
    private var disposable: Set<AnyCancellable> = []
    private let navigationController: UINavigationController
    let imageData: ImageData
    init(navigationController: UINavigationController, imageData: ImageData) {
        self.imageData = imageData
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        let viewModel = PDFViewModel(imageData: imageData)
        let homeView = PDFView(viewModel: viewModel)
        let controller = HostingController(rootView: homeView)
        navigationController.pushViewController(controller, animated: true)
        viewModel.backEvent
            .sink {[weak self] _ in
                self?.navigationController.popViewController(animated: true)
            }
            .store(in: &disposable)
        
        return Empty().eraseToAnyPublisher()
    }
}
