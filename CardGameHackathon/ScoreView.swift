//
//  ScoreView.swift
//  CardGameHackathon
//
//  Created by Hina on 2024/06/27.
//

import SwiftUI

struct ScoreView: View {
    @Binding var isLev1: Bool
    @Binding var isLev2: Bool
    @Binding var cards: [Int]
    @Binding var sum: Int
    @Binding var movies: [Bool]
    @AppStorage("Total") var totalScore: Int?
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(spacing: 10) {
            Text("This Game Score: \(sum)")
                .font(.largeTitle)
            if let totalScore = totalScore {
                Text("Total Score: \(totalScore)")
                    .font(.title3)
            }
            Image("success")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
            Button {
                isLev2 = false
                movies = Array(repeating: false, count: 9)
                cards.shuffle()
                isLev1 = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    dismiss()
                }
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
                isLev1 = false
                movies = Array(repeating: false, count: 9)
                cards.shuffle()
                isLev2 = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    dismiss()
                }
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
                isLev1 = false
                isLev2 = false
                movies = Array(repeating: false, count: 9)
                cards.shuffle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    dismiss()
                }
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
    }
}

#Preview {
    @State var sum = 10
    @State var movies = [false,false]
    @State var isLev1 = false
    @State var isLev2 = false
    @State var cards = [1, 2]
    return ScoreView(isLev1: $isLev1, isLev2: $isLev2, cards: $cards, sum: $sum, movies: $movies)
}
