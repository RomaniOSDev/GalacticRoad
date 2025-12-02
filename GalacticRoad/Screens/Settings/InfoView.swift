//
//  InfoView.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            Image(.mainFon)
                .resizable()
                .ignoresSafeArea()
            VStack{
                HStack{
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(.closeBtn)
                            .resizable()
                            .frame(width: 80, height: 80)
                    }

                }
                Image(.infoLabel)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .navigationBarBackButtonHidden()
            .padding()
        }
    }
}

#Preview {
    InfoView()
}
