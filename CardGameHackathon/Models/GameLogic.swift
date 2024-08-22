//
//  GameLogic.swift
//  CardGameHackathon
//
//  Created by Hina on 2024/08/15.
//

import Foundation

struct GameLogic {
    static func levHintValue(index: Int, cards: [Int]) -> String {
        let number = cards[index]
        var smallNumber = 0
        if number >= 8 {
            smallNumber = 8
        } else if number >= 4 {
            smallNumber = number - 1
        } else if number == 2 || number == 3 {
            smallNumber = 2
        }
        let hintString = "\(smallNumber)+"
        return hintString
    }

    static func chooseRandomValue(index: Int, cards: [Int]) -> String {
        let number = cards[index]
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
    static func chooseBigSmall(index: Int, cards: [Int]) -> String {
        var returnString = ""
        if index == 0 || index == 3 || index == 6 {
            if cards[index] > cards[index+1] {
                print("\(cards[index])")
                print("\(cards[index+1])")
                returnString = ">"
            } else {
                returnString = "<"
            }
        } else if index == 1 || index == 4 || index == 7 {
            if cards[index] > cards[index+1] {
                returnString = ">"
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
