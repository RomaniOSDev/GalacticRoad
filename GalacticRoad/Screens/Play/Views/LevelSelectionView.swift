//
//  LevelSelectionView.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI
import Combine

struct LevelSelectionView: View {
    let levels: [MatchLevel]
    @Binding var selectedLevel: MatchLevel?
    
    @StateObject private var progressManager = ObservableProgressManager()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Image(.mainFon)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                
                Image(.levelsLabel)
                    .resizable()
                    .frame(width: 270, height: 90)
                
                Spacer()
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(levels, id: \.id) { level in
                        let isUnlocked = progressManager.isLevelUnlocked(level.id)
                        
                        Button {
                            if isUnlocked {
                                selectedLevel = level
                            }
                        } label: {
                           
                                    if isUnlocked {
                                        ZStack{
                                            Image(.unlockLevel)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                            Text("\(level.id)")
                                                .font(.system(size: 32, weight: .bold))
                                                .foregroundColor(.white)
                                        }
                                        
                                        
                                    } else {
                                        ZStack{
                                            Image(.lockLevel)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                            Image(systemName: "lock.fill")
                                                .font(.system(size: 32, weight: .bold))
                                                .foregroundColor(.gray)
                                        }
                                    }
                              
                        }
                        .padding()
                        .disabled(!isUnlocked)
                    }
                }
                .padding(.vertical, 20)
                Spacer()
               
            }.padding()
            .onAppear {
                progressManager.refresh()
            }
        }
    }
}

// Observable wrapper для ProgressManager
class ObservableProgressManager: ObservableObject {
    @Published private(set) var unlockedLevels: Set<Int>
    
    init() {
        self.unlockedLevels = ProgressManager.shared.getUnlockedLevels()
    }
    
    func isLevelUnlocked(_ levelId: Int) -> Bool {
        return unlockedLevels.contains(levelId)
    }
    
    func refresh() {
        unlockedLevels = ProgressManager.shared.getUnlockedLevels()
    }
}
