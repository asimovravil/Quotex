//
//  QuizBrain.swift
//  Quotex
//
//  Created by Ravil on 19.10.2023.
//

import Foundation

struct QuizBrain {
    
    var questionNumber = 0
    var score = 0
    
    let quiz = [
        Question(q: "What is a 'bull market'?", a: ["Rising market", "Declining market", "Stable market", "Volatile market"], correctAnswer: "Rising market"),
        Question(q: "What is a 'bear market'?", a: ["Rising market", "Declining market", "Stable market", "Volatile market"], correctAnswer: "Declining market"),
        Question(q: "Who is often associated with the phrase 'When the bulls run, you should run too'?", a: ["Warren Buffett", "George Soros", "Carl Icahn", "Peter Lynch"], correctAnswer: "Warren Buffett"),
        Question(q: "What is a 'correction' in the financial market?", a: ["A short-term decline after a bull run", "A rapid increase in the market", "A bearish signal", "A neutral term"], correctAnswer: "A short-term decline after a bull run"),
        Question(q: "What does the 'bull' symbolize in 'bull market'?", a: ["Optimism", "Pessimism", "Stagnation", "Volatility"], correctAnswer: "Optimism"),
        Question(q: "What does the 'bear' represent in 'bear market'?", a: ["Pessimism", "Optimism", "Stagnation", "Volatility"], correctAnswer: "Pessimism"),
        Question(q: "What type of investor believes in rising prices and takes long positions?", a: ["Bullish investor", "Bearish investor", "Neutral investor", "Contrarian investor"], correctAnswer: "Bullish investor"),
        Question(q: "What term describes a rapid drop in market prices resulting in panic selling?", a: ["Crash", "Correction", "Rally", "Stagnation"], correctAnswer: "Crash"),
        Question(q: "Which indicator is used to determine market trends?", a: ["Moving average", "Volume", "RSI", "MACD"], correctAnswer: "Moving average"),
        Question(q: "What animal represents a cautious investor who avoids significant risks?", a: ["Tortoise", "Rabbit", "Hedgehog", "Squirrel"], correctAnswer: "Tortoise")
    ]

    mutating func prevQuestion() {
        if questionNumber > 0 {
            questionNumber -= 1
        }
    }

    func getQuestionText() -> String {
        return quiz[questionNumber].text
    }
    
    //Need a way of fetching the answer choices.
    func getAnswers() -> [String] {
        return quiz[questionNumber].answers
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float(quiz.count)
    }
    
    mutating func getScore() -> Int {
        return score
    }
    
     mutating func nextQuestion() {
        
        if questionNumber + 1 < quiz.count {
            questionNumber += 1
        } else {
            questionNumber = 0
        }
    }
    
    mutating func checkAnswer(userAnswer: String) -> Bool {
        //Need to change answer to rightAnswer here.
        if userAnswer == quiz[questionNumber].rightAnswer {
            score += 1
            return true
        } else {
            return false
        }
    }
}
