//
//  GalacticQuizView.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

// MARK: - Quiz Models
struct QuizQuestion {
    let id: Int
    let question: String
    let optionA: String
    let optionB: String
    let correctAnswer: String
}

struct QuizTopic {
    let id: String
    let name: String
    let icon: ImageResource
    let questions: [QuizQuestion]
}

// MARK: - Quiz Data
class QuizData {
    static let shared = QuizData()
    
    let topics: [QuizTopic] = [
        QuizTopic(
            id: "planets",
            name: "PLANETS",
            icon: .planetIcon,
            questions: [
                QuizQuestion(id: 1, question: "Which planet is red?", optionA: "Mars", optionB: "Venus", correctAnswer: "Mars"),
                QuizQuestion(id: 2, question: "Which planet is blue?", optionA: "Earth", optionB: "Jupiter", correctAnswer: "Earth"),
                QuizQuestion(id: 3, question: "Planet with rings?", optionA: "Saturn", optionB: "Mercury", correctAnswer: "Saturn"),
                QuizQuestion(id: 4, question: "Biggest planet?", optionA: "Jupiter", optionB: "Mars", correctAnswer: "Jupiter"),
                QuizQuestion(id: 5, question: "Where do we live?", optionA: "Earth", optionB: "Uranus", correctAnswer: "Earth")
            ]
        ),
        QuizTopic(
            id: "stars",
            name: "STARS",
            icon: .starIcon,
            questions: [
                QuizQuestion(id: 6, question: "What shines?", optionA: "Star", optionB: "Rock", correctAnswer: "Star"),
                QuizQuestion(id: 7, question: "Closest star?", optionA: "Sun", optionB: "Sirius", correctAnswer: "Sun"),
                QuizQuestion(id: 8, question: "When stars appear?", optionA: "Night", optionB: "Morning", correctAnswer: "Night"),
                QuizQuestion(id: 9, question: "Star color?", optionA: "Yellow", optionB: "Black", correctAnswer: "Yellow"),
                QuizQuestion(id: 10, question: "What is hot?", optionA: "Star", optionB: "Ice", correctAnswer: "Star")
            ]
        ),
        QuizTopic(
            id: "astronauts",
            name: "ASTRONAUTS",
            icon: .astronaftIcon,
            questions: [
                QuizQuestion(id: 11, question: "Who goes to space?", optionA: "Astronaut", optionB: "Chef", correctAnswer: "Astronaut"),
                QuizQuestion(id: 12, question: "What do astronauts wear?", optionA: "Helmet", optionB: "Cap", correctAnswer: "Helmet"),
                QuizQuestion(id: 13, question: "Where do astronauts live in space?", optionA: "Station", optionB: "Tent", correctAnswer: "Station"),
                QuizQuestion(id: 14, question: "What do astronauts breathe?", optionA: "Oxygen", optionB: "Dust", correctAnswer: "Oxygen"),
                QuizQuestion(id: 15, question: "What keeps them safe?", optionA: "Tether", optionB: "Leaf", correctAnswer: "Tether")
            ]
        ),
        QuizTopic(
            id: "galaxies",
            name: "GALAXIES",
            icon: .galaxiesIcon,
            questions: [
                QuizQuestion(id: 16, question: "Our galaxy?", optionA: "MilkyWay", optionB: "Andromeda", correctAnswer: "MilkyWay"),
                QuizQuestion(id: 17, question: "What is inside galaxies?", optionA: "Stars", optionB: "Toys", correctAnswer: "Stars"),
                QuizQuestion(id: 18, question: "Galaxy shape?", optionA: "Spiral", optionB: "Cube", correctAnswer: "Spiral"),
                QuizQuestion(id: 19, question: "What is bigger?", optionA: "Galaxy", optionB: "Planet", correctAnswer: "Galaxy"),
                QuizQuestion(id: 20, question: "Many galaxies?", optionA: "Yes", optionB: "No", correctAnswer: "Yes")
            ]
        ),
        QuizTopic(
            id: "rockets",
            name: "ROCKETS",
            icon: .rocketsIcon,
            questions: [
                QuizQuestion(id: 21, question: "What blasts off?", optionA: "Rocket", optionB: "Car", correctAnswer: "Rocket"),
                QuizQuestion(id: 22, question: "Where do rockets go?", optionA: "Space", optionB: "Beach", correctAnswer: "Space"),
                QuizQuestion(id: 23, question: "What do rockets need?", optionA: "Fuel", optionB: "Soap", correctAnswer: "Fuel"),
                QuizQuestion(id: 24, question: "What comes out at launch?", optionA: "Fire", optionB: "Foam", correctAnswer: "Fire"),
                QuizQuestion(id: 25, question: "Where are rockets launched?", optionA: "Launchpad", optionB: "Balcony", correctAnswer: "Launchpad")
            ]
        ),
        QuizTopic(
            id: "animals",
            name: "ANIMALS",
            icon: .animalIcon,
            questions: [
                QuizQuestion(id: 26, question: "Who jumps?", optionA: "Rabbit", optionB: "Fish", correctAnswer: "Rabbit"),
                QuizQuestion(id: 27, question: "Who swims?", optionA: "Fish", optionB: "Panda", correctAnswer: "Fish"),
                QuizQuestion(id: 28, question: "Who roars?", optionA: "Lion", optionB: "Duck", correctAnswer: "Lion"),
                QuizQuestion(id: 29, question: "Who purrs?", optionA: "Cat", optionB: "Eagle", correctAnswer: "Cat"),
                QuizQuestion(id: 30, question: "Long ears?", optionA: "Bunny", optionB: "Turtle", correctAnswer: "Bunny")
            ]
        )
    ]
}

