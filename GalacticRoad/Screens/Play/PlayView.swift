//
//  PlayView.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

struct PlayView: View {
    var body: some View {
        ZStack{
            Image(.mainFon)
                .resizable()
                .ignoresSafeArea()
            VStack(spacing: 40){
                //MARK: - Quiz
                NavigationLink {
                    GalacticQuizView()
                } label: {
                    Image(.galacticQuiz)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                //MARK: - Image
                NavigationLink {
                    ImageGuessView()
                } label: {
                    Image(.imagegues)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                //MARK: - Find
                NavigationLink {
                    FindMatchView()
                } label: {
                    Image(.findMatch)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }

            }.padding(40)
        }
    }
}

#Preview {
    PlayView()
}
