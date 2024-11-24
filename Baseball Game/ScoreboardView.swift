//
//  ScoreboardView.swift
//  Baseball Game
//
//  Created by 翁子翔 on 2024/11/22.
//


import SwiftUI

struct ScoreboardView: View {
    let gameModel: GameModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.black)
                .frame(width: 270, height: 130)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(style: StrokeStyle(
                            lineWidth: 3,
                            dash: [8, 3]
                        ))
                        .foregroundColor(.white)
                )
            HStack {
                VStack(alignment: .leading) {
                    HStack { // Ball
                        Text("B")
                            .foregroundStyle(.white)
                            .font(.headline)
                        ForEach(0..<3) { index in
                            Circle()
                                .foregroundStyle(index < gameModel.balls ? .green : .gray)
                                .frame(width: 30, height: 30)
                        }
                    }
                    HStack { // Strike
                        Text("S")
                            .foregroundStyle(.white)
                            .font(.headline)
                        ForEach(0..<2) { index in
                            Circle()
                                .foregroundStyle(index < gameModel.strikes ? .yellow : .gray)
                                .frame(width: 30, height: 30)
                        }
                    }
                    HStack { // Out
                        Text("O")
                            .foregroundStyle(.white)
                            .font(.headline)
                        ForEach(0..<2) { index in
                            Circle()
                                .foregroundStyle(index < gameModel.outs ? .red : .gray)
                                .frame(width: 30, height: 30)
                        }
                    }
                }
                Rectangle()
                    .foregroundStyle(.white)
                    .frame(width: 1, height: 100)
                    .offset(x: 10)
                VStack {
                    Text("Opponent")
                        .foregroundStyle(.white)
                        .bold()
                    Text("\(gameModel.score)") // 得分數
                        .foregroundStyle(.white)
                        .font(.title)
                        .bold()
                    Text("Score")
                        .foregroundStyle(.white)
                        .font(.headline)
                }
                .offset(x: 10)
            }
        }
    }
}

#Preview {
    ScoreboardView(gameModel: GameModel())
        .environmentObject(GameModel())
}
