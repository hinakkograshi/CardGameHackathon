//
//  StartView.swift
//  CardGameHackathon
//
//  Created by Hina on 2024/07/11.
//

import SwiftUI

struct StartView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @State var showGameView = false
    @State var isLev1 = false
    @State var isLev2 = false
    var body: some View {
        VStack(spacing: 10){
            Text("Game Start")
                .font(.system(size: 50, weight: .black))
            Image("score")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
            Text("下のボタンからレベルを選んで\nゲームを開始しましょう！").multilineTextAlignment(.center)
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
            Button {
                if let url = URL(string: "https://hiyokkograshi.com/jocker-card-game%e6%93%8d%e4%bd%9c%e8%aa%ac%e6%98%8e/") {
                    openURL(url)
                }
            } label: {
                Text("ルール説明")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(minWidth: 160, minHeight: 40)
                    .background(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                    .foregroundStyle(.orange)
            }
            .padding(.bottom, 10)
        }
        .fullScreenCover(isPresented: $showGameView, content: {
            GameView(isLev1: $isLev1, isLev2: $isLev2)
        })
    }
}

#Preview {
    StartView()
}
