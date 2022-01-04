//
//  quizappModel.swift
//  quizapp
//
//  Created by Lennard Geeraert on 02/01/2022.
//

import Foundation
import SwiftUI

struct quizappModel
{
    var questions: Array<Question>
    
    init()
    {
        questions = []
    }
}

struct Question: Codable, Identifiable
{
    var id: Int
    var category: String
    var type: String
    var question: String
    var correctAnswer: String
    var incorrectAnswers: Array<String>
    
    init(id: Int, category: String, type: String, question: String, correctAnswer: String, incorrectAnswers: Array<String>) {
        self.id = id
        self.category = category
        self.type = type
        self.question = question
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
    }
}
         














//        verlopig hard gecodeerd
//        let questionAnswerPair = QuestionAnswerPair(category: "Film", type: "multiple", difficulty: "easy", question: "Who is 007?", correct_answer: "James", incorrect_answers: ["Tom", "Koen", "Bert"], id: randomNr * 123)
//       questionAnswerPairs.append(questionAnswerPair)
//
//        let questionAnswerPair2 = QuestionAnswerPair(category: "Film", type: "multiple", difficulty: "easy", question: "Say hello to my little friend", correct_answer: "SacreFace", incorrect_answers: ["James Bond", "John Wick", "Matrix"], id: randomNr * 123 + 1)
//       questionAnswerPairs.append(questionAnswerPair2)
//
//        let questionAnswerPair3 = QuestionAnswerPair(category: "Film", type: "multiple", difficulty: "easy", question: "Gozilla", correct_answer: "Texas", incorrect_answers: ["San Francisco", "New York", "California"], id: randomNr * 123 + 2)
//       questionAnswerPairs.append(questionAnswerPair3)



//struct QuestionAnswerPair
//{
//    var category: String
//    var type: String
//    var difficulty: String
//    var question: String
//    var correct_answer: String
//    var incorrect_answers: Array<String>
//    let id: Int
//}

//struct Response: Codable
//{
//    var results: Array<MyResult>
//    var response_code: Int
//}
