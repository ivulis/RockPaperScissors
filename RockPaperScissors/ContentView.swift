//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by jazeps.ivulis on 28/08/2023.
//

import SwiftUI

struct Emoji: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 50))
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
}

extension View {
    func emojiStyle() -> some View {
        modifier(Emoji())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State private var move = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    
    @State private var round = 1
    @State private var score = 0
    
    @State private var isGameOver = false
    
    let moves = ["✊", "🖐️", "✌️"]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .black]), startPoint: .top, endPoint: .bottom)
            
            VStack {
                Text("Round: \(round)")
                    .titleStyle()
                
                Text(moves[move])
                    .emojiStyle()
                
                Text(shouldWin ? "Win" : "Lose")
                    .titleStyle()
                
                ForEach(0..<3) { emoji in
                    Button {
                        emojiTapped(emoji)
                    } label: {
                        Text("\(moves[emoji])")
                            .emojiStyle()
                    }
                }
            }
            .alert("Game over!", isPresented: $isGameOver) {
                Button("Restart", action: restartGame)
            } message: {
                Text("You scored \(score) out of \(round).\nTap \"Restart\" to play again.")
            }
        }
        .ignoresSafeArea()
    }
    
    func emojiTapped(_ emoji: Int) {
        let rock = "✊"
        let paper = "🖐️"
        let scissors = "✌️"
        
        switch move {
        case 0:
            if moves[emoji] == paper {
                shouldWin ? (score += 1) : nil
            } else if moves[emoji] == scissors {
                shouldWin ? nil : (score += 1)
            } else {
                move = Int.random(in: 0..<3)
            }
        case 1:
            if moves[emoji] == rock {
                shouldWin ? nil : (score += 1)
            } else if moves[emoji] == scissors {
                shouldWin ? (score += 1) : nil
            } else {
                move = Int.random(in: 0..<3)
            }
        case 2:
            if moves[emoji] == rock {
                shouldWin ? (score += 1) : nil
            } else if moves[emoji] == paper {
                shouldWin ? nil : (score += 1)
            } else {
                move = Int.random(in: 0..<3)
            }
        default:
            return
        }
        
        if round == 10 {
            isGameOver = true
        } else {
            round += 1
            move = Int.random(in: 0..<3)
            shouldWin.toggle()
        }
    }
    
    func restartGame() {
        move = Int.random(in: 0..<3)
        shouldWin.toggle()
        round = 1
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
