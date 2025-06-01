//
//  DataCard.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import SwiftUI

enum ActionOnData {
    case update
    case delete
}

struct DataCard: View {
    @State var data: DummyDataResponse
    let onAction: (ActionOnData) -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            VStack(alignment: .leading, spacing: 15) {
                Text(data.name)
                    .foregroundStyle(.gray)
                    .font(.callout)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                HStack {
                    Text(data.id)
                    Text(data.name)
                }
                .font(.caption2)
            }
            Spacer()
            updateButton
            deleteButton
        }
        .padding()
    }
    
    private var updateButton: some View {
        Button {
            onAction(.update)
        } label: {
            Text("Update")
                .foregroundColor(.black)
                .background(.green)
        }
    }
    
    private var deleteButton: some View {
        Button {
            onAction(.delete)
        } label: {
            Text("Delete")
                .foregroundColor(.white)
                .background(.red)
        }
    }
}
