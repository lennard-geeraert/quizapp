//
//  quizappModel.swift
//  quizapp
//
//  Created by Lennard Geeraert on 02/01/2022.
//

import Foundation
//import DeveloperToolsSupport
import SwiftUI

struct quizappModel
{
    private(set) var questionAnswerPairs: Array<QuestionAnswerPair>
    private(set) var nrOfRightAnswers: Int
    private(set) var nrOfWrongAnswers: Int

    mutating func choose(_ id: Int, answer: String)
    {
        if let correctQAPairIndex = questionAnswerPairs.firstIndex(where: { $0.id == id })
        {
            if (questionAnswerPairs[correctQAPairIndex].correct_answer == answer){
                nrOfRightAnswers += 1
            }
            else {
                nrOfWrongAnswers += 1
            }
        }
    }
    
    init()
    {
        questionAnswerPairs = []
        nrOfRightAnswers = 0
        nrOfWrongAnswers = 0
        let randomNr = 2
        
//        verlopig hard gecodeerd
        let questionAnswerPair = QuestionAnswerPair(category: "Film", type: "multiple", difficulty: "easy", question: "Who is 007?", correct_answer: "James", incorrect_answers: ["Tom", "Koen", "Bert"], id: randomNr * 123)
       questionAnswerPairs.append(questionAnswerPair)
        
        let questionAnswerPair2 = QuestionAnswerPair(category: "Film", type: "multiple", difficulty: "easy", question: "Say hello to my little friend", correct_answer: "SacreFace", incorrect_answers: ["James Bond", "John Wick", "Matrix"], id: randomNr * 123 + 1)
       questionAnswerPairs.append(questionAnswerPair2)
        
        let questionAnswerPair3 = QuestionAnswerPair(category: "Film", type: "multiple", difficulty: "easy", question: "Gozilla", correct_answer: "Texas", incorrect_answers: ["San Francisco", "New York", "California"], id: randomNr * 123 + 2)
       questionAnswerPairs.append(questionAnswerPair3)
    }
    
    struct QuestionAnswerPair
    {
        var category: String
        var type: String
        var difficulty: String
        var question: String
        var correct_answer: String
        var incorrect_answers: Array<String>
        let id: Int
    }
    
//    func transform(data: [MyResult]) -> Void {
//        data.forEach { dataObject in
//            <#code#>
//        }
//    }
}
         
