//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


var player: AVAudioPlayer?

func playSound() {
    guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
        return }
    let url = URL(fileURLWithPath: path)

    do {
        player = try AVAudioPlayer(contentsOf: url)
        player?.play()
        
    } catch let error {
        print(error.localizedDescription)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var progressView: UIProgressView!
    var totalTime = 60
    var passedTime = 0
    var timer = Timer()
    
    let eggTimes:[String:Int] = ["Soft":5, "Medium":7, "Hard": 12]
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        
        
        let hardness = sender.currentTitle!
        titleLabel.text = hardness
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
       }



       @objc func updateCounter() {
           //example functionality
           if passedTime < totalTime {
               print("\(passedTime) seconds")
               passedTime += 1
               progressView.setProgress(Float(passedTime)/Float(totalTime), animated: true)
           }else {
               timer.invalidate()
               playSound()
               titleLabel.text = "Done!"
               
           }
        

        
    }
    
}
  
