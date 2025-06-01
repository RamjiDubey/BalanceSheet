//
//  LoginScreenView.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import SwiftUI

struct LoginScreenView: View {
    @ObservedObject private(set) var viewModel: LoginScreenViewModel
    
    var body: some View {
        VStack {
            socialLoginView
            Text("Tap on Google button to login")
        }
    }
    
    private var socialLoginView: some View {
        SocialLoginView(onSignInButtonTapped: { socailLoginType in
            switch socailLoginType {
            case .google: self.viewModel.googleSignInButtonTapped()
            }
        })
    }
}
