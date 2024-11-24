//
//  Baseball_GameApp.swift
//  Baseball Game
//
//  Created by 翁子翔 on 2024/11/21.
//

import SwiftUI
import AVFoundation

@main
struct Baseball_GameApp: App {
    
    init() {
        AVPlayer.setupBgMusic()
        AVPlayer.bgQueuePlayer.play()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(GameModel())
        }
    }
}
