//
//  ScoreView.swift
//  CardGameHackathon
//
//  Created by Hina on 2024/06/27.
//

import SwiftUI

struct ScoreView: View {
    @Binding var sum: Int
    @Binding var movies: [Bool]
    @AppStorage("Total") var totalScore: Int?
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            Text("This Game Score: \(sum)")
                .font(.largeTitle)
            if let totalScore = totalScore {
                Text("Total Score: \(totalScore + sum)")
                    .font(.title3)
            }
            Image("score")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
            Button {
                movies = Array(repeating: false, count: 9)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    dismiss()
                }
            } label: {
                Text("Next")
                    .fontWeight(.bold)
                    .tint(.white)
                    .padding()
                    .frame(minWidth: 140, minHeight: 60)
                    .background(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    @State var sum = 10
    @State var movies = [false,false]
    return ScoreView(sum: $sum, movies: $movies)
}
