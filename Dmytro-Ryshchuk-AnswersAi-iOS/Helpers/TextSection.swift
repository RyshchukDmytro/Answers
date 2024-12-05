//
//  TextSection.swift
//  Dmytro-Ryshchuk-AnswersAi-iOS
//
//  Created by Dmytro Ryshchuk on 12/4/24.
//

struct TextPart: Decodable, Hashable {
    let text: String
    let weight: String
    let style: String
}

struct TextSection: Decodable {
    let parts: [TextPart]
}
