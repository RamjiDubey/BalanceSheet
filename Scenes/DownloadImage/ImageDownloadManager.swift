//
//  ImageDownloadManager.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import SDWebImageSwiftUI
import SwiftUI

final class ImageDownloadManager : ObservableObject {
    
    private let imageManager = ImageManager()
    @Published var image: PlatformImage? = nil
    private let imageURL: URL?
    private var onCompletion: (() -> Void)?
    
    init(imageURL: URL?) {
        self.imageURL = imageURL
        self.setupLoadObserver()
        self.load(onCompletion: onCompletion)
    }
    
    private func setupLoadObserver() {
        imageManager.setOnSuccess {[weak self] image, _, _ in
            guard let self else { return }
            DispatchQueue.main.async {
                withAnimation(.easeIn(duration: 0.1)) {
                    self.image = image
                    self.onCompletion?()
                }
            }
        }
    }
    
    func load(onCompletion: (() -> Void)?) {
        imageManager.load(url: imageURL)
        self.onCompletion = onCompletion
    }
}
