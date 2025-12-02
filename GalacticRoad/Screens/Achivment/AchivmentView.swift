//
//  AchivmentView.swift
//  GalacticRoad
//
//  Created by Роман Главацкий on 01.12.2025.
//

import SwiftUI

struct AchivmentView: View {
    @State private var achivments: [Achivment] = [Achivment(icon: .card1, completed: false),
                                                  Achivment(icon: .card2, completed: false),
                                                  Achivment(icon: .card3, completed: false),
                                                  Achivment(icon: .card4, completed: false),
                                                  Achivment(icon: .card5, completed: false),
                                                  Achivment(icon: .card6, completed: false),
                                                  Achivment(icon: .card7, completed: false),
                                                  Achivment(icon: .card8, completed: false),
                                                  Achivment(icon: .card9, completed: false),
                                                  Achivment(icon: .card10, completed: false),
                                                  Achivment(icon: .card11, completed: false),
                                                  Achivment(icon: .card12, completed: false),
                                                  Achivment(icon: .card13, completed: false),
                                                  Achivment(icon: .card14, completed: false),
                                                  Achivment(icon: .card15, completed: false),
    ]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image(.mainFon)
                .resizable()
                .ignoresSafeArea()
            Spacer()
            VStack{
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image(.backToMenu)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    Spacer()

                }
                
                LazyVGrid(columns: [GridItem(),GridItem(),GridItem()]) {
                    ForEach(achivments) { achivment in
                        Image(achivment.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .opacity(achivment.completed ? 1.0 : 0.4)
                    }
                }
                Spacer()
            }.padding()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AchivmentView()
}

struct Achivment: Identifiable{
    var id = UUID()
    
    let icon: ImageResource
    let completed: Bool
}
