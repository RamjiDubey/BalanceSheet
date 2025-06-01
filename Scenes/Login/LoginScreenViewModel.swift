//
//  LoginScreenViewModel.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import Foundation
import Combine

final class LoginScreenViewModel: ObservableObject {
    let successEvent = PassthroughSubject<Void, Never>()
    let googleTapEvent = PassthroughSubject<Void, Never>()
    let googleLoginSuccess = PassthroughSubject<Result<Void, Error>, Never>()
    private var disposable: Set<AnyCancellable> = []

    init() {
        setupGoogleSigninObserver()
    }
    
    private func setupGoogleSigninObserver() {
        googleLoginSuccess
            .sink {[weak self] result in
                guard let self else { return }
                switch result {
                case .success:
                    self.socialLogin()
                case .failure(let error):
                    print("Login Failed \(error)")
                }
            }
            .store(in: &disposable)
    }
    
    func googleSignInButtonTapped() {
        googleTapEvent.send(())
    }
    
    private func socialLogin() {
        successEvent.send()
    }
}

