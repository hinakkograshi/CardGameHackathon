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
    @State var secondButtonEnable: Bool = true
    @State var selectedCard = false
    @State var abilityMode = false
    @State var ans: String = ""
    @State var plusHint: String = ""
    @State var plusHintMode = false
    @State var indexNumBigSmall = 0
    @State var indexNumPlus = 0
    @AppStorage("Total") var totalScore = 0


    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack {
                Text("This Game Score:\(sum)")
                    .font(.title2)
                if abilityMode == true, plusHintMode == true {
                    Text("Please chose open card.")
                        .foregroundStyle(.red)
                }
                HStack {
                    // First
                    Button(action: {
                        abilityMode = true

                    }, label: {
                        Text("<>")
                            .border(.blue)
                            .font(.title)
                    })
                    .disabled(firstButtonEnable)
                    .padding(.horizontal, 30)
                    // Second
                    Button(action: {
                        plusHintMode = true

                    }, label: {
                        Text("+")
                            .border(.blue)
                            .font(.title)
                    })
                    .disabled(secondButtonEnable)
                    .padding(.horizontal, 30)
                    // Third
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
                                    // めくる
                                    if movies[index] == false, abilityMode == false, plusHintMode == false {
                                        movies[index] = true
                                        if cards[index] != "10" {
                                            sum += Int(cards[index]) ?? 0
                                        } else {
                                            showSumView = true
                                        }
                                    }
                                    // <>
                                    if abilityMode == true, movies[index] == true {
                                        indexNumBigSmall = index
                                        ans = chooseBigSmall(index: index)
                                        print(ans)
                                        abilityMode = false
                                    }
                                    //左縦
                                    if movies[0] == true, movies[3] == true, movies[6] == true {
                                        firstButtonEnable = false
                                    }
                                    // Num+
                                    if plusHintMode == true, movies[index] == false {
                                        indexNumPlus = index
                                        plusHint = chooseRandomValue(index: index)
                                        print(plusHint)
                                        plusHintMode = false
                                    }
                                    if movies[1] == true, movies[4] == true, movies[7] == true {
                                        secondButtonEnable = false
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
                                    if index == indexNumBigSmall {
                                        Text(ans)
                                            .font(.title)
                                            .foregroundStyle(.red)
                                            .border(.red)
                                    }
                                }
                                if plusHint != "" {
                                    if index == indexNumPlus {
                                        Text(plusHint)
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
    //add
    func chooseRandomValue(index: Int) -> String {
        let number = Int(cards[index])!
        var smallNumber = 0
        if number >= 5 {
            smallNumber = number - 3
        } else if number == 2 {
            smallNumber = 1
        }else {
            smallNumber = 2
        }
        let randomValue = Int.random(in: smallNumber..<number)
        let randomString = String(randomValue)
        let hintString = "\(randomString)+"
        return hintString
    }
    func chooseBigSmall(index: Int) -> String {
        var returnString = ""
        if index == 0 || index == 3 || index == 6 {
            if cards[index] > cards[index+1] {
                returnString = ">"
            } else {
                returnString = "<"
            }
        } else {
            print("Alert")

        }
        return returnString
    }
}

#Preview {
    ContentView()
}
