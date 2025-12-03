//
//  SettingsView.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @State private var urlPrivacy = "https://www.termsfeed.com/live/11a73335-b8b3-405d-b0a6-2b3de262298f"
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            Image(.mainFon)
                .resizable()
                .ignoresSafeArea()
            VStack {
                Spacer()
                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 20) {
                    NavigationLink {
                        ResultView()
                    } label: {
                        Image(.resultBtn)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    NavigationLink {
                        InfoView()
                    } label: {
                        Image(.infoBtn)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    Button {
                        SKStoreReviewController.requestReview()
                    } label: {
                        Image(.rateUsBTN)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    Button {
                        if let url = URL(string: urlPrivacy) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Image(.privacyBTN)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }

                    
                }.padding()
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(.backToMenu)
                        .resizable()
                        .frame(width: 150, height: 180)
                }

            }.padding()
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    SettingsView()
}
