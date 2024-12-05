//
//  CardView.swift
//  Dmytro-Ryshchuk-AnswersAi-iOS
//
//  Created by Dmytro Ryshchuk on 12/4/24.
//

import SwiftUI

struct CardView: View {
    @StateObject var sharedData = SharedData()
    @StateObject private var viewModel = CardViewModel()
    @Namespace private var animationNamespace
    @State private var selectedCard: CardItem? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.cards) { item in
                            CardBody(sharedData: sharedData, item: item, type: .mainCard)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedCard = item
                                    }
                                }
                        }
                    }
                    .padding()
                }
            }
            .overlay(
                Group {
                    if let card = selectedCard {
                        DetailsView(
                            item: card,
                            animationNamespace: animationNamespace,
                            onClose: {
                                withAnimation(.spring()) {
                                    selectedCard = nil
                                }
                            },
                            sharedData: sharedData
                        )
                    }
                }
            )
        }
    }
}

//#Preview {
//    CardView()
//}
