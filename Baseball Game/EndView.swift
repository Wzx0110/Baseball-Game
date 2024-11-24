//
//  EndView.swift
//  Baseball Game
//
//  Created by 翁子翔 on 2024/11/24.
//


import SwiftUI

struct EndView: View {
    @Environment(GameModel.self) private var gameModel
    
    var body: some View {
        VStack {
            Text("Game Over")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Opponent Score : \(gameModel.score)")
                .font(.title2)
                .padding(.bottom, 20)
            
            Button(action: {
                // 重置遊戲狀態
                gameModel.balls = 0
                gameModel.strikes = 0
                gameModel.outs = 0
                gameModel.score = 0
                gameModel.isEndGame.toggle()
            }) {
                Text("重新開始")
                    .font(.title)
                    .padding()
                    .background(Capsule().fill(Color.red))
                    .foregroundColor(.white)
            }
            .padding(.top, 20)
        }
        .padding()
    }
}

#Preview {
    EndView()
        .environment(GameModel())
}
