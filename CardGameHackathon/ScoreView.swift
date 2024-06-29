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
                .font(.title)
            if let totalScore = totalScore {
                Text("Total Score: \(totalScore + sum)")
            }
            Button("Next") {
                 movies = Array(repeating: false, count: 9)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    dismiss()
                }
            }
        }
    }
}

//#Preview {
//    @State var sum = 10
//    ScoreView(sum: $sum)
//}
