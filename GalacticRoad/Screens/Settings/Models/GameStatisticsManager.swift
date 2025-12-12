//
//  GameStatisticsManager.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import Foundation

class GameStatisticsManager {
    static let shared = GameStatisticsManager()
    
    // Keys for UserDefaults
    private let galacticQuizCompletedKey = "GalacticQuizCompleted"
    private let galacticQuizScoresKey = "GalacticQuizScores"
    private let imageQuizCompletedKey = "ImageQuizCompleted"
    private let matchLevelsCompletedKey = "MatchLevelsCompleted"
    private let matchLevelTimesKey = "MatchLevelTimes"
    private let matchLevelMovesKey = "MatchLevelMoves"
    
    private init() {}
    
    // MARK: - Galactic Quiz Statistics
    
    func getGalacticQuizCompletedCount() -> Int {
        return UserDefaults.standard.integer(forKey: galacticQuizCompletedKey)
    }
    
    func addGalacticQuizResult(score: Int, totalQuestions: Int) {
        let currentCount = getGalacticQuizCompletedCount()
        UserDefaults.standard.set(currentCount + 1, forKey: galacticQuizCompletedKey)
        
        // Сохраняем результаты для расчета среднего
        var scores = getGalacticQuizScores()
        scores.append(score)
        UserDefaults.standard.set(scores, forKey: galacticQuizScoresKey)
    }
    
    func getGalacticQuizScores() -> [Int] {
        return UserDefaults.standard.array(forKey: galacticQuizScoresKey) as? [Int] ?? []
    }
    
    func getGalacticQuizAverageScore() -> Int {
        let scores = getGalacticQuizScores()
        guard !scores.isEmpty else { return 0 }
        let sum = scores.reduce(0, +)
        return sum / scores.count
    }
    
    func getGalacticQuizBestScore() -> Int {
        let scores = getGalacticQuizScores()
        return scores.max() ?? 0
    }
    
    // MARK: - Image Quiz Statistics
    
    func getImageQuizCompletedCount() -> Int {
        return UserDefaults.standard.integer(forKey: imageQuizCompletedKey)
    }
    
    func incrementImageQuizCompleted() {
        let currentCount = getImageQuizCompletedCount()
        UserDefaults.standard.set(currentCount + 1, forKey: imageQuizCompletedKey)
    }
    
    // MARK: - Find Match Statistics
    
    func getMatchLevelsCompletedCount() -> Int {
        return UserDefaults.standard.integer(forKey: matchLevelsCompletedKey)
    }
    
    func addMatchLevelResult(levelId: Int, time: TimeInterval, moves: Int) {
        let currentCount = getMatchLevelsCompletedCount()
        UserDefaults.standard.set(currentCount + 1, forKey: matchLevelsCompletedKey)
        
        // Сохраняем время и ходы для расчета средних
        var times = getMatchLevelTimes()
        times.append(time)
        UserDefaults.standard.set(times, forKey: matchLevelTimesKey)
        
        var movesArray = getMatchLevelMoves()
        movesArray.append(moves)
        UserDefaults.standard.set(movesArray, forKey: matchLevelMovesKey)
    }
    
    func getMatchLevelTimes() -> [TimeInterval] {
        if let data = UserDefaults.standard.array(forKey: matchLevelTimesKey) as? [Double] {
            return data
        }
        return []
    }
    
    func getMatchLevelMoves() -> [Int] {
        return UserDefaults.standard.array(forKey: matchLevelMovesKey) as? [Int] ?? []
    }
    
    func getMatchAverageTime() -> TimeInterval {
        let times = getMatchLevelTimes()
        guard !times.isEmpty else { return 0 }
        let sum = times.reduce(0, +)
        return sum / Double(times.count)
    }
    
    func getMatchAverageMoves() -> Int {
        let moves = getMatchLevelMoves()
        guard !moves.isEmpty else { return 0 }
        let sum = moves.reduce(0, +)
        return sum / moves.count
    }
    
    func getMatchBestTime() -> TimeInterval {
        let times = getMatchLevelTimes()
        return times.min() ?? 0
    }
    
    func getMatchBestMoves() -> Int {
        let moves = getMatchLevelMoves()
        return moves.min() ?? 0
    }
    
    // MARK: - Reset Statistics
    
    func resetAllStatistics() {
        UserDefaults.standard.removeObject(forKey: galacticQuizCompletedKey)
        UserDefaults.standard.removeObject(forKey: galacticQuizScoresKey)
        UserDefaults.standard.removeObject(forKey: imageQuizCompletedKey)
        UserDefaults.standard.removeObject(forKey: matchLevelsCompletedKey)
        UserDefaults.standard.removeObject(forKey: matchLevelTimesKey)
        UserDefaults.standard.removeObject(forKey: matchLevelMovesKey)
    }
}

