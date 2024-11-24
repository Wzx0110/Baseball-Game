//
//  SelectBallView.swift
//  Baseball Game
//
//  Created by 翁子翔 on 2024/11/23.
//

import SwiftUI

struct SelectBallView: View {
    @EnvironmentObject var gameModel: GameModel
    
    var body: some View {
        VStack {
            Picker("球種", selection: $gameModel.selectedBall) {
                Text("直球").tag(BallType.fastBall)
                Text("曲球").tag(BallType.curveBall)
                Text("滑球").tag(BallType.sliderBall)
                Text("指叉球").tag(BallType.sinkerBall)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .background(.white)
        .shadow(radius: 10)
    }
}

#Preview {
    SelectBallView()
        .environmentObject(GameModel())
}


