//
//  MatchLevelData.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

class MatchLevelData {
    static let shared = MatchLevelData()
    
    let levels: [MatchLevel] = [
        MatchLevel(id: 1, rows: 2, columns: 2, pairs: 2),   // 4 cards, 2 pairs
        MatchLevel(id: 2, rows: 2, columns: 3, pairs: 3),   // 6 cards, 3 pairs
        MatchLevel(id: 3, rows: 3, columns: 2, pairs: 3),   // 6 cards, 3 pairs
        MatchLevel(id: 4, rows: 3, columns: 4, pairs: 6),   // 12 cards, 6 pairs
        MatchLevel(id: 5, rows: 4, columns: 3, pairs: 6),   // 12 cards, 6 pairs
        MatchLevel(id: 6, rows: 4, columns: 4, pairs: 8),   // 16 cards, 8 pairs
        MatchLevel(id: 7, rows: 4, columns: 5, pairs: 10),   // 20 cards, 10 pairs
        MatchLevel(id: 8, rows: 5, columns: 4, pairs: 10),   // 20 cards, 10 pairs
        MatchLevel(id: 9, rows: 5, columns: 6, pairs: 15),   // 30 cards, 15 pairs
        MatchLevel(id: 10, rows: 6, columns: 6, pairs: 18)   // 36 cards, 18 pairs (will use duplicates)
    ]
    
    let cardImages: [ImageResource] = [
        .card1, .card2, .card3, .card4, .card5,
        .card6, .card7, .card8, .card9, .card10,
        .card11, .card12, .card13, .card14, .card15
    ]
}
