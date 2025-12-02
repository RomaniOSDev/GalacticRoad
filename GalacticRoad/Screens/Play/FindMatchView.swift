//
//  FindMatchView.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

// MARK: - Main View
struct FindMatchView: View {
    @State private var selectedLevel: MatchLevel? = nil
    let levelData = MatchLevelData.shared
    
    var body: some View {
        Group {
            if let level = selectedLevel {
                MatchGameView(level: level, selectedLevel: $selectedLevel)
            } else {
                LevelSelectionView(levels: levelData.levels, selectedLevel: $selectedLevel)
            }
        }
    }
}

#Preview {
    FindMatchView()
}
