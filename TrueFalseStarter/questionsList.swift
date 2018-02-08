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

struct ListOfQuestions {
    let question: String
    let answer1: String
    let answer2: String
    let answer3: String
    let answer4: String
    let correctAnswer: String
    
    init(question: String, answer1: String, answer2: String, answer3: String, answer4: String, correctAnswer: String) {
        self.question = question
        self.answer1 = answer1
        self.answer2 = answer2
        self.answer3 = answer3
        self.answer4 = answer4
        self.correctAnswer = correctAnswer
    }
}

let question01 = ListOfQuestions(
    question: "Which is the only American state to begin with the letter 'p'?",
    answer1: "Pringston",
    answer2: "Pennsylvania",
    answer3: "Puerto Rico",
    answer4: "Panama",
    correctAnswer: "Pennsylvania")

let question02 = ListOfQuestions(
    question: "Name the world's biggest island?",
    answer1: "New Guinea",
    answer2: "Greenland",
    answer3: "Borneo",
    answer4: "Madagascar",
    correctAnswer: "Greenland")

let question03 = ListOfQuestions(
    question: "What is the world's longest river?",
    answer1: "Nile",
    answer2: "Amazon",
    answer3: "Mississippi",
    answer4: "Yukon",
    correctAnswer: "Amazon")

let question04 = ListOfQuestions(
    question: "What is the name the world's largest ocean?",
    answer1: "Pacific",
    answer2: "Indian",
    answer3: "Atlantic",
    answer4: "Arctic",
    correctAnswer: "Pacific")

let question05 = ListOfQuestions(
    question: "What is the diameter of Earth?",
    answer1: "7,000 miles",
    answer2: "11,000 miles",
    answer3: "8,000 miles",
    answer4: "1,000 miles",
    correctAnswer: "8,000 miles")

let question06 = ListOfQuestions(
    question: "Where would you find the world's most ancient forest?",
    answer1: "Sagano Bamboo Forest, Japan",
    answer2: "Black Forest, Germany",
    answer3: "Crooked Forest, Poland",
    answer4: "Daintree Forest, Australia",
    correctAnswer: "Daintree Forest, Australia")

let question07 = ListOfQuestions(
    question: "Which of four British cities have underground rail systems?",
    answer1: "Newcastle",
    answer2: "Southhampton",
    answer3: "Leeds",
    answer4: "Sheffield",
    correctAnswer: "Newcastle")

let question08 = ListOfQuestions(
    question: "What is the capital city of Spain?",
    answer1: "Barcelona",
    answer2: "Valencia",
    answer3: "Madrid",
    answer4: "Zaragoza",
    correctAnswer: "Madrid")

let question09 = ListOfQuestions(
    question: "Which country is Prague in?",
    answer1: "Slovakia",
    answer2: "Poland",
    answer3: "Hungary",
    answer4: "Czech Republic",
    correctAnswer: "Czech Republic")

let question10 = ListOfQuestions(
    question: "Which English town was a forerunner of the Parks Movement and the first city in Europe to have a street tram system?",
    answer1: "London",
    answer2: "Manchester",
    answer3: "Birkenhead",
    answer4: "Oxford",
    correctAnswer: "Birkenhead")

let listOfQuestions = [question01, question02, question03, question04, question05, question06, question07, question08, question09, question10]


