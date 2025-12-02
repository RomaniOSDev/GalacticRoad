//
//  MainView.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

struct MainView: View {
    @State private var sizeShadow = false
    var body: some View {
        NavigationStack {
            ZStack{
                Image(.mainFon)
                    .resizable()
                    .ignoresSafeArea()
                VStack{
                    //MARK: - top header
                    HStack{
                        NavigationLink {
                            AchivmentView()
                        } label: {
                            Image(.achivmentBtN)
                                .resizable()
                                .frame(width: 70, height: 79)
                        }
                        Spacer()
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image(.settingsbtn)
                                .resizable()
                                .frame(width: 70, height: 79)
                        }
                    }
                    Spacer()
                    
                    //MARK: - main big logo
                    Image(.mainLogo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                    
                    //MARK: - PlayButton
                    NavigationLink {
                        PlayView()
                    } label: {
                        Image(.playBTN)
                            .resizable()
                            .frame(width: 170, height: 150)
                            .shadow(color: .yellow, radius: sizeShadow ? 10 : 0)
                    }
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
                            sizeShadow.toggle()
                        }
                    }
                    .animation(.easeInOut, value: sizeShadow)

                }.padding()
            }
        }
    }
}

#Preview {
    MainView()
}
