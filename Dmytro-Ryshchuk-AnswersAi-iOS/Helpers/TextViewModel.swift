//
//  TextViewModel.swift
//  Dmytro-Ryshchuk-AnswersAi-iOS
//
//  Created by Dmytro Ryshchuk on 12/4/24.
//

import Foundation

class TextViewModel: ObservableObject {
    enum DescriptionPart: String {
        case first = "DetailDescriptions"
        case second = "DetailDescriptions2"
    }
    
    @Published var textSections: [TextSection] = []
    private var part: DescriptionPart

    init(part: DescriptionPart = .first) {
        self.part = part
        loadTextData()
    }

    private func loadTextData() {
        if let url = Bundle.main.url(forResource: part.rawValue, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode([TextSection].self, from: data)
                self.textSections = decodedData
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }
    }
}
