//
//  ResultRow.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

struct ResultRow: View {
    
    var image: ImageResource
    var score: Int
    var count: Int
    
    var body: some View {
        HStack(spacing: 20) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 180)
            ZStack {
                Image(.backToResult)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("\(score)/\(count)")
                    .foregroundStyle(.white)
                    .font(.system(size: 38, weight: .bold, design: .monospaced))
            }
        }
    }
}

#Preview {
    ResultRow(image: .galacticQuiz, score: 5, count: 10)
}
