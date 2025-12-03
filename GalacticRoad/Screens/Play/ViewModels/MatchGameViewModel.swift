//
//  MatchGameViewModel.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI
import Combine

class MatchGameViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var flippedCardIndices: [Int] = []
    @Published var matchedPairs: Int = 0
    @Published var moves: Int = 0
    @Published var showWinScreen: Bool = false
    @Published var elapsedTime: TimeInterval = 0
    
    let level: MatchLevel
    let levelData = MatchLevelData.shared
    
    private var timer: Timer?
    private var startTime: Date?
    
    init(level: MatchLevel) {
        self.level = level
        setupGame()
        startTimer()
    }
    
    deinit {
        stopTimer()
    }
    
    func startTimer() {
        stopTimer()
        startTime = Date()
        elapsedTime = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self, let startTime = self.startTime else { return }
            self.elapsedTime = Date().timeIntervalSince(startTime)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time.truncatingRemainder(dividingBy: 1)) * 10)
        return String(format: "%02d:%02d.%d", minutes, seconds, milliseconds)
    }
    
    func setupGame() {
        print("🔵 setupGame called for level \(level.id)")
        print("🔵 Required pairs: \(level.pairs)")
        print("🔵 Available card images: \(levelData.cardImages.count)")
        
        guard !levelData.cardImages.isEmpty else {
            print("❌ ERROR: cardImages is empty!")
            return
        }
        
        // Get required number of unique cards
        let requiredCards = level.pairs
        var selectedImages: [ImageResource] = []
        
        // Select cards from available 15 cards
        // If we need more pairs than available cards, we'll use duplicates
        let shuffledImages = levelData.cardImages.shuffled()
        
        if requiredCards <= levelData.cardImages.count {
            // Use unique cards
            selectedImages = Array(shuffledImages.prefix(requiredCards))
        } else {
            // Use all cards and add duplicates
            selectedImages = levelData.cardImages.shuffled()
            let additionalNeeded = requiredCards - levelData.cardImages.count
            let additionalImages = Array(shuffledImages.prefix(additionalNeeded))
            selectedImages.append(contentsOf: additionalImages)
        }
        
        print("🔵 Selected images count: \(selectedImages.count)")
        
        // Create pairs
        var newCards: [Card] = []
        for image in selectedImages {
            newCards.append(Card(imageName: image))
            newCards.append(Card(imageName: image))
        }
        
        print("🔵 Created cards count: \(newCards.count)")
        
        // Shuffle cards
        cards = newCards.shuffled()
        matchedPairs = 0
        moves = 0
        flippedCardIndices = []
        elapsedTime = 0
        
        print("🔵 Final cards array count: \(cards.count)")
    }
    
    func flipCard(at index: Int) {
        guard index < cards.count else { 
            print("❌ Index \(index) out of bounds. Cards count: \(cards.count)")
            return 
        }
        
        guard !cards[index].isFlipped && !cards[index].isMatched else { 
            print("⚠️ Card \(index) already flipped or matched")
            return 
        }
        guard flippedCardIndices.count < 2 else { 
            print("⚠️ Already have 2 cards flipped")
            return 
        }
        
        print("🟢 Flipping card at index \(index), current state: isFlipped=\(cards[index].isFlipped), isMatched=\(cards[index].isMatched)")
        print("🟢 Cards before update: \(cards.map { "\($0.id.uuidString.prefix(8)):flipped=\($0.isFlipped)" })")
        
        // Переворачиваем карточку - создаем полностью новый массив
        let newCards = cards.enumerated().map { cardIndex, currentCard in
            if cardIndex == index {
                return Card(
                    id: currentCard.id,
                    imageName: currentCard.imageName,
                    isFlipped: true,
                    isMatched: currentCard.isMatched
                )
            } else {
                return currentCard
            }
        }
        cards = newCards
        flippedCardIndices.append(index)
        
        print("🟢 Card \(index) flipped: isFlipped=\(cards[index].isFlipped)")
        print("🟢 Cards after update: \(cards.map { "\($0.id.uuidString.prefix(8)):flipped=\($0.isFlipped)" })")
        print("🟢 Flipped indices: \(flippedCardIndices)")
        
        // Если открыты две карточки, проверяем совпадение
        if flippedCardIndices.count == 2 {
            moves += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.checkMatch()
            }
        }
    }
    
    private func checkMatch() {
        let firstIndex = flippedCardIndices[0]
        let secondIndex = flippedCardIndices[1]
        
        if cards[firstIndex].imageName == cards[secondIndex].imageName {
            // Match found
            cards = cards.enumerated().map { cardIndex, currentCard in
                if cardIndex == firstIndex || cardIndex == secondIndex {
                    return Card(
                        id: currentCard.id,
                        imageName: currentCard.imageName,
                        isFlipped: true,
                        isMatched: true
                    )
                } else {
                    return currentCard
                }
            }
            matchedPairs += 1
            
            flippedCardIndices.removeAll()
            
            // Check if all pairs are matched
            if matchedPairs == level.pairs {
                stopTimer()
                // Разблокируем следующий уровень
                ProgressManager.shared.unlockNextLevel(after: level.id)
                
                // Отслеживание достижений
                let achievementManager = AchievementManager.shared
                achievementManager.incrementMatchLevelsCompleted()
                achievementManager.incrementTotalGamesPlayed()
                
                // Проверяем специальные достижения
                let mistakes = moves - level.pairs // Примерное количество ошибок
                achievementManager.checkPerfectMatch(levelId: level.id, mistakes: mistakes)
                achievementManager.checkSpeedRunner(time: elapsedTime)
                
                // Сохраняем статистику
                GameStatisticsManager.shared.addMatchLevelResult(levelId: level.id, time: elapsedTime, moves: moves)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showWinScreen = true
                }
            }
        } else {
            // No match - flip back after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.cards = self.cards.enumerated().map { cardIndex, currentCard in
                    if cardIndex == firstIndex || cardIndex == secondIndex {
                        return Card(
                            id: currentCard.id,
                            imageName: currentCard.imageName,
                            isFlipped: false,
                            isMatched: false
                        )
                    } else {
                        return currentCard
                    }
                }
                self.flippedCardIndices.removeAll()
            }
        }
    }
}