// MARK: - Topic Selection View
struct TopicSelectionView: View {
    let topics: [QuizTopic]
    @Binding var selectedTopic: QuizTopic?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Image(.mainFon)
                .resizable()
                .ignoresSafeArea()
            
            
                VStack(spacing: 30) {
                    Image(.chooseQuizLabel)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(topics, id: \.id) { topic in
                            Button {
                                selectedTopic = topic
                            } label: {
                                Image(topic.icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                    }
                    
                }.padding()
            
        }
    }
}

// MARK: - Quiz View
struct QuizContentView: View {
    let topic: QuizTopic
    @Binding var selectedTopic: QuizTopic?
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String? = nil
    @State private var score = 0
    @State private var showResult = false
    @State private var answeredQuestions: Set<Int> = []
    
    var currentQuestion: QuizQuestion {
        topic.questions[currentQuestionIndex]
    }
    
    var progress: Double {
        Double(currentQuestionIndex + 1) / Double(topic.questions.count)
    }
    
    var body: some View {
        ZStack {
            Image(.mainFon)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Header
                Image(topic.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                // Progress Bar
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Question \(currentQuestionIndex + 1) of \(topic.questions.count)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                        Spacer()
                        Text("Score: \(score)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 8)
                                .cornerRadius(4)
                            
                            Rectangle()
                                .fill(Color.green)
                                .frame(width: geometry.size.width * progress, height: 8)
                                .cornerRadius(4)
                        }
                    }
                    .frame(height: 8)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Question
                VStack(spacing: 30) {
                    Text(currentQuestion.question)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    // Answer Options
                    VStack(spacing: 20) {
                        AnswerButton(
                            text: currentQuestion.optionA,
                            isSelected: selectedAnswer == currentQuestion.optionA,
                            isCorrect: currentQuestion.correctAnswer == currentQuestion.optionA,
                            isWrong: selectedAnswer != nil && selectedAnswer == currentQuestion.optionA && currentQuestion.correctAnswer != currentQuestion.optionA,
                            isDisabled: selectedAnswer != nil
                        ) {
                            if selectedAnswer == nil {
                                selectedAnswer = currentQuestion.optionA
                                if currentQuestion.optionA == currentQuestion.correctAnswer {
                                    score += 1
                                }
                                answeredQuestions.insert(currentQuestion.id)
                                
                                // Auto advance after 1 second
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    nextQuestion()
                                }
                            }
                        }
                        
                        AnswerButton(
                            text: currentQuestion.optionB,
                            isSelected: selectedAnswer == currentQuestion.optionB,
                            isCorrect: currentQuestion.correctAnswer == currentQuestion.optionB,
                            isWrong: selectedAnswer != nil && selectedAnswer == currentQuestion.optionB && currentQuestion.correctAnswer != currentQuestion.optionB,
                            isDisabled: selectedAnswer != nil
                        ) {
                            if selectedAnswer == nil {
                                selectedAnswer = currentQuestion.optionB
                                if currentQuestion.optionB == currentQuestion.correctAnswer {
                                    score += 1
                                }
                                answeredQuestions.insert(currentQuestion.id)
                                
                                // Auto advance after 1 second
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    nextQuestion()
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                Spacer()
                
                Button {
                    selectedTopic = nil
                } label: {
                    Image(.backQuizBTN)
                        .resizable()
                        .frame(width: 150, height: 50)
                }
            }
        }
        .sheet(isPresented: $showResult) {
            QuizResultView(
                score: score,
                totalQuestions: topic.questions.count,
                topic: topic,
                onDismiss: {
                    selectedTopic = nil
                }
            )
        }
    }
    
    private func nextQuestion() {
        if currentQuestionIndex < topic.questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
        } else {
            // Quiz completed
            // Отслеживание достижений
            AchievementManager.shared.incrementTotalGamesPlayed()
            // Проверяем, завершен ли квиз с 100% (все вопросы правильные)
            let percentage = Int((Double(score) / Double(topic.questions.count)) * 100)
            if percentage == 100 {
                AchievementManager.shared.setGalacticQuizCompleted(true)
            }
            // Сохраняем статистику
            GameStatisticsManager.shared.addGalacticQuizResult(score: score, totalQuestions: topic.questions.count)
            showResult = true
        }
    }
}

// MARK: - Answer Button
struct AnswerButton: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let isWrong: Bool
    let isDisabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Image(.backAnswer)
                    .resizable()
                    .frame(height: 150)
                HStack {
                    Image(.correct)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .opacity(0)
                    Spacer()
                    Text(text)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    if isSelected {
                        if isCorrect {
                            Image(.correct)
                                .resizable()
                                .frame(width: 60, height: 60)
                        } else if isWrong {
                            Image(.uncorrect)
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                    }else{
                        Image(.correct)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .opacity(0)
                    }
                }
            }
        }
        .disabled(isDisabled)
    }
    
    private var backgroundColor: Color {
        if isCorrect && isSelected {
            return Color.green.opacity(0.3)
        } else if isWrong {
            return Color.red.opacity(0.3)
        } else if isSelected {
            return Color.blue.opacity(0.3)
        } else {
            return Color.blue.opacity(0.2)
        }
    }
    
    private var borderColor: Color {
        if isCorrect && isSelected {
            return Color.green
        } else if isWrong {
            return Color.red
        } else if isSelected {
            return Color.blue
        } else {
            return Color.white.opacity(0.5)
        }
    }
}

// MARK: - Result View
struct QuizResultView: View {
    let score: Int
    let totalQuestions: Int
    let topic: QuizTopic
    let onDismiss: () -> Void
    
    var percentage: Int {
        Int((Double(score) / Double(totalQuestions)) * 100)
    }
    
    var body: some View {
        ZStack {
            Image(.mainFon)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                Image(percentage == 100 ? .winLabel : .lossLabel)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                Button {
                    onDismiss()
                } label: {
                    Image(.continueBTN)
                        .resizable()
                        .frame(height: 120)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

// MARK: - Main Quiz View
struct GalacticQuizView: View {
    @State private var selectedTopic: QuizTopic? = nil
    let quizData = QuizData.shared
    
    var body: some View {
        Group {
            if let topic = selectedTopic {
                QuizContentView(topic: topic, selectedTopic: $selectedTopic)
            } else {
                TopicSelectionView(topics: quizData.topics, selectedTopic: $selectedTopic)
            }
        }
    }
}

#Preview {
    GalacticQuizView()
}
