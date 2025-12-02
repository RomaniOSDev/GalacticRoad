//
//  Card.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

struct Card: Identifiable, Equatable {
    let id: UUID
    let imageName: ImageResource
    var isFlipped: Bool
    var isMatched: Bool
    
    init(id: UUID = UUID(), imageName: ImageResource, isFlipped: Bool = false, isMatched: Bool = false) {
        self.id = id
        self.imageName = imageName
        self.isFlipped = isFlipped
        self.isMatched = isMatched
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.imageName == rhs.imageName
    }
}
