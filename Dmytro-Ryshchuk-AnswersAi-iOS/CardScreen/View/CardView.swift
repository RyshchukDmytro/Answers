//
//  CardView.swift
//  Dmytro-Ryshchuk-AnswersAi-iOS
//
//  Created by Dmytro Ryshchuk on 12/4/24.
//

import SwiftUI

struct CardView: View {
    @StateObject private var viewModel = CardViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.cards) { item in
                        CardBody(item: item)
                    }
                }
                .padding()
            }
        }
    }
}

//#Preview {
//    CardView()
//}
