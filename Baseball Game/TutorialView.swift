//
//  TutorialView.swift
//  Baseball Game
//
//  Created by 翁子翔 on 2024/11/23.
//

import SwiftUI

struct TutorialView: View {
    @Environment(GameModel.self) private var gameModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // 遊戲介紹標題
                Text("遊戲介紹")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                Divider()
                // 遊戲規則
                Text("遊戲規則")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Group {
                    Text("2 好球後再投出好球就會使打者出局")
                    Text("3 壞球後再投出壞球就會使打者得分")
                    Text("2 出局後再出局一人就會結束遊戲")
                }
                .padding(.horizontal)
                Divider()
                Text("玩家可以選擇不同的球種來遊玩")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top)
                
                SelectBallView()
                // 球種介紹
                VStack(alignment: .leading, spacing: 8) {
                    Group {
                        Text("直球 : ")
                            .font(.headline)
                        Text("移動路徑是直線的，移動速度快。")
                        
                        Text("曲球 : ")
                            .font(.headline)
                        Text("球的移動路徑會是彎曲的，像是大拋物線。")
                        
                        Text("滑球 : ")
                            .font(.headline)
                        Text("球的移動路徑會是彎曲的，像是小拋物線。")
                        
                        Text("伸卡球 : ")
                            .font(.headline)
                        Text("伸卡球的路徑會從上往下彎曲，類似空中下墜的效果。")
                    }
                    .padding(.horizontal)
                }
                Divider()
                // 投球條介紹
                Text("接著透過右邊的投球條來選擇丟出的球")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top)
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Group {
                            Text("綠色 ： 會投出好球，也就是 Ball ，在左上的計分板B的地方會亮黃燈")
                            Divider()
                            Text("黃色 ： 會投出壞球，也就是 Strike ，在左上的計分板S的地方會亮綠燈")
                            Divider()
                            Text("紅色 ： 會投出讓投手很好打的球，會讓打者得分")
                        }
                        .padding(.horizontal)
                    }
                    Divider()
                        .frame(height: 300)
                    BarView()
                        .scaleEffect(0.5)
                }
                .offset(y:-200)
                .padding(.bottom, -350)
                Divider()
                // 計分板介紹
                Text("計分板")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                
                ScoreboardView(gameModel: gameModel)
                
                Group {
                    Text("B : Ball (代表壞球) 總共有 3 個燈")
                    Text("S : Strike (代表好球) 總共有 2 個燈")
                    Text("O : Out (代表出局) 總共有 2 個燈")
                    Text("右邊會有 Opponent 的 Score ")
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .shadow(radius: 10)
    }
}

#Preview {
    TutorialView()
        .environment(GameModel())
}
