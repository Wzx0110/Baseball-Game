//
//  GameModel.swift
//  Baseball Game
//
//  Created by 翁子翔 on 2024/11/22.
//

import SwiftUI

enum BallZone { // 顏色區域
    case red, green, yellow
}

enum BallType { // 球種
    case fastBall, curveBall, sliderBall, sinkerBall
}

enum BallPath { // 球路線
    case straight, curve, slider, sinker
}

@Observable
class GameModel : ObservableObject{
    var score: Int = 0 // 得分
    var balls: Int = 0 // 好球數
    var strikes: Int = 0 // 壞球數
    var outs: Int = 0 // 出局數
    var ballZone: BallZone = .green // 預設為綠色區域
    var selectedBall: BallType = .fastBall // 當前選擇的球種
    var ballPosition: CGPoint = CGPoint(x: 20, y: 160) // 棒球起始位置
    var ballScale: CGFloat = 1.0 // 球初始大小
    var peopleRotate: Angle = .degrees(0) //打擊者動作
    var peoplePosition: CGPoint = CGPoint(x: 100, y: -60) // 打擊者初始位置
    
    var isMusicOn: Bool = true // 音樂開關
    var volume: Float = 1.0 // 音量大小
    var speed: Double = 1.0 // 投球速度
    var isEndGame: Bool = false
    
    func getTargetPosition(for target: BallZone) -> CGPoint { // 球終點
        switch target {
        case .red:
            return CGPoint(x: 0, y: -60)
        case .green:
            let randomX = CGFloat.random(in: -30...30)
            let randomY = CGFloat.random(in: -100 ... -20)
            return CGPoint(x: randomX, y: randomY)
        case .yellow:
            var randomX: CGFloat
            var randomY: CGFloat
            repeat {
                randomX = CGFloat.random(in: -50...50)
            } while randomX > -30 && randomX < 30
            repeat {
                randomY = CGFloat.random(in: -130...10)
            } while randomY > -100 && randomY < -20
            return CGPoint(x: randomX, y: randomY)
        }
    }
    
    func moveBallToTargetWithPath(target: BallZone, path: BallPath) { // 球路徑
        let targetPosition = getTargetPosition(for: target)
        
        switch path {
        case .straight:
            withAnimation(.easeIn(duration: 0.4)) {
                ballPosition = targetPosition
                ballScale = 0.5
            }
        case .curve:
            let controlPoint = CGPoint(x: ballPosition.x + 30, y: ballPosition.y - 40)
            withAnimation(.easeInOut(duration: 0.5)) {
                ballPosition = controlPoint
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeInOut(duration: 0.6)) {
                    self.ballPosition = targetPosition
                    self.ballScale = 0.5
                }
            }
        case .slider:
            let controlPoint = CGPoint(x: ballPosition.x + 10, y: ballPosition.y - 30)
            withAnimation(.easeInOut(duration: 0.5)) {
                ballPosition = controlPoint
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeInOut(duration: 0.4)) {
                    self.ballPosition = targetPosition
                    self.ballScale = 0.5
                }
            }
        case .sinker:
            let controlPoint = CGPoint(x: ballPosition.x - 20, y: ballPosition.y - 280)
            withAnimation(.easeInOut(duration: 0.4)) {
                ballPosition = controlPoint
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.easeInOut(duration: 0.4)) {
                    self.ballPosition = targetPosition
                    self.ballScale = 0.5
                }
            }
        }
        
        if ballZone == .red {
            withAnimation(.easeInOut(duration: 0.4)) {
                // 打擊者動作
                peoplePosition = CGPoint(x: 70, y: 0)
                peopleRotate = .degrees(-20)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                let controlPoint = CGPoint(x: self.ballPosition.x - 180, y: self.ballPosition.y + 150)
                withAnimation(.easeInOut(duration: 0.4)) {
                    self.ballPosition = controlPoint
                    self.ballScale = 2.0
                }
            }
        }
    }
}
