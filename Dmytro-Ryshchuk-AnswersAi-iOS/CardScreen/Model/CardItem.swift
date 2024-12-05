//
//  CardItem.swift
//  Dmytro-Ryshchuk-AnswersAi-iOS
//
//  Created by Dmytro Ryshchuk on 12/4/24.
//

import Foundation

struct CardItem: Identifiable, Codable {
    let id: Int
    let imageName: String
    let placeholder: String
    let title: String
    let subtitle: String
    let banner: Banner
}

struct Banner: Codable {
    let imageName: String
    let title: String
    let subtitle: String
}
