//
//  ScoreView.swift
//  CardGameHackathon
//
//  Created by Hina on 2024/06/27.
//

import SwiftUI

struct ScoreView: View {
    @Binding var sum: Int
    @AppStorage("Total") var totalScore: Int?
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            Text("This Game Score: \(sum)")
                .font(.title)
            if let totalScore = totalScore {
                Text("Total Score: \(totalScore + sum)")
            }
            Button("次へ") {
                dismiss()
            }
        }
    }
}

//#Preview {
//    @State var sum = 10
//    ScoreView(sum: $sum)
//}
