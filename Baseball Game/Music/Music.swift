//
//  Music.swift
//  BaseballGame
//
//  Created by 翁子翔 on 2024/11/23.
//

import AVFoundation

extension AVPlayer {
    
    static var bgQueuePlayer = AVQueuePlayer()
    static var bgPlayerLooper: AVPlayerLooper!
    
    static func setupBgMusic() {
        guard let url = Bundle.main.url(forResource: "game-music-loop-7-145285", withExtension: "mp3") else {
            fatalError("Failed to find sound file.")
        }
        let item = AVPlayerItem(url: url)
        bgPlayerLooper = AVPlayerLooper(player: bgQueuePlayer, templateItem: item)
    }
    
    static func play() {
        bgQueuePlayer.play()
    }
    
    static func pause() {
        bgQueuePlayer.pause()
    }
    
    static func setVolume(_ volume: Float) {
        bgQueuePlayer.volume = volume
    }
}
