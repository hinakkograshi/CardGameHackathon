//
//  ContentView.swift
//  CardGameHackathon
//
//  Created by Hina on 2024/06/18.
//

import SwiftUI

class CardGameViewModel: ObservableObject {
    @Published var cards = ["2", "3", "4", "5", "6", "7", "8", "9", "😭"]
}

struct ContentView: View {

    @State var isFront = false

        var body: some View {
            ZStack {
                Color.green
                    .ignoresSafeArea()
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

                            Image("card2") // front
                        },
                             back: {

                            Image("back") // back
                        })
                    }
                }
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
