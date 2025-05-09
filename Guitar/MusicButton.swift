//
//  MusicButton.swift
//  Guitar
//
//  Created by Apple on 2022/3/4.
//

import Foundation
import UIKit
import AudioToolbox

class MusicButton: UIButton {
    
    private var systemSoundID: SystemSoundID = 0
    
    private var timer: Timer!
    
    func startPlayMusic(pathName: String) {
        guard let url = Bundle.main.url(forResource: pathName, withExtension: nil) else {
            systemSoundID = 0
            return
        }
        AudioServicesCreateSystemSoundID(url as CFURL, &systemSoundID)
        
        startTimer()
    }
    
    func stopPlayMusic() {
        timer?.invalidate()
        timer = nil
    }
    
    private func startTimer() {
        if systemSoundID == 0 {
            return
        }
        stopTimer()
        AudioServicesPlaySystemSound(self.systemSoundID)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            AudioServicesPlaySystemSound(self.systemSoundID)
        })
        RunLoop.current.add(timer, forMode: .common)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
