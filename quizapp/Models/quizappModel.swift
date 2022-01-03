//
//  quizappModel.swift
//  quizapp
//
//  Created by Lennard Geeraert on 02/01/2022.
//

import Foundation
//import DeveloperToolsSupport
import SwiftUI

struct quizappModel {
    private(set) var questionAnswerPairs: Array<QuestionAnswerPair>
    private(set) var nrOfRightAnswers: Int
    private(set) var nrOfWrongAnswers: Int
//    private(set) var dataResponse: Response
//    private(set) var dataMyResults: Array<MyResult>

    mutating func choose(_ answer: Answer){
        if let correctAnswerIndex = questionAnswerPairs[0].answers.firstIndex(where: { $0.isCorrect == true }) {
            questionAnswerPairs[0].answers[correctAnswerIndex].backgroundColor = "green"
            if let chosenAnswerIndex = questionAnswerPairs[0].answers.firstIndex(where: { $0.id == answer.id}) {
                if(questionAnswerPairs[0].answers[correctAnswerIndex].content == questionAnswerPairs[0].answers[chosenAnswerIndex].content) {
                    nrOfRightAnswers += 1
                }
                else {
                    nrOfWrongAnswers += 1
                }
            }
        }
    }
    
    init(numberOfQuestionAnswerPairs: Int) {
        questionAnswerPairs = []
        nrOfRightAnswers = 0
        nrOfWrongAnswers = 0
        
//        verlopig hard gecodeerd
//        later een betere id maken, die zeker niet dezelfde kan zijn
       let testAnswers = [Answer(isCorrect: false, content: "1956", backgroundColor: "white", id: numberOfQuestionAnswerPairs * 2), Answer(isCorrect: true, content: "2001", backgroundColor: "white", id: numberOfQuestionAnswerPairs * 2 + 1), Answer(isCorrect: false, content: "1999", backgroundColor: "white", id: numberOfQuestionAnswerPairs * 2 + 2), Answer(isCorrect: false, content: "1901", backgroundColor: "white", id: numberOfQuestionAnswerPairs * 2 + 3)]
       let question = Question(content: "In welk jaar is Lisa geboren?", id: numberOfQuestionAnswerPairs * 9 + 1)
       let questionAnswerPair = QuestionAnswerPair(theme: "Lisa", answers: testAnswers, question: question)
       questionAnswerPairs.append(questionAnswerPair)
        let testAnswers2 = [Answer(isCorrect: true, content: "komkommer", backgroundColor: "white", id: numberOfQuestionAnswerPairs * 123), Answer(isCorrect: false, content: "wortel", backgroundColor: "white", id: numberOfQuestionAnswerPairs * 123 + 1), Answer(isCorrect: false, content: "tomaat", backgroundColor: "white", id: numberOfQuestionAnswerPairs * 123 + 2), Answer(isCorrect: false, content: "kool", backgroundColor: "white", id: numberOfQuestionAnswerPairs * 123 + 3)]
        let question2 = Question(content: "Wat is een groene groente?", id: numberOfQuestionAnswerPairs * 11 + 2)
        let questionAnswerPair2 = QuestionAnswerPair(theme: "groenten", answers: testAnswers2, question: question2)
        questionAnswerPairs.append(questionAnswerPair2)
    }
    
    struct QuestionAnswerPair {
        let theme: String
        var answers: Array<Answer>
        let question: Question
        
        func getAnswers() -> Array<Answer> {
            return answers
        }
    }
    struct Answer: Identifiable {
        let isCorrect: Bool
        let content: String
        var backgroundColor: String
        let id: Int
    }
    struct Question: Identifiable {
        let content: String
        let id: Int
    }
    
//    func transform(data: [MyResult]) -> Void {
//        data.forEach { dataObject in
//            <#code#>
//        }
//    }
}
         
