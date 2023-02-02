//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

// done

class ViewController: UIViewController {
    var player: AVAudioPlayer!
    
    @IBOutlet weak var timerProgress: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes = ["Soft": 3, "Medium": 420, "Hard":  720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        timerProgress.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        if let time = eggTimes[hardness] {
            totalTime = time
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateCounter() {
        if secondsPassed < totalTime {
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            secondsPassed += 1
            print(Float(percentageProgress))
            timerProgress.progress = Float(percentageProgress)
            
            
            
        } else if secondsPassed == totalTime {
            timer.invalidate()
            titleLabel.text = "DONE!"
            timerProgress.progress = 1.0
            playSound()
            
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }

}
