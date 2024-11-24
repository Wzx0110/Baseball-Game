//
//  SettingView.swift
//  Baseball Game
//
//  Created by 翁子翔 on 2024/11/23.
//

import SwiftUI
import AVFoundation

struct SettingView: View {
    @EnvironmentObject var gameModel: GameModel
    
    var body: some View {
        VStack {
            Text("設定")
                .font(.title)
                .bold()
            Divider()
            // 音樂開關
            Toggle("背景音樂", isOn: $gameModel.isMusicOn)
                .padding()
                .font(.headline)
                .onChange(of: gameModel.isMusicOn) { newValue in
                    if newValue {
                        AVPlayer.play()
                    } else {
                        AVPlayer.pause()
                    }
                }
            // 音量調整滑桿
            HStack {
                Image(systemName: "speaker.fill")
                Slider(value: $gameModel.volume, in: 0...1, step: 0.01)
                    .onChange(of: gameModel.volume) { newVolume in
                        AVPlayer.setVolume(newVolume)
                    }
                Image(systemName: "speaker.wave.3.fill")
            }
            .padding()
            Text("音量: \(Int(gameModel.volume * 100))%")
            Divider()
            // 投球速度控制滑桿
            Text("投球難度")
                .font(.headline)
                .offset(x:-130)
                .padding(.top)
            
            Slider(value: $gameModel.speed, in: 1...11.0, step: 5.0) // 設置速度範圍 1（簡單）到 3.0（難）
                .padding()
                .onChange(of: gameModel.speed) { newSpeed in
                    // 更新 BarView 中的計時器速度
                    BarView.timerSpeed = newSpeed
                }
            HStack {
                Text("簡單")
                Spacer()
                Text("普通")
                Spacer()
                Text("困難")
            }
            .padding(.horizontal)
            Divider()
        }
        .shadow(radius: 10) // 陰影
        .padding()
        Spacer()
    }
}

#Preview {
    SettingView()
        .environment(GameModel())
}
