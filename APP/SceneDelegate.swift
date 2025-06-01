//
//  SceneDelegate.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: LoginCoordinator!
    var subscriber: AnyCancellable?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.accessibilityIdentifier = "APP_WINDOW"
        window?.makeKeyAndVisible()
        let rootNavigationController = UINavigationController()
        self.coordinator = LoginCoordinator(injections: .init(navigationController: rootNavigationController,
                                                              loginRequired: true,
                                                              animated: true))
        window?.rootViewController = rootNavigationController
        subscriber = coordinator?.start().sink(receiveValue: {})
    }
    
    deinit { }
}
