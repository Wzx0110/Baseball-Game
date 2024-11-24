//
//  BackgroundView.swift
//  Baseball Game
//
//  Created by 翁子翔 on 2024/11/21.
//

import SwiftUI

struct Trapezoid: Shape {
    var topWidth: CGFloat
    var bottomWidth: CGFloat
    var height: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + topWidth, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + bottomWidth, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX - (bottomWidth - topWidth), y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Color.green // 背景
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: -40) { // 座位
                ForEach(0..<4) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<6) { column in
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundStyle((row + column) % 2 == 0 ? .white : .gray)
                                .frame(width: 70, height: 100)
                        }
                    }
                }
            }
            .offset(y:-330)
            ZStack { // 網子
                VStack {
                    ForEach(0..<8) { _ in
                        Rectangle()
                            .foregroundStyle(.black)
                            .frame(width: 400, height: 2)
                            .padding(.vertical, 8)
                    }
                }
                HStack  {
                    ForEach(0..<20) { _ in
                        Rectangle()
                            .foregroundStyle(.black)
                            .frame(width: 2, height: 220)
                            .padding(.horizontal, 8)
                    }
                }
            }
            .offset(y: -340)
            Rectangle() // 牆
                .frame(width: 400, height: 150)
                .foregroundStyle(.blue)
                .offset(y: -160)
            Rectangle() // 牆地連接線
                .frame(width: 400, height: 10)
                .foregroundStyle(.brown)
                .offset(y: -130)
                .shadow(radius: 10)
            Rectangle() // 背景
                .frame(width: 400, height: 100)
                .foregroundStyle(.orange)
                .offset(y: -80)
            Ellipse() // 背景
                .foregroundStyle(.green)
                .frame(width: 1000, height: 150)
                .offset(y: -20)
            Ellipse() // 打擊區
                .foregroundStyle(.orange)
                .frame(width: 400, height: 100)
                .shadow(radius: 5)
            ZStack { // 投手丘
                Ellipse()
                    .foregroundStyle(.orange)
                    .frame(width: 390, height: 150)
                    .shadow(radius: 10)
                Rectangle()
                    .foregroundStyle(.white)
                    .frame(width: 120, height: 10)
                    .offset(y: -30)
            }
            .offset(y: 250)
            Rectangle() // 左跑線
                .foregroundStyle(.white)
                .frame(width: 10, height: 100)
                .rotationEffect(.degrees(70))
                .offset(x:-170, y:20)
            Rectangle() // 右跑線
                .foregroundStyle(.white)
                .frame(width: 10, height: 100)
                .rotationEffect(.degrees(110))
                .offset(x:170, y: 20)
            Trapezoid(topWidth: 80, bottomWidth: 90, height: 0)
                .foregroundStyle(.white)
                .frame(width: 200, height: 40)
                .offset(x:-10, y: 0)
            Trapezoid(topWidth: 70, bottomWidth: 80, height: 0)
                .foregroundStyle(.orange)
                .frame(width: 200, height: 30)
                .offset(x:-5, y: 0)
            Trapezoid(topWidth: 80, bottomWidth: 90, height: 0)
                .foregroundStyle(.white)
                .frame(width: 200, height: 40)
                .offset(x:130, y: 0)
            Trapezoid(topWidth: 70, bottomWidth: 80, height: 0)
                .foregroundStyle(.orange)
                .frame(width: 200, height: 30)
                .offset(x:135, y: 0)
            Trapezoid(topWidth: 10, bottomWidth: 20, height: 0)
                .foregroundStyle(.white)
                .frame(width: 10, height: 10)
        }
    }
}

#Preview {
    BackgroundView()
}
