//
//  ContentView.swift
//  CardGameHackathon
//
//  Created by Hina on 2024/06/18.
//

import SwiftUI

//class CardGameViewModel: ObservableObject {
//    @Published var cards = ["2", "3", "4", "5", "6", "7", "8", "9", "😭"]
//}

struct ContentView: View {
//    @StateObject var viewModel: CardGameViewModel
    @State var cards = ["2", "3", "4", "5", "6", "7", "8", "9", "logo"]
    @State var movies: [Bool] = Array(repeating: false, count: 9)
    @State var sum = 0
    @State var showSumView = false

        var body: some View {
            ZStack {
                Color.green
                    .ignoresSafeArea()
                VStack {
                    Text("合計獲得ポイント:\(sum)")
                        .font(.title2)
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                          alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                          spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/,
                          pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/,
                          content: {
                    ForEach(0..<9, id: \.self) { index in
                        VStack {
                            Button {
                                if movies[index] == false {
                                    movies[index] = true
                                    if cards[index] != "logo" {
                                        sum += Int(cards[index]) ?? 0
                                    } else {
                                        showSumView = true
                                    }
                                }
                            } label: {
                                Flip(isFront: movies[index],
                                     front: {
                                    Image("card\(cards[index])") // front
                                },
                                     back: {
                                    Image("back") // back
                                })
                            }
                        }
                    }
                })
            }
                .overlay {
                    if showSumView == true {
                        Color.black.opacity(0.3)
                        VStack {
                            Text("合計獲得ポイント:\(sum)")
                                .font(.title)
//                            SelectStampCell(postStamp: $selectedImage, showSelectStampView: $showSelectStampView)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 400)
                        .background()
                    }
                }
                .padding()
            }
        }
}

#Preview {
    ContentView()
}
