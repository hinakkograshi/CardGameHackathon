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

    @State var isFront = false

        var body: some View {
            ZStack {
                Color.green
                    .ignoresSafeArea()
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                          alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                          spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/,
                          pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/,
                          content: {
                    ForEach(cards, id: \.self) { num in
                        VStack {
                            Button {
                                if isFront {
                                    isFront = false
                                } else {
                                    isFront = true
                                }
                            } label: {
                                Flip(isFront: isFront,
                                     front: {
                                    Image("card\(num)") // front
                                },
                                     back: {

                                    Image("back") // back
                                })
                            }
                        }
                    }
                })
            }
        }
}

//struct CardView: View {
//    var body: some View {
//        VStack {
//            LayzyGrid
//
//        }
//    }
//}

#Preview {
    ContentView()
}
