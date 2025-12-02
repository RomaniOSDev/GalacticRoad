//
//  ResultView.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.dismiss) var dismiss
    @State private var resultQuiz = 0
    @State private var resultImage = 0
    @State private var resultFind = 0
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
                
                VStack{
                    ResultRow(image: .galacticQuiz, score: resultQuiz)
                    ResultRow(image: .imagegues, score: resultImage)
                    ResultRow(image: .findMatch, score: resultFind)
                }
                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    ResultView()
}
