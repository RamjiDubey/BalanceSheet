//
//  HomeCoordinator.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import UIKit
import Combine

final class HomeCoordinator: BaseCoordinator<Void> {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        let viewModel = HomeViewModel()
        let homeView = HomeScreen(viewModel: viewModel)
        let controller = HostingController(rootView: homeView)
        navigationController.pushViewController(controller, animated: true)
        viewModel.openPDFViwerEvent
            .sink { [weak self] data in
                self?.coordinateToPDFViwer(data)
            }
            .store(in: &subscribers)
        
        viewModel.fetchingEvent
            .sink { [weak self] data in
                self?.coordinateToFetchedDataView(data)
            }
            .store(in: &subscribers)
        
        return Empty().eraseToAnyPublisher()
    }
    
    private func coordinateToPDFViwer(_ imageData: ImageData) {
        let coordinator = PDFCoordinator(navigationController: navigationController, imageData: imageData)
        coordinate(to: coordinator)
    }
    
    private func coordinateToFetchedDataView(_ data: [DummyDataResponse]) {
        let coordinator = FetchedDataCoordinator(navigationController: navigationController, data: data)
        coordinate(to: coordinator)
    }
}
