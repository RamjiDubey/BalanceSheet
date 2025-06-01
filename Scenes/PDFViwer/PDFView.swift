//
//  PDFView.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import SwiftUI

struct PDFView: View {
    @ObservedObject private(set) var viewModel: PDFViewModel
    var body: some View {
        ZStack(alignment: .topLeading) {
            GeometryReader { geometry in
                switch viewModel.imageData {
                case .image(let image):
                    ImageView(image: image)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                case .imageURL(let url):
                    ImageView(url: url)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                }
            }
        }
    }
}
