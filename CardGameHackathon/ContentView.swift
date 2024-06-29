//
//  ContentView.swift
//  CardGameHackathon
//
//  Created by Hina on 2024/06/18.
//

import SwiftUI

struct ContentView: View {
    @State var cards = ["2", "3", "4", "5", "6", "7", "8", "9", "10"]
    @State var movies: [Bool] = Array(repeating: false, count: 9)
    @State var sum = 0
    @State var showSumView = false
    @State var firstButtonEnable: Bool = true
    @State var hintText = false
    @State var selectedCard = false
    @State var abilityMode = false
    @State var ans: String = ""
    @State var indexNum = 0
    @AppStorage("Total") var totalScore = 0


        var body: some View {
            ZStack {
                Color.green
                    .ignoresSafeArea()
                VStack {
                    Text("This Game Score:\(sum)")
                        .font(.title2)
                    if hintText == true {
                        Text("Please chose open card.")
                            .foregroundStyle(.red)
                    }
                    HStack {
                        Button(action: {
                            hintText = true
                            abilityMode = true

                        }, label: {
                                Text("<>")
                                    .border(.blue)
                                    .font(.title)
                        })
                        .disabled(firstButtonEnable)
                        .padding(.horizontal, 30)
                        Button(action: {

                        }, label: {
                            Text("+")
                                .border(.blue)
                                .font(.title)
                        })
                        .padding(.horizontal, 30)
                        Button(action: {

                        }, label: {
                            Text("+")
                                .font(.title)
                                .border(.blue)
                        })
                        .padding(.horizontal, 30)
                    }
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                          content: {
                    ForEach(0..<9, id: \.self) { index in
                        VStack {
                            ZStack {

                            Button {
                                if movies[index] == false, abilityMode == false {
                                    movies[index] = true
                                    if cards[index] != "10" {
                                        sum += Int(cards[index]) ?? 0
                                    } else {
                                        showSumView = true
                                    }
                                }
                                if abilityMode == true, movies[index] == true {
//                                    let num = Int(cards[index])!
//                                    print("cards[index]\(num)")
                                    indexNum = index
                                    ans = chose(index: index)
                                    print(ans)
                                    abilityMode = false
                                }
                                //左縦
                                if movies[0] == true, movies[3] == true, movies[6] == true {
                                    firstButtonEnable = false
                                }
                            } label: {
                                Flip(isFront: movies[index],
                                     front: {
                                    Image("card\(cards[index])") // front
                                        .resizable()

                                },
                                     back: {
                                    Image("back") // back
                                })
                            }
                                if ans == ">" || ans == "<" {
                                     let _ = print(ans)
                                    if index == indexNum {
                                        let _ = print(indexNum)
                                        Text(ans)
                                            .font(.title)
                                            .foregroundStyle(.red)
                                            .border(.red)
                                    }
                                }
                        }
                        }
                    }
                })
            }
                .fullScreenCover(isPresented: $showSumView, onDismiss: {
                    totalScore += sum
                    reset()

                }, content: {
                    ScoreView(sum: $sum)
                })
//                .overlay {
//                    if showSumView == true {
//                        Color.black.opacity(0.3)
//                        VStack {
//                            Text("合計獲得ポイント:\(sum)")
//                                .font(.title)
//                        }
//                        .frame(maxWidth: .infinity, maxHeight: 400)
//                        .background()
//                    }
//                }
                .padding()
            }
            .onAppear(perform: {
                cards.shuffle()
                print("cards\(cards)")
            })
        }
    func reset() {
        movies = Array(repeating: false, count: 9)
        cards.shuffle()
        sum = 0
        print(cards)
    }
    func chose(index: Int) -> String {
        var returnString = ""
        if index == 0 || index == 3 || index == 6 {
            if cards[index] > cards[index+1] {
                returnString = ">"
            } else {
                returnString = "<"
            }
        }
        return returnString
    }
}

#Preview {
    ContentView()
}
