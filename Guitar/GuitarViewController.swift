//
//  GuitarViewController.swift
//  Guitar
//
//  Created by Apple on 2022/3/1.
//

import UIKit
import CoreMotion

class GuitarViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var guitarImageView: UIImageView!
    
    fileprivate var distancePerTime = 10.0
    
    fileprivate lazy var motionManager: CMMotionManager = {
        let object = CMMotionManager()
        object.accelerometerUpdateInterval = 0.01
        return object
    }()
    
    @IBOutlet weak var button02: MusicButton!
    @IBOutlet weak var button03: MusicButton!
    @IBOutlet weak var button1: MusicButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0xcc / 255.0, green: 0xc3 / 255.0, blue: 0x8b / 255.0, alpha: 1.0)
        startMotion()
        
        // TODO: 删除背景色
        button1.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        button02.backgroundColor = UIColor.red.withAlphaComponent(0.05)
        button03.backgroundColor = UIColor.orange.withAlphaComponent(0.05)
    }
    
    func startMotion() {
        if motionManager.isAccelerometerAvailable && !motionManager.isAccelerometerActive {
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { data, error in
                guard let result = data else {
                    return
                }
                if fabs(result.acceleration.y) < 0.15 {
                    return
                }
                var offset = self.scrollView.contentOffset
                let distanceY = self.distancePerTime * CGFloat(result.acceleration.y)
                offset.y -= distanceY
                if offset.y < 0 {
                    offset.y = 0
                }
                if offset.y > self.scrollView.contentSize.height - self.scrollView.frame.size.height {
                    offset.y = self.scrollView.contentSize.height - self.scrollView.frame.size.height
                }
                self.scrollView.contentOffset = CGPoint(x: offset.x, y: offset.y)
            }
        }
    }
    
    @IBAction func button1Down(_ sender: MusicButton) {
        sender.startPlayMusic(pathName: "GuitarE.mp3")
    }
    
    @IBAction func button1TouchOutSide(_ sender: MusicButton) {
        sender.stopPlayMusic()
    }

    @IBAction func button2Down(_ sender: MusicButton) {
        sender.startPlayMusic(pathName: "GuitarG.mp3")
    }
    
    @IBAction func button2TouchOutSide(_ sender: MusicButton) {
        sender.stopPlayMusic()
    }

    @IBAction func button3Down(_ sender: MusicButton) {
        sender.startPlayMusic(pathName: "GuitarA.mp3")
    }
    
    @IBAction func button4TouchOutSide(_ sender: MusicButton) {
        sender.stopPlayMusic()
    }

}

