//
//  FetchedDataCoordinator.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import UIKit
import Combine

final class FetchedDataCoordinator: BaseCoordinator<Void> {
    
    private var disposable: Set<AnyCancellable> = []
    private let navigationController: UINavigationController
    private var data: [DummyDataResponse]
    
    init(navigationController: UINavigationController, data: [DummyDataResponse]) {
        self.data = data
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        let viewModel = FetchedDataViewModel(data: data)
        let homeView = FetchedDataView(viewModel: viewModel)
        let controller = HostingController(rootView: homeView)
        navigationController.pushViewController(controller, animated: true)
        
        return Empty().eraseToAnyPublisher()
    }
}
