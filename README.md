# Joker Card Game
トランプカードゲームミニアプリです。

Jokerねこのカードをめくらないようにヒントを使いながらカードをめくり、得点を増やしていきましょう！
2~9の数字のトランプを引くとそのトランプの数字が獲得点数となります。縦一列を揃えるとヒントボタンを使用することができます。

## AppStore
Joker Card Game

[https://apps.apple.com/jp/app/%E3%83%9D%E3%82%B8%E3%82%B3%E3%83%AC-positivewordscollection/id6511249150](https://apps.apple.com/jp/app/joker-card-game/id6532621202)
## Framework
SwiftUI

## アプリアイデア
2週間のオンラインハッカソンのアイデアを元にアプリをリリースしました。

## ハッカソン受賞
| 最優秀賞 | 観客投票賞 |　審査員賞 |
| ------------- | ------------- | ------------- |
| ![GrandWinner](https://github.com/user-attachments/assets/ab7abba1-4fb1-422a-8b99-6e1843d7f23a) | ![AudienceAward](https://github.com/user-attachments/assets/e98015e8-6b87-41b6-a9d8-90e5a890928b) | ![AVIEAward](https://github.com/user-attachments/assets/4e7a9f74-e2f3-4d76-87eb-ad5b6fffb9c3) |

## 今後の課題
設計やテストコードを意識したコードにリファクタリングしたい！


# Jo-ka? for iOS
#### MeltingHack Sprint #2 - Team Swift Submission

![Simulator Screen Recording - iPhone 15 Pro - 2024-06-30 at 09 52 27](https://github.com/hinakkograshi/CardGameHackathon/assets/131275914/be5c5684-2b86-413b-a71f-d080210141fa)


### Inspiration
Given the hackathon theme of making a card game, we decided to do our own implementation of [High Stakes](https://krystman.itch.io/high-stakes), a simple probability puzzle game. The original game only has a version built for web and given the form factor and the quick playability of the game, creating a version for the phone was natural. 

### Gameplay
In Jo-ka?, there are 8 number cards, 2 - 9, and 1 joker with a value of 10. The objective is to flip over as many cards as possible without flipping the joker. As you flip over columns of the board, you get access to hints which provide additional information on unknown cards. The minimum hint reveals the minimum value a chosen unknown card can be. The comparison hint reveals whether adjecent cards are greater than a chosen known card. The glass hint reveals the value of a card. Flip over cards while avoiding the joker to get the highest score possible!

### Future Features
- A stake to immediately guess the joker
- Increasing difficulty between rounds
- Hints for rows
- Online leaderboards

### Team Members
- [Hina](https://github.com/hinakkograshi)
- [Rafiq](https://github.com/Rafiq6581)
- [Kian](https://github.com/Finay)
