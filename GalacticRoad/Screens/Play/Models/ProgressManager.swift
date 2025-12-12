//
//  ProgressManager.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import Foundation

class ProgressManager {
    static let shared = ProgressManager()
    
    private let unlockedLevelsKey = "MatchGameUnlockedLevels"
    
    private init() {
        // Убедимся, что первый уровень всегда открыт
        if getUnlockedLevels().isEmpty {
            unlockLevel(1)
        }
    }
    
    func getUnlockedLevels() -> Set<Int> {
        if let data = UserDefaults.standard.array(forKey: unlockedLevelsKey) as? [Int] {
            return Set(data)
        }
        return [1] // Первый уровень всегда открыт по умолчанию
    }
    
    func isLevelUnlocked(_ levelId: Int) -> Bool {
        return getUnlockedLevels().contains(levelId)
    }
    
    func unlockLevel(_ levelId: Int) {
        var unlocked = getUnlockedLevels()
        unlocked.insert(levelId)
        UserDefaults.standard.set(Array(unlocked), forKey: unlockedLevelsKey)
    }
    
    func unlockNextLevel(after levelId: Int) {
        unlockLevel(levelId + 1)
    }
    
    func resetProgress() {
        UserDefaults.standard.removeObject(forKey: unlockedLevelsKey)
        unlockLevel(1) // Первый уровень всегда открыт
    }
}

