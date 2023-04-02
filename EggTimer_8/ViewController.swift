//
//  ViewController.swift
//  EggTimer_8
//
//  Created by Лариса Терегулова on 02.04.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titlleLabel: UILabel!
    
    let timeEggs = ["Soft": 5 * 60 , "Medium": 7 * 60, "Hard": 12 * 60]
    var secondPassed = 0
    var totalTime = 0
    var time = Timer()
    var player: AVAudioPlayer!
    
    @IBAction func timerEggs(_ sender: UIButton) {
        time.invalidate()
        let conditionEgg = sender.currentTitle!
        titlleLabel.text = sender.currentTitle
        totalTime = timeEggs[conditionEgg]!
        
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setTimer), userInfo: nil, repeats: true)
    }
    
    @objc func setTimer() {
        if totalTime >= secondPassed {
            let percentageProgress = Float(secondPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
            print(progressBar.progress)
            self.secondPassed += 1
        } else {
            time.invalidate()
            setSound()
            titlleLabel.text = "Done!\n Do you want cook eggs else?"
            secondPassed = 0
        }
    }
    
    func setSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

/*Второй вариант как можно было бы написать таймер
 
 Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
 if self.timeEggs[conditionEgg]! > 0 {
 print ("\(self.timeEggs[conditionEgg]!) seconds")
 self.timeEggs[conditionEgg]! -= 1
 } else {
 Timer.invalidate()
 }}
 */

