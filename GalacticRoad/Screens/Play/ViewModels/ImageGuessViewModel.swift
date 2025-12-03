//
//  ImageGuessViewModel.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI
import Combine

class ImageGuessViewModel: ObservableObject {
    @Published var currentQuestionIndex: Int = 0
    @Published var selectedAnswer: String? = nil
    @Published var showResult: Bool = false
    @Published var isCorrect: Bool = false
    @Published var isQuizCompleted: Bool = false
    
    private var questions: [ImagesCrads] = []
    private var shuffledQuestions: [ImagesCrads] = []
    
    init() {
        setupQuestions()
    }
    
    func setupQuestions() {
        questions = Array(ImagesCrads.allCases)
        shuffledQuestions = questions.shuffled()
        currentQuestionIndex = 0
        selectedAnswer = nil
        showResult = false
    }
    
    var currentQuestion: ImagesCrads? {
        guard currentQuestionIndex < shuffledQuestions.count else { return nil }
        return shuffledQuestions[currentQuestionIndex]
    }
    
    var isLastQuestion: Bool {
        currentQuestionIndex >= shuffledQuestions.count - 1
    }
    
    var answerOptions: [String] {
        guard let question = currentQuestion else { return [] }
        let correctAnswer = getAnswerText(for: question)
        let wrongAnswer = question.badUswer
        
        // Перемешиваем варианты ответов
        return [correctAnswer, wrongAnswer].shuffled()
    }
    
    func getAnswerText(for card: ImagesCrads) -> String {
        // Преобразуем enum case в читаемый текст
        switch card {
        case .saturne:
            return "Saturn"
        case .astronaut:
            return "Astronaut"
        case .Star:
            return "Star"
        case .Rocket:
            return "Rocket"
        case .Rabbit:
            return "Rabbit"
        case .Cow:
            return "Cow"
        case .Sun:
            return "Sun"
        }
    }
    
    func selectAnswer(_ answer: String) {
        guard let question = currentQuestion else { return }
        selectedAnswer = answer
        let correctAnswer = getAnswerText(for: question)
        isCorrect = answer == correctAnswer
        showResult = true
    }
    
    func nextQuestion() {
        if currentQuestionIndex < shuffledQuestions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
            showResult = false
        } else {
            // Если это был последний вопрос, завершаем квиз
            isQuizCompleted = true
            // Отслеживание достижений
            AchievementManager.shared.setImageQuizCompleted(true)
            AchievementManager.shared.incrementTotalGamesPlayed()
            // Сохраняем статистику
            GameStatisticsManager.shared.incrementImageQuizCompleted()
        }
    }
    
    func resetQuiz() {
        setupQuestions()
        isQuizCompleted = false
    }
}
