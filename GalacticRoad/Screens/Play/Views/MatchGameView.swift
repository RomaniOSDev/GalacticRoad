//
//  MatchGameView.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

struct MatchGameView: View {
    let level: MatchLevel
    @Binding var selectedLevel: MatchLevel?
    
    @StateObject private var viewModel: MatchGameViewModel
    
    init(level: MatchLevel, selectedLevel: Binding<MatchLevel?>) {
        self.level = level
        self._selectedLevel = selectedLevel
        self._viewModel = StateObject(wrappedValue: MatchGameViewModel(level: level))
    }
    
    var body: some View {
        ZStack {
            Image(.mainFon)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    Button {
                        viewModel.stopTimer()
                        selectedLevel = nil
                    } label: {
                        Image(.backblueBTN)
                            .resizable()
                            .frame(width: 60, height: 60)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("Level \(level.id)")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                      
                        Text(viewModel.formatTime(viewModel.elapsedTime))
                            .font(.system(size: 30, weight: .semibold, design: .monospaced))
                            .foregroundColor(.yellow)
                    }
                    
                    Spacer()
                    
                    // Placeholder for symmetry
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 50, height: 50)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // Progress
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Pairs Found: \(viewModel.matchedPairs) / \(level.pairs)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 8)
                                .cornerRadius(4)
                            
                            Rectangle()
                                .fill(Color.green)
                                .frame(width: geometry.size.width * Double(viewModel.matchedPairs) / Double(level.pairs), height: 8)
                                .cornerRadius(4)
                        }
                    }
                    .frame(height: 8)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Game Grid
                let cardWidth = (UIScreen.main.bounds.width - 60) / CGFloat(level.columns)
                let cardHeight = cardWidth * 1.2
                
                if viewModel.cards.isEmpty {
                    Text("Loading cards...")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                } else {
                   
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: level.columns), spacing: 10) {
                            ForEach(viewModel.cards) { card in
                                Button {
                                    if let index = viewModel.cards.firstIndex(where: { $0.id == card.id }) {
                                        print("🔵 Button tapped for card \(card.id), index \(index)")
                                        viewModel.flipCard(at: index)
                                    }
                                } label: {
                                    CardView(
                                        card: card,
                                        width: cardWidth,
                                        height: cardHeight
                                    )
                                    
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 20)
                        .id(viewModel.cards.map { "\($0.id)-\($0.isFlipped)-\($0.isMatched)" }.joined(separator: "-"))
                    
                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $viewModel.showWinScreen) {
            WinMatchView(
                level: level,
                moves: viewModel.moves,
                time: viewModel.elapsedTime,
                timeString: viewModel.formatTime(viewModel.elapsedTime),
                onDismiss: {
                    selectedLevel = nil
                }
            )
        }
    }
}
