//
//  FetchedDataView.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import SwiftUI

struct FetchedDataView: View {
    @ObservedObject private(set) var viewModel: FetchedDataViewModel
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                dataView
            }
        }
    }
    
    private var dataView: some View {
        ForEach(viewModel.data, id: \.id) { data in
            DataCard(data: data) { action in
                switch action {
                case .delete:
                    viewModel.deleteAction(data)
                case .update:
                    viewModel.updateAction()
                }
            }
        }
    }
}
