//
//  BottomBanner.swift
//  Dmytro-Ryshchuk-AnswersAi-iOS
//
//  Created by Dmytro Ryshchuk on 12/4/24.
//

import SwiftUI

struct BottomBanner: View {
    let banner: Banner
    
    var body: some View {
        HStack {
            Image(banner.imageName)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(8)
                .padding(.trailing, 8)

            VStack(alignment: .leading) {
                Text(banner.title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .lineLimit(1)

                Text(banner.subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                    .lineLimit(1)
            }

            Spacer()

            VStack {
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text("Get")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(width: 70, height: 30)
                        .background(.gray.opacity(0.95))
                        .foregroundStyle(.white)
                        .cornerRadius(15)
                }
                
                Text("In-App Purchases")
                    .font(.system(size: 8))
                    .foregroundColor(.white.opacity(0.7))
            }
            .padding([.bottom], 6)
        }
        .frame(height: 60)
        .padding([.horizontal], 16)
    }
}
