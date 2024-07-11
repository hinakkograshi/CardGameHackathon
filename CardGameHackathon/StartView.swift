//
//  StartView.swift
//  CardGameHackathon
//
//  Created by Hina on 2024/07/11.
//

import SwiftUI

struct StartView: View {
    @Environment(\.dismiss) private var dismiss
    @State var showGameView = false
    @State var isLev1 = false
    @State var isLev2 = false
    @State var isLev3 = false
    var body: some View {
        VStack {
            Text("Game Start")
                .font(.largeTitle)
            Image("score")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
            Text("下のボタンからレベルを選んで\nゲームを開始しまよう！")
                .font(.title3)
            Button {
                showGameView = true
                isLev1 = true
            } label: {
                Text("Lv.1 Game Start")
                    .fontWeight(.bold)
                    .tint(.white)
                    .padding()
                    .frame(minWidth: 140, minHeight: 60)
                    .background(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
            }

            Button {
                showGameView = true
                isLev2 = true
            } label: {
                Text("Lv.2 Game Start")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(minWidth: 140, minHeight: 60)
                    .background(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                    .foregroundStyle(.green)
            }

            Button {
                showGameView = true
                isLev3 = true
            } label: {
                Text("Lv.3 Game Start")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(minWidth: 140, minHeight: 60)
                    .background(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                    .foregroundStyle(.pink)
            }
        }
        .fullScreenCover(isPresented: $showGameView, content: {
            GameView(isLev1: $isLev1, isLev2: $isLev2, isLev3: $isLev3)
        })
    }
}

#Preview {
    StartView()
}
