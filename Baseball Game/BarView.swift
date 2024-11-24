//
//  BarView.swift
//  Baseball Game
//
//  Created by 翁子翔 on 2024/11/22.
//

import SwiftUI

struct BarView: View {
    @Environment(GameModel.self) private var gameModel
    // 顏色區域
    private let redHeight1: CGFloat = 192.5
    private let redHeight2: CGFloat = 192.5
    private let yellowHeight1: CGFloat = 55
    private let yellowHeight2: CGFloat = 55
    private let greenHeight: CGFloat = 55
    private let maxHeight: CGFloat
    
    @State private var linePosition: CGFloat = 0 // 線位置
    @State private var isPaused: Bool = false // 暫停或播放動畫
    @State private var movingUp: Bool = true // 方向控制T上F下
    @State private var animationTimer: Timer? // 動畫計時器
    
    static var timerSpeed: Double = 1.0 // 控制棒子的速度
    
    init() {
        self.maxHeight = redHeight1 + yellowHeight1 + greenHeight + yellowHeight2 + redHeight2
    }
    
    var body: some View {
        VStack {
            ZStack {
                // 顏色區域
                VStack(spacing: 0) {
                    Color.red.frame(height: redHeight1)
                    Color.yellow.frame(height: yellowHeight1)
                    Color.green.frame(height: greenHeight)
                    Color.yellow.frame(height: yellowHeight2)
                    Color.red.frame(height: redHeight2)
                }
                .frame(width: 50, height: maxHeight)
                .border(.black, width: 7)
                .cornerRadius(20)
                .shadow(radius: 10)
                // 投球棒
                Rectangle()
                    .foregroundStyle(.white)
                    .frame(width: 50, height: 10)
                    .position(x: 500, y: linePosition)
            }
            .frame(height: maxHeight)
            .padding(.top, 50)
            
            // 進行投球或繼續
            Button(action: toggleAnimation) {
                Text(isPaused ? "繼續" : "投球")
                    .font(.title)
                    .padding()
                    .background(Circle().fill(.blue))
                    .foregroundColor(.white)
            }
            .shadow(radius: 10)
        }
        .onAppear {
            startAnimation()
        }
    }
    
    func startAnimation() { // 棒上下移動
        linePosition = maxHeight
        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.005 / BarView.timerSpeed, repeats: true) { _ in
            if !isPaused {
                if movingUp {
                    linePosition -= 1
                    if linePosition <= 0 {
                        movingUp = false
                    }
                } else {
                    linePosition += 1
                    if linePosition >= maxHeight {
                        movingUp = true
                    }
                }
            }
        }
    }
    
    func startPitching() { // 根據顏色和球種
        switch gameModel.selectedBall {
        case .fastBall:
            gameModel.moveBallToTargetWithPath(target: gameModel.ballZone, path: .straight)
        case .curveBall:
            gameModel.moveBallToTargetWithPath(target: gameModel.ballZone, path: .curve)
        case .sliderBall:
            gameModel.moveBallToTargetWithPath(target: gameModel.ballZone, path: .slider)
        case .sinkerBall:
            gameModel.moveBallToTargetWithPath(target: gameModel.ballZone, path: .sinker)
        }
    }
    
    func toggleAnimation() { // 顏色區域判斷
        if !isPaused {
            if linePosition <= redHeight1 || (linePosition >= redHeight1 + yellowHeight1 + greenHeight + yellowHeight2 && linePosition < maxHeight) {
                // 紅色區域（擊出）
                gameModel.ballZone = .red
                gameModel.score += 1
                gameModel.balls = 0
                gameModel.strikes = 0
            } else if linePosition <= redHeight1 + yellowHeight1 + greenHeight && linePosition > redHeight1 + yellowHeight1 {
                // 綠色區域（好球）
                gameModel.ballZone = .green
                if gameModel.strikes < 3 {
                    gameModel.strikes += 1
                }
                if gameModel.strikes == 3 {
                    // 好球滿3時出局
                    gameModel.outs += 1
                    if gameModel.outs >= 3 {
                        // 遊戲結束
                        gameModel.isEndGame = true
                    } else {
                        // 清空球數
                        gameModel.balls = 0
                        gameModel.strikes = 0
                    }
                }
            } else {
                // 黃色區域（壞球）
                gameModel.ballZone = .yellow
                if gameModel.balls < 3 {
                    gameModel.balls += 1
                } else if gameModel.balls == 3 {
                    // 四壞球後進行加分並清零
                    gameModel.score += 1
                    gameModel.strikes = 0
                    gameModel.balls = 0
                }
            }
            startPitching()
        }
        isPaused.toggle()
        if !isPaused {
            startAnimation()
            gameModel.ballPosition = CGPoint(x: 20, y: 160)
            gameModel.ballScale = 1.0
            gameModel.peopleRotate = .degrees(0)
            gameModel.peoplePosition = CGPoint(x: 100, y: -60)
        } else {
            animationTimer?.invalidate()
            animationTimer = nil
        }
    }
}

#Preview {
    BarView()
        .environment(GameModel())
}
