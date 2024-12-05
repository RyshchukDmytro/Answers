//
//  CircularProgressButton.swift
//  Dmytro-Ryshchuk-AnswersAi-iOS
//
//  Created by Dmytro Ryshchuk on 12/5/24.
//

import SwiftUI

struct CircularProgressButton: View {
    @State private var progress: CGFloat = 0.0
    @State private var isCompleted = false
    @ObservedObject var sharedData: SharedData

    var body: some View {
        ZStack {
            Circle()
                .stroke(isCompleted ? Color.clear : Color.gray.opacity(0.3), lineWidth: 3)
                .frame(width: 30, height: 30)

            if !isCompleted {
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 30, height: 30)
                    .animation(.linear(duration: 3), value: progress)
            }

            if isCompleted {
                Image(systemName: "icloud.and.arrow.down")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .onAppear {
                        DispatchQueue.main.async {
                            self.sharedData.status = true
                        }
                    }
            } else {
                Button(action: startProgress) {
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color.blue)
                        .frame(width: 10, height: 10)
                }
            }
        }
        .onAppear {
            startProgress()
        }
    }

    private func startProgress() {
        withAnimation {
            progress = 1.0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                isCompleted = true
            }
        }
    }
}
