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
        // Start game
        playGameStartSound()
        displayQuestion()
        rightOrWrongField.isHidden = true
        self.answers = [self.answerOne, self.answerTwo, self.answerThree, self.answerFour]
        //secondsLeft.text = "You have \(lightningCounter(seconds: 5)) seconds."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func displayQuestion() {
        let randomNumber = listOfQuestion().randomNumber()
        var questionDictionary = listOfQuestion().questions[randomNumber]
        
        questionField.text = questionDictionary["Question"]
        playAgainButton.isHidden = true
        
        answerOne.setTitle(questionDictionary["Answer1"], for: .normal)
        answerTwo.setTitle(questionDictionary["Answer2"], for: .normal)
        answerThree.setTitle(questionDictionary["Answer3"], for: .normal)
        answerFour.setTitle(questionDictionary["Answer4"], for: .normal)
        
        questionsAsked += 1
        
     //   lightningCounter(seconds: 15)
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
        let selectedQuestionDict = listOfQuestion().questions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict["correctAnswer"]
        let selectedAnswer = sender
        
        for answer in answers where selectedAnswer === answer && answer.currentTitle == correctAnswer {
            correctQuestions += 1
            rightOrWrongField.text = "Correct!"
            rightOrWrongField.textColor = UIColor.green
        }
        for answer in answers where selectedAnswer === answer && answer.currentTitle != correctAnswer {
            rightOrWrongField.text = "Sorry, wrong answer!"
            rightOrWrongField.textColor = UIColor.orange
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
        } else {
            // Continue game
            displayQuestion()
            for answer in answers {
                answer.tintColor = UIColor.white.withAlphaComponent(1)
            }
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        for answer in answers {
            answer.isHidden = false
        }
        questionsAsked = 0
        correctQuestions = 0
        listOfQuestion().clearArrayList()
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
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
    
    @objc func lightningCounter(seconds: Int) {
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
        questionsAsked += 1
    }
    
    @objc func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    @objc func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

