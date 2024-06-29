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
    @State var showJockerView = false
    @State var showSuccessView = false
    @State var selectedCard = false
    @State var ans: String = ""
    @State var plusHint: String = ""
    @State var searchHint: String = ""
    @State var firstButtonEnable: Bool = true
    @State var secondButtonEnable: Bool = true
    @State var thirdButtonEnable: Bool = true
    @State var abilityMode = false
    @State var plusHintMode = false
    @State var searchHintMode = false
    @State var indexNumBigSmall = 0
    @State var indexNumPlus = 0
    @State var indexNumSearch = 0
    @State var isSuccess = true
    @AppStorage("Total") var totalScore = 0


    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack {
                Text("This Game Score:\(sum)")
                    .font(.largeTitle)
                    .padding(.bottom, 8)
                if abilityMode == true, plusHintMode == true {
                    Text("Please chose open card.")
                        .foregroundStyle(.red)
                }
                HStack {
                    Spacer()
                    // First
                    Button(action: {
                        abilityMode = true

                    }, label: {
                        Text("<>")
                            .border(.primary)
                            .font(.largeTitle)
                    })
                    .disabled(firstButtonEnable)
                    Spacer()

                    // Second
                    Button(action: {
                        plusHintMode = true

                    }, label: {
                        Image(systemName: "plus")
                            .border(.primary)
                            .font(.largeTitle)
                    })
                    .disabled(secondButtonEnable)
                    Spacer()

                    // Third
                    Button(action: {
                        searchHintMode = true

                    }, label: {
                        Image(systemName: "magnifyingglass")
                            .font(.largeTitle)
                            .border(.primary)
                    })
                    .disabled(thirdButtonEnable)
                    Spacer()
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
                                    if movies[index] == false, abilityMode == false, plusHintMode == false, searchHintMode == false {
                                        movies[index] = true
                                        if cards[index] != "10" {
                                            sum += Int(cards[index]) ?? 0
                                        } else {
                                            movies.forEach { bool in
                                                if bool == false {
                                                    isSuccess = false
                                                }
                                            }
                                            if isSuccess == false {
                                                    showJockerView = true
                                            } else {
                                                    showSuccessView = true
                                            }
                                            // 全部trueかどうか🟥
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                                showJockerView = false
                                                showSumView = true
                                            }
                                        }
                                    }
                                    // <>
                                    if abilityMode == true, movies[index] == true {
                                        indexNumBigSmall = index
                                        ans = chooseBigSmall(index: index)
                                        print(ans)
                                        abilityMode = false
                                    }

                                    // Num+
                                    if plusHintMode == true, movies[index] == false {
                                        indexNumPlus = index
                                        plusHint = chooseRandomValue(index: index)
                                        print(plusHint)
                                        plusHintMode = false
                                    }
                                    // 🟥Search
                                    if searchHintMode == true, movies[index] == false {
                                        indexNumSearch = index
                                        searchHint = cards[index]
                                        searchHintMode = false
                                    }
                                    //左縦
                                    if movies[0] == true, movies[3] == true, movies[6] == true {
                                        firstButtonEnable = false
                                    }
                                    if movies[1] == true, movies[4] == true, movies[7] == true {
                                        secondButtonEnable = false
                                    }
                                    if movies[2] == true, movies[5] == true, movies[8] == true {
                                        thirdButtonEnable = false
                                    }
                                } label: {

                                    Flip(isFront: movies[index],
                                         front: {
                                        Image("card\(cards[index])") // front
                                            .resizable()
                                            .frame(width: 120, height: 160)

                                    },
                                         back: {
                                        Image("back") // back
                                            .resizable()
                                            .frame(width: 120, height: 160)
                                    })
                                }
                                if ans != "" {
                                    if index == indexNumBigSmall {
                                        Text(ans)
                                            .font(.title)
                                            .foregroundStyle(.white)
                                            .padding()
                                            .frame(width: 70, height: 70)
                                            .background(.blue)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                }
                                if plusHint != "" {
                                    if index == indexNumPlus {
                                        Text(plusHint)
                                            .font(.title)
                                            .foregroundStyle(.white)
                                            .padding()
                                            .frame(width: 70, height: 70)
                                            .background(.blue)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                }
                                if searchHint != "" {
                                    if index == indexNumSearch {
                                        Text(searchHint)
                                            .font(.title)
                                            .foregroundStyle(.white)
                                            .padding()
                                            .frame(width: 70, height: 70)
                                            .background(.blue)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                }
                            }

                        }
                    }
                })
            }
            if showJockerView == true {
                Image("jocker")
                    .resizable()
                    .scaledToFill()
            }
            if showSuccessView == true {
                Image("success")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            }
        }
        .fullScreenCover(isPresented: $showSumView, onDismiss: {
            totalScore += sum
            reset()
        }, content: {
            ScoreView(sum: $sum, movies: $movies)
        })
        .onAppear(perform: {
            cards.shuffle()
            print("cards\(cards)")
        })
    }
    func reset() {
        movies = Array(repeating: false, count: 9)
        cards.shuffle()
        sum = 0
        firstButtonEnable = true
        secondButtonEnable = true
        thirdButtonEnable = true
        abilityMode = false
        plusHintMode = false
        searchHintMode = false
        searchHintMode = false
        indexNumBigSmall = 0
        indexNumPlus = 0
        indexNumSearch = 0
        ans = ""
    plusHint = ""
    searchHint = ""

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
        } else if index == 1 || index == 4 || index == 7 {
                if cards[index] > cards[index+1] {
                    returnString = ">"

                } else {
                    returnString = "<"
                }
        } else if index == 2 || index == 5 || index == 8 {
                if cards[index-1] < cards[index] {
                    returnString = "<"
                } else {
                    returnString = ">"
                }
        }
        return returnString
    }
}

#Preview {
    ContentView()
}
