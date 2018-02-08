//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    @objc let questionsPerRound = 4
    @objc var questionsAsked = 0
    @objc var correctQuestions = 0
    @objc var gameSound: SystemSoundID = 0
    @objc var yesSound: SystemSoundID = 1
    @objc var noSound: SystemSoundID = 2
    
    // Lightning Timer Variables
    
    @objc var lightningTimer = Timer()
    @objc var seconds = 15
    @objc var timerRunning = false
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var rightOrWrongField: UILabel!
    @IBOutlet weak var answerOne: UIButton!
    @IBOutlet weak var answerTwo: UIButton!
    @IBOutlet weak var answerThree: UIButton!
    @IBOutlet weak var answerFour: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    var answers: [UIButton] = [UIButton]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        loadYesSound()
        loadNoSound()
        
        // Start game
        playGameStartSound()
        displayQuestion()
        
        rightOrWrongField.isHidden = true
        self.answers = [self.answerOne, self.answerTwo, self.answerThree, self.answerFour]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func randomNumber() -> Int {
        
        while previousRandomNumber == indexOfSelectedQuestion || randomNumberArray.contains(indexOfSelectedQuestion) {
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: listOfQuestions.count)
        }
        randomNumberArray.append(indexOfSelectedQuestion)
        previousRandomNumber = indexOfSelectedQuestion
        
        return indexOfSelectedQuestion
    }
    
    @objc func clearArrayList() {
        randomNumberArray = []
    }
    
    @objc func displayQuestion() {
        
        let randomNumber = self.randomNumber()
        let questionDictionary = listOfQuestions[randomNumber]
        
        questionField.text = questionDictionary.question
        playAgainButton.isHidden = true
        
        answerOne.setTitle(questionDictionary.answer1, for: .normal)
        answerTwo.setTitle(questionDictionary.answer2, for: .normal)
        answerThree.setTitle(questionDictionary.answer3, for: .normal)
        answerFour.setTitle(questionDictionary.answer4, for: .normal)
        
        lightningTimer.invalidate()
        resetTimer()
        startTimer()
    }
    
    @objc func displayScore() {
        
        // Hide the answer buttons
        for answer in answers {
            answer.isHidden = true
        }
    
        // Display "Play again" button
        playAgainButton.isHidden = false
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        timerRunning = false
        let selectedQuestionDict = listOfQuestions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.correctAnswer
        let selectedAnswer = sender
        
        for answer in answers where selectedAnswer === answer && answer.currentTitle == correctAnswer {
            correctQuestions += 1
            questionsAsked += 1
            rightOrWrongField.text = "Correct!"
            rightOrWrongField.textColor = UIColor.green
            playYesSound()
            timerLabel.isHidden = true
            resetTimer()
        }
        for answer in answers where selectedAnswer === answer && answer.currentTitle != correctAnswer {
            rightOrWrongField.text = "Sorry, wrong answer!"
            rightOrWrongField.textColor = UIColor.orange
            questionsAsked += 1
            playNoSound()
            timerLabel.isHidden = true
        }
        
        rightOrWrongField.isHidden = false
        
        for answer in answers {
            answer.tintColor = UIColor.white.withAlphaComponent(0.3)
        }
        
        if selectedAnswer.currentTitle == correctAnswer {
            selectedAnswer.tintColor = UIColor.white.withAlphaComponent(1)
            selectedAnswer.tintColor = UIColor.green
        } else {
            selectedAnswer.tintColor = UIColor.white.withAlphaComponent(1)
            selectedAnswer.tintColor = UIColor.orange
            for answer in answers {
                if answer.currentTitle == correctAnswer {
                    answer.tintColor = UIColor.green
                }
            }
        }
        loadNextRoundWithDelay(seconds: 2)
    }
    
    @objc func nextRound() {
        rightOrWrongField.isHidden = true
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
            lightningTimer.invalidate()
            timerLabel.isHidden = true
        } else {
            // Continue game
            displayQuestion()
            for answer in answers {
                answer.tintColor = UIColor.white.withAlphaComponent(1)
            }
            timerLabel.isHidden = false
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        for answer in answers {
            answer.isHidden = false
        }
        questionsAsked = 0
        correctQuestions = 0
        clearArrayList()
        nextRound()
    }
    
    // MARK: Helper Methods
    
    // Timer
    
    @objc func startTimer() {
        timerLabel.textColor = UIColor.green
        timerLabel.isHidden = false
        if timerRunning == false {
            lightningTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countdownTimer), userInfo: nil, repeats: true)
            timerRunning = true
        }
    }
    
    @objc func countdownTimer() {
        seconds -= 1 // countdown by 1 second
        timerLabel.text = "You've got: \(seconds) seconds to answer."
        
        if seconds >= 11 {
            timerLabel.textColor = UIColor.green
        } else if seconds < 11 && seconds > 5 {
            timerLabel.textColor = UIColor.yellow
        } else {
            timerLabel.textColor = UIColor.red
        }
        
        if seconds == 0 {
            lightningTimer.invalidate()
            questionsAsked += 1
            playNoSound()
            self.loadNextRoundWithDelay(seconds: 2)
            timerLabel.text = "Sorry, time ran out!"
        }
    }
    
    @objc func resetTimer() {
        seconds = 15
        timerLabel.text = "You've got: \(seconds) seconds to answer."
        timerRunning = false
    }

    // Load next round with delay
    
    @objc func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }

    @objc func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    @objc func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    @objc func loadYesSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "YesSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &yesSound)
    }
    
    @objc func playYesSound() {
        AudioServicesPlaySystemSound(yesSound)
    }
    
    @objc func loadNoSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "NoSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &noSound)
    }
    
    @objc func playNoSound() {
        AudioServicesPlaySystemSound(noSound)
    }
}

