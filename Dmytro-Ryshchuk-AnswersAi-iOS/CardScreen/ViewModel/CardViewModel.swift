//
//  CardViewModel.swift
//  Dmytro-Ryshchuk-AnswersAi-iOS
//
//  Created by Dmytro Ryshchuk on 12/4/24.
//

import SwiftUI

class CardViewModel: ObservableObject {
    @Published var cards: [CardItem] = []
    
    init() {
        loadData()
    }
    
    private func loadData() {
        if let url = Bundle.main.url(forResource: "CardsData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedCards = try JSONDecoder().decode([CardItem].self, from: data)
                self.cards = decodedCards
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("CardsData.json not found")
        }
    }
}
