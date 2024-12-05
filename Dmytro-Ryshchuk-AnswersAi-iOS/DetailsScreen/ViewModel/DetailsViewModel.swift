//
//  DetailsViewModel.swift
//  Dmytro-Ryshchuk-AnswersAi-iOS
//
//  Created by Dmytro Ryshchuk on 12/4/24.
//

import SwiftUI

class DetailsViewModel: ObservableObject {
    private var textViewModel = TextViewModel()
    private let item: CardItem
    
    init(item: CardItem) {
        self.item = item
    }
    
    func getItem() -> CardItem {
        item
    }
    
    func getTextViewModelWith(part: TextViewModel.DescriptionPart = .first) -> TextViewModel {
        textViewModel = TextViewModel(part: part)
        return textViewModel
    }
    
    func renderStyledText(from parts: [TextPart]) -> some View {
        var combinedText: Text = Text("")

        for part in parts {
            let styledPart = Text(part.text)
                .fontWeight(getFontWeight(for: part.weight))
                .foregroundColor(part.weight == "bold" ? .white : .gray)
                .font(part.style == "italic" ? .body.italic() : .body)
            
            combinedText = combinedText + styledPart
        }

        return combinedText
    }
    
    func getFontWeight(for weight: String) -> Font.Weight {
        switch weight {
        case "bold": return .bold
        case "semibold": return .semibold
        default: return .regular
        }
    }
}
