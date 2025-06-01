//
//  SocialLoginView.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import SwiftUI

enum SocialLoginType {
    case google
}

struct SocialLoginView: View {
    
    let onSignInButtonTapped: ((SocialLoginType) -> Void)?
    var body: some View {
        HStack {
            Button {
                self.onSignInButtonTapped?(.google)
            } label: {
                Image("googleIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
            }
            .padding(.all, 5)
        }
    }
}
