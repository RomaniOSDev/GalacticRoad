//
//  ImagesCrads.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

enum ImagesCrads: CaseIterable {
    
   case saturne, astronaut, Star, Rocket, Rabbit, Cow, Sun
    
    var imageCard: ImageResource{
        switch self {
            
        case .saturne:
            return .saturn
        case .astronaut:
            return .astronaft
        case .Star:
            return .star
        case .Rocket:
            return  .rocket
        case .Rabbit:
            return .rabit
        case .Cow:
            return .cow
        case .Sun:
            return .sun
        }
    }
    
    var badUswer: String {
        switch self {
            
        case .saturne:
            return "A donut now"
        case .astronaut:
            return "Firefighter"
        case .Star:
            return "Light bulb"
        case .Rocket:
            return "Submarine"
        case .Rabbit:
            return "Squirrel"
        case .Cow:
            return "Tiger"
        case .Sun:
            return "a lamp"
        }
    }
}

