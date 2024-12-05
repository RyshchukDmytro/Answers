//
//  DetailsView.swift
//  Dmytro-Ryshchuk-AnswersAi-iOS
//
//  Created by Dmytro Ryshchuk on 12/4/24.
//

import SwiftUI

struct DetailsView: View {
    let animationNamespace: Namespace.ID
    let onClose: () -> Void
    @StateObject private var viewModel: DetailsViewModel
    @State private var isShowingShareSheet = false
    @State private var showFakeAppStore = false
    @State private var downloadBeginStore = false
    @ObservedObject var sharedData: SharedData
    
    init(item: CardItem, animationNamespace: Namespace.ID,
         onClose: @escaping () -> Void, sharedData: SharedData) {
        self.animationNamespace = animationNamespace
        self.onClose = onClose
        _viewModel = StateObject(wrappedValue: DetailsViewModel(item: item))
        self.sharedData = sharedData
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.opacity(0.99).ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    CardBody(sharedData: sharedData, item: viewModel.getItem(), type: .detailCard)
                    
                    firstTextPart
                    stackImages
                    secondTextPart
                    placeholder
                    shareButton
                        .padding([.vertical], 40)
                }
            }
                        
            Button(action: onClose) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
    
    private var firstTextPart: some View {
        VStack(alignment: .leading) {
            ForEach(viewModel.getTextViewModelWith().textSections, id: \.parts) { section in
                viewModel.renderStyledText(from: section.parts)
            }
            .padding([.horizontal], 16)
            .padding([.vertical], 8)
        }
    }
    
    private var secondTextPart: some View {
        VStack {
            ForEach(viewModel.getTextViewModelWith(part: .second).textSections, id: \.parts) { section in
                viewModel.renderStyledText(from: section.parts)
            }
            .padding([.horizontal], 16)
            .padding([.vertical], 8)
        }
    }
    
    private var stackImages: some View {
        VStack {
            HStack {
                Image("detail-screen1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width / 2 - 20)
                    .clipped()
                
                Image("detail-screen2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width / 2 - 20)
                    .clipped()
            }
            .padding()
        }
    }
        
    private var placeholder: some View {
        VStack {
            VStack(spacing: 16) {
                Image(viewModel.getItem().banner.imageName)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .cornerRadius(20)

                VStack(spacing: 4) {
                    Text(viewModel.getItem().banner.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)

                    Text(viewModel.getItem().banner.subtitle)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }

                VStack(spacing: 2) {
                    Button(action: {
                        showFakeAppStore = true
                    }) {
                        if downloadBeginStore {
                            CircularProgressButton(sharedData: sharedData)
                        } else if sharedData.status {
                            Image(systemName: "icloud.and.arrow.down")
                                .renderingMode(.template)
                                .foregroundColor(.white)
                        } else {
                            Text("Get")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .frame(width: 70, height: 30)
                                .background(.blue.opacity(0.95))
                                .foregroundStyle(.white)
                                .cornerRadius(15)
                        }
                    }
                    .sheet(isPresented: $showFakeAppStore) {
                        ZStack {
                            Color.black.opacity(0.8).ignoresSafeArea()
                            
                            VStack(spacing: 16) {
                                HStack {
                                    Text("App Store")
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        showFakeAppStore = false
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.system(size: 24))
                                            .foregroundColor(.gray)
                                    }
                                }
                                
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack(spacing: 12) {
                                        Image(viewModel.getItem().banner.imageName)
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(12)
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("Runna: Running Training Plans")
                                                .font(.headline)
                                                .lineLimit(1)
                                            
                                            Text("RunBuddy")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                            
                                            Text("Offers In-App Purchases")
                                                .font(.footnote)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    
                                    Text("Account: email@gmail.com")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.black.opacity(0.65))
                                .cornerRadius(16)
                                .shadow(radius: 5)
                                .padding([.horizontal], 16)
                                
                                
                                Button(action: {
                                    downloadBeginStore = true
                                    showFakeAppStore = false
                                }) {
                                    Label {
                                        Text("Download")
                                    } icon: {
                                        Image(systemName: "arrow.down.circle")
                                    }
                                }
                                .padding([.top], 16)
                                
                                Spacer()
                            }
                            .padding(16)
                            
                        }
                        .presentationDetents([.height(280)])
                        
                            
                    }
                    
                    Text(downloadBeginStore ? "" : "In-App Purchases")
                        .font(.system(size: 8))
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width)
            .background(Color.gray.opacity(0.3).edgesIgnoringSafeArea(.all))
            .foregroundColor(.white)
        }
    }
    
    private var shareButton: some View {
        HStack {
            Spacer()
            
            Button(action: {
                isShowingShareSheet = true
            }) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(.white)
                    
                    Text("Share Story")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                }
                .padding()
                .frame(width: 200)
                .background(Color.gray.opacity(0.4))
                .cornerRadius(12)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .sheet(isPresented: $isShowingShareSheet) {
            ShareSheet(items: ["Check out this cool app!", URL(string: "https://answersai.com/")!])
        }
    }
}
