import UIKit
import GameKit

let timerLabel = ViewController().timerLabel
var lightningTimer = Timer()
var seconds = 15
var timerRunning = false

func lightningCounter(seconds: Int) {
    let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
    let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
        ViewController(
    }
}

func startTimer() {
    timerLabel?.textColor = UIColor.green
    timerLabel?.isHidden = false
    if timerRunning == false {
        lightningTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countdownTimer), userInfo: nil, repeats: true)
        timerRunning = true
    }
}

func countdownTimer() {
    seconds -= 1 // countdown by 1 second
    timerLabel?.text = "You've got: \(seconds) seconds to answer."
    
    if seconds >= 11 {
        timerLabel?.textColor = UIColor.green
    } else if seconds < 11 && seconds > 5 {
        timerLabel?.textColor = UIColor.yellow
    } else {
        timerLabel?.textColor = UIColor.red
    }
    
    if seconds == 0 {
        lightningTimer.invalidate()
        questionsAsked += 1
        playNoSound()
        loadNextRoundWithDelay(seconds: 2)
        timerLabel.text = "Sorry, time ran out!"
    }
}

func resetTimer() {
    seconds = 5
    timerLabel.text = "You've got: \(seconds) seconds to answer."
    timerRunning = false
}
