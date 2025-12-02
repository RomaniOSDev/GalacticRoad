//
//  MatchLevel.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import Foundation

struct MatchLevel {
    let id: Int
    let rows: Int
    let columns: Int
    let pairs: Int
    
    var totalCards: Int {
        rows * columns
    }
}
