//
//  CardView.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

struct CardView: View {
    let card: Card
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            if card.isFlipped || card.isMatched {
                // Show card image
                Image(card.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
            } else {
                Image(.closeCard)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(width: width, height: height)
        .contentShape(Rectangle())
        .id(card.id)
    }
}

