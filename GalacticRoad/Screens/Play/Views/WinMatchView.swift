//
//  WinMatchView.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

struct WinMatchView: View {
    let level: MatchLevel
    let moves: Int
    let time: TimeInterval
    let timeString: String
    let onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            Image(.mainFon)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                Text("Level \(level.id) Complete!")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                                
                Image(.winLabel)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Button {
                    onDismiss()
                } label: {
                    Image(.continueBTN)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .padding(.top, 60)
        }
    }
}

#Preview {
    WinMatchView(level: MatchLevel(id: 1, rows: 1, columns: 11, pairs: 2), moves: 1, time: 10, timeString: "1") {
        ()
    }
}
