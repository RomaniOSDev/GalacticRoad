//
//  ResultView.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI
import Combine

struct ResultView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var statisticsManager = ObservableStatisticsManager()
    
    var body: some View {
        ZStack{
            Image(.mainFon)
                .resizable()
                .ignoresSafeArea()
            VStack{
                //MARK: - top bar
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image(.backblueBTN)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    Spacer()
                    Text("results")
                        .textCase(.uppercase)
                        .foregroundStyle(.white)
                        .font(.system(size: 50, weight: .bold, design: .default))
                    Spacer()
                    Image(.backblueBTN)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .opacity(0)

                }
                Spacer()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Galactic Quiz - показываем количество пройденных квизов и лучший результат
                        ResultRow(
                            image: .galacticQuiz,
                            score: statisticsManager.galacticQuizCompleted,
                            count: max(statisticsManager.galacticQuizBestScore, 5) // Минимум 5 (количество вопросов в квизе)
                        )
                        
                        // Image Quiz - показываем количество пройденных квизов
                        ResultRow(
                            image: .imagegues,
                            score: statisticsManager.imageQuizCompleted,
                            count: 10
                        )
                        
                        // Find Match - показываем количество пройденных уровней
                        ResultRow(
                            image: .findMatch,
                            score: statisticsManager.matchLevelsCompleted,
                            count: 10
                        )
                    }
                    .padding(.vertical, 20)
                }
                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden()
            .onAppear {
                statisticsManager.refresh()
            }
        }
    }
}

// Observable wrapper для GameStatisticsManager
class ObservableStatisticsManager: ObservableObject {
    @Published var galacticQuizCompleted: Int = 0
    @Published var galacticQuizBestScore: Int = 0
    @Published var imageQuizCompleted: Int = 0
    @Published var matchLevelsCompleted: Int = 0
    
    func refresh() {
        let stats = GameStatisticsManager.shared
        galacticQuizCompleted = stats.getGalacticQuizCompletedCount()
        galacticQuizBestScore = stats.getGalacticQuizBestScore()
        imageQuizCompleted = stats.getImageQuizCompletedCount()
        matchLevelsCompleted = stats.getMatchLevelsCompletedCount()
    }
}

#Preview {
    ResultView()
}
