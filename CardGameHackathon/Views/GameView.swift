//
//  ContentView.swift
//  CardGameHackathon
//
//  Created by Hina on 2024/06/18.
//

import SwiftUI

struct GameView: View {
    @Binding var isLev1: Bool
    @Binding var isLev2: Bool
    @State var cards = [2, 3, 4, 5, 6, 7, 8, 9, 10]
    @State var movies: [Bool] = Array(repeating: false, count: 9)
    @State var sum = 0
    @State var showSumView = false
    @State var showJokerView = false
    @State var showSuccessView = false
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
    @State var endGame = false
    @AppStorage("Total") var totalScore = 0
    @Environment(\.openURL) private var openURL
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    Button {
                        if let url = URL(string: "https://www.notion.so/Joker-Card-Game-2a6912abf85a80b681d8f9089fa820de") {
                            openURL(url)
                        }
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .font(.title)
                    }
                }.padding(10)
                    .foregroundColor(.blue)
                Text("This Game Score:\(sum)")
                    .font(.title)
                    .padding(.bottom, 8)
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
                                        if cards[index] != 10 {
                                            sum += cards[index]
                                        } else {
                                            movies.forEach { bool in
                                                if bool == false {
                                                    isSuccess = false
                                                }
                                            }
                                            if isSuccess == false {
                                                endGame = true
                                                totalScore += sum
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                    showJokerView = true
                                                }
                                            } else {
                                                endGame = true
                                                totalScore += sum
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                    showSuccessView = true
                                                }
                                            }
                                            // 全部trueかどうか🟥
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                                showSuccessView = false
                                                showJokerView = false
                                                showSumView = true
                                            }
                                        }
                                    }
                                    // <>
                                    if abilityMode == true, movies[index] == true {
                                        indexNumBigSmall = index
                                        ans = GameLogic.chooseBigSmall(index: index, cards: cards)
                                        print(ans)
                                        abilityMode = false
                                    }
                                    
                                    // Num+
                                    if plusHintMode == true, movies[index] == false {
                                        indexNumPlus = index
                                        plusHint = GameLogic.chooseRandomValue(index: index, cards: cards)
                                        print(plusHint)
                                        plusHintMode = false
                                    }
                                    // 🟥Search
                                    if searchHintMode == true, movies[index] == false {
                                        indexNumSearch = index
                                        searchHint = String(cards[index])
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
                                .disabled(endGame)
                                if ans != "" {
                                    if index == indexNumBigSmall {
                                        Text(ans)
                                            .font(.title)
                                            .foregroundStyle(.white)
                                            .padding()
                                            .frame(width: 70, height: 70)
                                            .background(.blue)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                            .allowsHitTesting(false)
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
                                            .allowsHitTesting(false)
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
                                            .allowsHitTesting(false)
                                    }
                                }
                                if isLev1 == true , index == 0 || index == 5 || index == 7 {
                                    Text(GameLogic.levHintValue(index: index, cards: cards))
                                        .font(.title)
                                        .foregroundStyle(.white)
                                        .padding()
                                        .frame(width: 70, height: 70)
                                        .background(.blue)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .allowsHitTesting(false)
                                }
                                if isLev2 == true , index == 3 || index == 8 {
                                    Text(GameLogic.levHintValue(index: index, cards: cards))
                                        .font(.title)
                                        .foregroundStyle(.white)
                                        .padding()
                                        .frame(width: 70, height: 70)
                                        .background(.blue)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .allowsHitTesting(false)
                                }
                            }
                        }
                    }
                })
                Spacer()
                if abilityMode == true {
                    Text("表面のカードをタップ")
                        .foregroundStyle(.red)
                        .font(.title3)
                }
                if plusHintMode == true || searchHintMode == true {
                    Text("裏面のカードをタップ")
                        .foregroundStyle(.red)
                        .font(.title3)
                }
            }
            if showJokerView == true {
                Image("joker")
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
            reset()
        }, content: {
            ScoreView(isLev1: $isLev1, isLev2: $isLev2, cards: $cards, sum: $sum, movies: $movies)
        })
        .onAppear(perform: {
            cards.shuffle()
            print("cards\(cards)")
        })
    }
    func reset() {
        endGame = false
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
        isSuccess = true
        ans = ""
        plusHint = ""
        searchHint = ""
        print("cards\(cards)")
    }
}

#Preview {
    @State var isLev1 = false
    @State var isLev2 = false
    return GameView(isLev1: $isLev1, isLev2: $isLev2)
}
