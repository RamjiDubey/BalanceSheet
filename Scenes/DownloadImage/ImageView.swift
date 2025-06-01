//
//  ImageView.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import SDWebImageSwiftUI
import SwiftUI

struct ImageView: View {
    
    @StateObject private var imageManager: ImageDownloadManager
    private let imageURL: URL?
    private var image: UIImage?
    private var onSuccess: (() -> Void)? = nil
    
    init(url: URL? = nil, image: UIImage? = nil,) {
        self.imageURL = url
        self.image = image
        _imageManager = StateObject(wrappedValue: ImageDownloadManager(imageURL: url))
    }
    
    var body: some View {
        imagViewContainerView
            .onAppear() {
                imageManager.load(onCompletion: onSuccess)
            }
    }
    
    @ViewBuilder
    private var imagViewContainerView: some View {
        if let image {
            imageView(image: image, ratio: .fit)
        }else if let image = imageManager.image {
            imageView(image: image, ratio: .fit)
        }
    }
    
    private func imageView(image: UIImage, ratio: ContentMode) -> some View {
        Image(uiImage: image)
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: ratio)
    }
}
