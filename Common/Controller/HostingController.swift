//
//  HostingController.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import SwiftUI

class HostingController<RootView: View>: UIHostingController<RootView> {
    
   override init(rootView: RootView) {
        super.init(rootView: rootView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
