//
//  ContentView.swift
//  Baseball Game
//
//  Created by 翁子翔 on 2024/11/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(GameModel.self) private var gameModel
    @State private var showTutorial = false
    @State private var showSetting = false
    
    var body: some View {
        if gameModel.isEndGame { // 結束畫面
            EndView()
        } else {
            ZStack {
                BackgroundView() // 背景
                Image(systemName: "figure.stand") // 投手
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 300)
                    .offset(x:-40, y:140)
                Image(systemName: "figure.baseball") // 打擊者
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 300)
                    .offset(x: gameModel.peoplePosition.x, y: gameModel.peoplePosition.y)
                    .rotationEffect(gameModel.peopleRotate)
                Rectangle() // 投球區域
                    .foregroundStyle(.white)
                    .frame(width: 80, height: 100)
                    .offset(y:-60)
                    .opacity(0.7)
                Image(systemName: "baseball.fill") // 棒球
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .scaleEffect(gameModel.ballScale)
                    .offset(x: gameModel.ballPosition.x, y: gameModel.ballPosition.y)
                
                BarView() // 遊戲棒
                    .offset(x: 150, y: -50)
                
                ScoreboardView(gameModel: gameModel) // 計分板
                    .offset(x: -50, y: -280)
                
                SelectBallView() // 選擇球種
                    .frame(width: 380)
                    .offset(y: 360)
                
                Button { // 教學頁面
                    showTutorial.toggle()
                } label: {
                    Image(systemName: "questionmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.black)
                        .frame(width: 50, height: 50)
                        .shadow(radius: 10)
                }
                .offset(x: -150, y: -380)
                .sheet(isPresented: $showTutorial) {
                    TutorialView()
                }
                
                Button { // 設定頁面
                    showSetting.toggle()
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.black)
                        .frame(width: 50, height: 50)
                        .shadow(radius: 10)
                }
                .offset(x: 150, y: -380)
                .sheet(isPresented: $showSetting) {
                    SettingView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(GameModel())
}
