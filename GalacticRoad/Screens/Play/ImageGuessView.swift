//
//  ImageGuessView.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

struct ImageGuessView: View {
    @StateObject private var viewModel = ImageGuessViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Image(.mainFon)
                .resizable()
                .ignoresSafeArea()
            
            if viewModel.isQuizCompleted {
                // Финальный экран
                VStack(spacing: 40) {
                    Spacer()
                    
                    Image(.winLabel)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 300)
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(.backToMenu)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 80)
                    }
                    .padding(.bottom, 40)
                }
                .padding()
            } else if let question = viewModel.currentQuestion {
                VStack(spacing: 30) {
                    Image(.imagegues)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                    Spacer()
                    
                    // Картинка вопроса
                    Image(question.imageCard)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    // Варианты ответов
                    HStack(spacing: 15) {
                        ForEach(viewModel.answerOptions, id: \.self) { answer in
                            Button {
                                if !viewModel.showResult {
                                    viewModel.selectAnswer(answer)
                                }
                            } label: {
                                ZStack {
                                    Image(.backAnswer)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                   VStack {
                                       Circle()
                                           .frame(width: 30, height: 30)
                                           .opacity(0)
                                        Spacer()
                                        Text(answer)
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                     
                                            Image(viewModel.isCorrect ? .correct : .uncorrect)
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .opacity(viewModel.showResult && viewModel.selectedAnswer == answer ? 1.0 : 0.0)
                                        
                                    }
                                    .padding(.horizontal, 20)
                                }
                                .frame(height: 60)
                            }
                            .disabled(viewModel.showResult)
                            .opacity(viewModel.showResult && viewModel.selectedAnswer != answer && !viewModel.isCorrect ? 0.5 : 1.0)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    // Кнопки внизу
                    HStack(spacing: 20) {
                        // Кнопка выхода
                        Button {
                            dismiss()
                        } label: {
                            Image(.backQuizBTN)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 60)
                        }
                        
                        // Кнопка следующего вопроса
                        if viewModel.showResult {
                            Button {
                                viewModel.nextQuestion()
                            } label: {
                                Image(.nextbTN)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150, height: 60)
                            }
                        } else {
                            // Плейсхолдер для симметрии
                            Color.clear
                                .frame(width: 150, height: 60)
                        }
                    }
                    .padding(.bottom, 40)
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ImageGuessView()
}
