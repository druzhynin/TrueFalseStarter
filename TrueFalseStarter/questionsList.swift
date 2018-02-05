//
//  questionsList.swift
//  TrueFalseStarter
//
//  Created by Kirill Druzhynin on 01.02.2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import GameKit

var indexOfSelectedQuestion: Int = 0
var previousRandomNumber: Int = 0
var randomNumberArray = [Int]()

struct listOfQuestion {
    var questions: [[String : String]] = [
    ["Question": "Which is the only American state to begin with the letter 'p'?",
     "correctAnswer": "Pennsylvania",
     "Answer1": "Pringston", "Answer2": "Pennsylvania", "Answer3": "Portugal", "Answer4": "Panama"],
    ["Question": "Name the world's biggest island?",
     "correctAnswer": "Greenland",
    "Answer1": "New Guinea", "Answer2": "Greenland", "Answer3": "Borneo", "Answer4": "Madagascar"],
    ["Question": "What is the world's longest river?",
     "correctAnswer": "Amazon",
    "Answer1": "Nile", "Answer2": "Amazon", "Answer3": "Mississippi", "Answer4": "Yukon"],
    ["Question": "What is the name the world's largest ocean?",
     "correctAnswer": "Pacific",
    "Answer1": "Pacific", "Answer2": "Indian", "Answer3": "Atlantic", "Answer4": "Arctic"],
    ["Question": "What is the diameter of Earth?",
     "correctAnswer": "8,000 miles",
    "Answer1": "7,000 miles", "Answer2": "11,000 miles", "Answer3": "8,000 miles", "Answer4": "1,000 miles"],
    ["Question": "Where would you find the world's most ancient forest?",
     "correctAnswer": "Daintree Forest, Australia",
    "Answer1": "Sagano Bamboo Forest, Japan", "Answer2": "Black Forest, Germany", "Answer3": "Crooked Forest, Poland", "Answer4": "Daintree Forest, Australia"],
    ["Question": "Which of four British cities have underground rail systems?",
     "correctAnswer": "Newcastle",
    "Answer1": "Newcastle", "Answer2": "Southhampton", "Answer3": "Leeds", "Answer4": "Sheffield"],
    ["Question": "What is the capital city of Spain?",
     "correctAnswer": "Madrid",
    "Answer1": "Barcelona", "Answer2": "Valencia", "Answer3": "Madrid", "Answer4": "Zaragoza"],
    ["Question": "Which country is Prague in?",
     "correctAnswer": "Czech Republic",
    "Answer1": "Slovakia", "Answer2": "Poland", "Answer3": "Hungary", "Answer4": "Czech Republic"],
    ["Question": "Which English town was a forerunner of the Parks Movement and the first city in Europe to have a street tram system?",
     "correctAnswer": "Birkenhead",
    "Answer1": "London", "Answer2": "Manchester", "Answer3": "Birkenhead", "Answer4": "Oxford"]
 
    ]

    func randomNumber() -> Int {
       
        while previousRandomNumber == indexOfSelectedQuestion || randomNumberArray.contains(indexOfSelectedQuestion) {
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: listOfQuestion().questions.count)
            }
        randomNumberArray.append(indexOfSelectedQuestion)
        previousRandomNumber = indexOfSelectedQuestion
        
        return indexOfSelectedQuestion
    }
    
    func clearArrayList() {
        randomNumberArray = []
    }

}


