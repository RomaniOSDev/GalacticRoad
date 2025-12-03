//
//  AchivmentView.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

struct AchivmentView: View {
    @StateObject private var achievementManager = AchievementManager.shared
    @Environment(\.dismiss) var dismiss
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack {
            Image(.mainFon)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(.backToMenu)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // Title
                Text("Achievements")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 10)
                
                // Progress indicator
                let completedCount = achievementManager.achievements.filter { $0.completed }.count
                let totalCount = achievementManager.achievements.count
                
                VStack(spacing: 8) {
                    Text("\(completedCount) / \(totalCount) Completed")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 8)
                                .cornerRadius(4)
                            
                            Rectangle()
                                .fill(Color.green)
                                .frame(width: geometry.size.width * CGFloat(completedCount) / CGFloat(totalCount), height: 8)
                                .cornerRadius(4)
                        }
                    }
                    .frame(height: 8)
                }
                .padding(.horizontal, 20)
                
                // Achievements Grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(achievementManager.achievements) { achievement in
                            AchievementCard(achievement: achievement)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            achievementManager.updateAchievements()
        }
    }
}

struct AchievementCard: View {
    let achievement: Achievement
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Image(achievement.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .opacity(achievement.completed ? 1.0 : 0.4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(achievement.completed ? Color.green : Color.gray, lineWidth: 2)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                if achievement.completed {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.system(size: 24))
                        .offset(x: 30, y: -30)
                }
            }
            
            Text(achievement.title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(height: 30)
            
            Text(achievement.description)
                .font(.system(size: 10, weight: .regular))
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(height: 30)
        }
        .frame(width: 100)
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(achievement.completed ? Color.green.opacity(0.1) : Color.gray.opacity(0.1))
        )
    }
}

#Preview {
    AchivmentView()
}
