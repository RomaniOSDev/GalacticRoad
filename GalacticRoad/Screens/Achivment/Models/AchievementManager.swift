//
//  AchievementManager.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import Foundation
import Combine

class AchievementManager: ObservableObject {
    static let shared = AchievementManager()
    
    @Published var achievements: [Achievement] = Achievement.allAchievements
    
    private let completedAchievementsKey = "CompletedAchievements"
    private let matchLevelsCompletedKey = "MatchLevelsCompleted"
    private let totalGamesPlayedKey = "TotalGamesPlayed"
    private let imageQuizCompletedKey = "ImageQuizCompleted"
    private let galacticQuizCompletedKey = "GalacticQuizCompleted"
    
    private init() {
        loadAchievements()
        updateAchievements()
    }
    
    // MARK: - Loading & Saving
    
    private func loadAchievements() {
        let completedIds = getCompletedAchievementIds()
        
        achievements = Achievement.allAchievements.map { achievement in
            var updated = achievement
            updated.completed = completedIds.contains(achievement.id)
            return updated
        }
    }
    
    private func getCompletedAchievementIds() -> Set<AchievementType> {
        if let data = UserDefaults.standard.array(forKey: completedAchievementsKey) as? [String] {
            return Set(data.compactMap { AchievementType(rawValue: $0) })
        }
        return []
    }
    
    private func saveCompletedAchievement(_ type: AchievementType) {
        var completed = getCompletedAchievementIds()
        completed.insert(type)
        UserDefaults.standard.set(Array(completed.map { $0.rawValue }), forKey: completedAchievementsKey)
        loadAchievements()
    }
    
    // MARK: - Progress Tracking
    
    func getMatchLevelsCompleted() -> Int {
        return UserDefaults.standard.integer(forKey: matchLevelsCompletedKey)
    }
    
    func incrementMatchLevelsCompleted() {
        let current = getMatchLevelsCompleted()
        UserDefaults.standard.set(current + 1, forKey: matchLevelsCompletedKey)
        updateAchievements()
    }
    
    func getTotalGamesPlayed() -> Int {
        return UserDefaults.standard.integer(forKey: totalGamesPlayedKey)
    }
    
    func incrementTotalGamesPlayed() {
        let current = getTotalGamesPlayed()
        UserDefaults.standard.set(current + 1, forKey: totalGamesPlayedKey)
        updateAchievements()
    }
    
    func setImageQuizCompleted(_ completed: Bool) {
        UserDefaults.standard.set(completed, forKey: imageQuizCompletedKey)
        updateAchievements()
    }
    
    func isImageQuizCompleted() -> Bool {
        return UserDefaults.standard.bool(forKey: imageQuizCompletedKey)
    }
    
    func setGalacticQuizCompleted(_ completed: Bool) {
        UserDefaults.standard.set(completed, forKey: galacticQuizCompletedKey)
        updateAchievements()
    }
    
    func isGalacticQuizCompleted() -> Bool {
        return UserDefaults.standard.bool(forKey: galacticQuizCompletedKey)
    }
    
    // MARK: - Achievement Checking
    
    func updateAchievements() {
        let matchLevelsCompleted = getMatchLevelsCompleted()
        let totalGamesPlayed = getTotalGamesPlayed()
        let imageQuizCompleted = isImageQuizCompleted()
        let galacticQuizCompleted = isGalacticQuizCompleted()
        
        // Check and unlock achievements
        if matchLevelsCompleted >= 1 {
            unlockAchievement(.firstMatchLevel)
        }
        
        if matchLevelsCompleted >= 5 {
            unlockAchievement(.complete5Levels)
        }
        
        if matchLevelsCompleted >= 10 {
            unlockAchievement(.complete10Levels)
        }
        
        if imageQuizCompleted {
            unlockAchievement(.completeImageQuiz)
        }
        
        if galacticQuizCompleted {
            unlockAchievement(.completeGalacticQuiz)
        }
        
        if totalGamesPlayed >= 10 {
            unlockAchievement(.play10Games)
        }
        
        if totalGamesPlayed >= 25 {
            unlockAchievement(.play25Games)
        }
        
        if totalGamesPlayed >= 50 {
            unlockAchievement(.play50Games)
        }
        
        if imageQuizCompleted && galacticQuizCompleted {
            unlockAchievement(.master)
        }
        
        // Check if tried all game modes (at least played each once)
        if totalGamesPlayed >= 3 {
            unlockAchievement(.explorer)
        }
        
        // Check collector achievement (5 achievements unlocked)
        let completedCount = getCompletedAchievementIds().count
        if completedCount >= 5 {
            unlockAchievement(.collector)
        }
        
        // Check champion achievement (all achievements unlocked)
        if completedCount >= Achievement.allAchievements.count - 1 {
            unlockAchievement(.champion)
        }
    }
    
    private func unlockAchievement(_ type: AchievementType) {
        let completedIds = getCompletedAchievementIds()
        if !completedIds.contains(type) {
            saveCompletedAchievement(type)
            // Можно добавить уведомление или анимацию здесь
            print("🎉 Achievement unlocked: \(type.rawValue)")
        }
    }
    
    // MARK: - Special Achievements
    
    func checkPerfectMatch(levelId: Int, mistakes: Int) {
        if mistakes == 0 {
            unlockAchievement(.perfectMatch)
        }
    }
    
    func checkSpeedRunner(time: TimeInterval) {
        if time < 30.0 {
            unlockAchievement(.speedRunner)
        }
    }
}
