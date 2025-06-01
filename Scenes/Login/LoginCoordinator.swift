//
//  LoginCoordinator.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import Combine
import GoogleSignIn

final class LoginCoordinator: BaseCoordinator<Void> {
    
    struct Injections {
        var navigationController: UINavigationController
        var loginRequired: Bool
        var animated: Bool
    }
    
    private let onboardingEvent = PassthroughSubject<Void, Never>()
    private let injections: Injections
    
    init(injections: Injections) {
        self.injections = injections
        super.init()
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        
        let viewModel = LoginScreenViewModel()
        let view = LoginScreenView(viewModel: viewModel)
        let controller = HostingController(rootView: view)
        injections.navigationController.setViewControllers([controller], animated: true)
        
        //Google login event
        viewModel.googleTapEvent
            .sink { [weak self, weak viewModel] _ in
                self?.coordinateToGoogleSigniInScreen() {[weak viewModel] result in
                    viewModel?.googleLoginSuccess.send(.success(()))
                }
            }
            .store(in: &subscribers)
        
        viewModel.successEvent
            .sink {[weak self] sourceInfo in
                guard let self else { return }
                self.coordinateToHome()
            }
            .store(in: &subscribers)
        
        return onboardingEvent.eraseToAnyPublisher()
    }
}

extension LoginCoordinator {
    //MARK: - Google login logic
    private func coordinateToGoogleSigniInScreen(completion: @escaping (Result<Void?, Error>) -> Void) {
        ///hardCoded clienId
        let clientID: String = "22747828882-09h2nifnkiq1u3ohq4i1879jro5hltrh.apps.googleusercontent.com"
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: injections.navigationController) {result, error in
            if let error {
                completion(.failure(NSError(domain: "",
                                            code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                return
            }
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                completion(.success(nil))
                return
            }
            // Get user's full name and email
            let fullName = user.profile?.name
            let email = user.profile?.email
            
            var googleInfo = KeychainUserDefault.googleLoginInfo ?? .init()
            googleInfo.email = email
            googleInfo.fullName = fullName
            KeychainUserDefault.googleLoginInfo = googleInfo
            
            completion(.success(nil))
        }
    }
    
    private func coordinateToHome() {
        let homeCoordinator = HomeCoordinator(navigationController: injections.navigationController)
        coordinate(to: homeCoordinator)
    }
}
