//
//  HomeScreen.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject private(set) var viewModel: HomeViewModel
    @State private var showMediaOption: Bool = false
    @State private var showMediaPicker: Bool = false
    @State private var selectedImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var body: some View {
        VStack {
            Text("HOME SCREEN")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(alignment: .center)
            VStack(spacing: 30) {
                openCameraButton
                selectedImageView
                pdfViwerButton
                fetchDataButton
            }
        }
        .preferredColorScheme(colorScheme)
    }
    
    private var openCameraButton: some View {
        Button {
            showMediaOption.toggle()
        } label: {
            VStack(spacing: 5) {
                Image("openCamera")
                    .resizable()
                    .foregroundColor(Color.gray)
                    .frame(width: 100, height: 100)
                    .background(Color.red)
                    .cornerRadius(10)
                Text("Open Camera To Capture Images")
                    .font(.callout)
            }
        }
        .buttonStyle(.borderless)
        .actionSheet(isPresented: $showMediaOption) {
            ActionSheet(title: Text(verbatim: ""), message: Text("Please choose your preferred mode to select image"),
                        buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                self.sourceType = .camera
                self.showMediaPicker = true
            }), ActionSheet.Button.default(Text("Photo Library"), action: {
                self.sourceType = .photoLibrary
                self.showMediaPicker = true
            }), ActionSheet.Button.cancel()])
        }
        .fullScreenCover(isPresented: $showMediaPicker) {
            ImagePickerView(sourceType: self.sourceType, onSelectedImageAction: {image in
                selectedImage = image})
            .background(Color.white)
        }
    }
    
    private var pdfViwerButton: some View {
        Button {
            if let url = URL(string: "https://fssservices.bookxpert.co/GeneratedPDF/Companies/nadc/2024-2025/BalanceSheet.pdf"){
                viewModel.openPDFViwer(imageData: .imageURL(url))
            }
        } label: {
            VStack(spacing: 5) {
                Image("pdfView")
                    .resizable()
                    .foregroundColor(Color.gray)
                    .frame(width: 100, height: 100)
                    .background(Color.red)
                    .cornerRadius(10)
                Text("View PDF")
                    .font(.callout)
            }
        }
        .buttonStyle(.borderless)
    }
    
    private var fetchDataButton: some View {
        Button {
            viewModel.fetchData()
        } label: {
            VStack(spacing: 5) {
                Image("fetchData")
                    .resizable()
                    .foregroundColor(Color.gray)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                Text("Make an API Call")
                    .font(.callout)
            }
        }
        .buttonStyle(.borderless)
    }
    
    @ViewBuilder
    private var selectedImageView: some View {
        if let image = selectedImage {
            Button {
                viewModel.openPDFViwer(imageData: .image(image))
            } label: {
                VStack(spacing: 5) {
                    Image(uiImage: image)
                        .resizable()
                        .foregroundColor(Color.gray)
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                    Text("View Selected Image")
                        .font(.callout)
                }
            }
            .buttonStyle(.borderless)
        }
    }
}

