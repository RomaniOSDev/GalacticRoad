//
//  Achievement.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

enum AchievementType: String, CaseIterable {
    case firstMatchLevel = "first_match_level"
    case complete5Levels = "complete_5_levels"
    case complete10Levels = "complete_10_levels"
    case completeImageQuiz = "complete_image_quiz"
    case completeGalacticQuiz = "complete_galactic_quiz"
    case play10Games = "play_10_games"
    case play25Games = "play_25_games"
    case play50Games = "play_50_games"
    case perfectMatch = "perfect_match"
    case speedRunner = "speed_runner"
    case master = "master"
    case explorer = "explorer"
    case collector = "collector"
    case champion = "champion"
}

struct Achievement: Identifiable {
    let id: AchievementType
    let icon: ImageResource
    let title: String
    let description: String
    var completed: Bool
    
    static let allAchievements: [Achievement] = [
        Achievement(
            id: .firstMatchLevel,
            icon: .card1,
            title: "First Steps",
            description: "Complete your first match level",
            completed: false
        ),
        Achievement(
            id: .complete5Levels,
            icon: .card2,
            title: "Rising Star",
            description: "Complete 5 match levels",
            completed: false
        ),
        Achievement(
            id: .complete10Levels,
            icon: .card3,
            title: "Level Master",
            description: "Complete all 10 match levels",
            completed: false
        ),
        Achievement(
            id: .completeImageQuiz,
            icon: .card4,
            title: "Image Expert",
            description: "Complete the image quiz",
            completed: false
        ),
        Achievement(
            id: .completeGalacticQuiz,
            icon: .card5,
            title: "Galactic Scholar",
            description: "Complete the galactic quiz",
            completed: false
        ),
        Achievement(
            id: .play10Games,
            icon: .card6,
            title: "Dedicated Player",
            description: "Play 10 games",
            completed: false
        ),
        Achievement(
            id: .play25Games,
            icon: .card7,
            title: "Veteran",
            description: "Play 25 games",
            completed: false
        ),
        Achievement(
            id: .play50Games,
            icon: .card8,
            title: "Legend",
            description: "Play 50 games",
            completed: false
        ),
        Achievement(
            id: .perfectMatch,
            icon: .card9,
            title: "Perfect Match",
            description: "Complete a level without mistakes",
            completed: false
        ),
        Achievement(
            id: .speedRunner,
            icon: .card10,
            title: "Speed Runner",
            description: "Complete a level in under 30 seconds",
            completed: false
        ),
        Achievement(
            id: .master,
            icon: .card11,
            title: "Master",
            description: "Complete all quizzes",
            completed: false
        ),
        Achievement(
            id: .explorer,
            icon: .card12,
            title: "Explorer",
            description: "Try all game modes",
            completed: false
        ),
        Achievement(
            id: .collector,
            icon: .card13,
            title: "Collector",
            description: "Unlock 5 achievements",
            completed: false
        ),
        Achievement(
            id: .champion,
            icon: .card14,
            title: "Champion",
            description: "Unlock all achievements",
            completed: false
        ),
        Achievement(
            id: .champion,
            icon: .card15,
            title: "Special",
            description: "Special achievement",
            completed: false
        )
    ]
}

