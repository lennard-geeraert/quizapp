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
//    private(set) var dataResponse: Response
//    private(set) var dataMyResults: Array<MyResult>

    mutating func choose(_ answer: Answer, index: Int){
        if let correctAnswerIndex = questionAnswerPairs[index].answers.firstIndex(where: { $0.isCorrect == true }) {
            if let chosenAnswerIndex = questionAnswerPairs[index].answers.firstIndex(where: { $0.id == answer.id}) {
                if(questionAnswerPairs[index].answers[correctAnswerIndex].content == questionAnswerPairs[index].answers[chosenAnswerIndex].content) {
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
       let testAnswers = [Answer(isCorrect: false, content: "1956", id: numberOfQuestionAnswerPairs * 2), Answer(isCorrect: true, content: "2001", id: numberOfQuestionAnswerPairs * 2 + 1), Answer(isCorrect: false, content: "1999", id: numberOfQuestionAnswerPairs * 2 + 2), Answer(isCorrect: false, content: "1901", id: numberOfQuestionAnswerPairs * 2 + 3)]
       let question = Question(content: "In welk jaar is Lisa geboren?", id: numberOfQuestionAnswerPairs * 9 + 1)
       let questionAnswerPair = QuestionAnswerPair(theme: "Lisa", answers: testAnswers, question: question)
       questionAnswerPairs.append(questionAnswerPair)
        
        let testAnswers2 = [Answer(isCorrect: true, content: "komkommer", id: numberOfQuestionAnswerPairs * 123), Answer(isCorrect: false, content: "wortel", id: numberOfQuestionAnswerPairs * 123 + 1), Answer(isCorrect: false, content: "tomaat", id: numberOfQuestionAnswerPairs * 123 + 2), Answer(isCorrect: false, content: "kool", id: numberOfQuestionAnswerPairs * 123 + 3)]
        let question2 = Question(content: "Wat is een groene groente?", id: numberOfQuestionAnswerPairs * 11 + 2)
        let questionAnswerPair2 = QuestionAnswerPair(theme: "groenten", answers: testAnswers2, question: question2)
        questionAnswerPairs.append(questionAnswerPair2)
        
        let testAnswers3 = [Answer(isCorrect: true, content: "James", id: numberOfQuestionAnswerPairs * 125), Answer(isCorrect: false, content: "Tom", id: numberOfQuestionAnswerPairs * 125 + 1), Answer(isCorrect: false, content: "Koen", id: numberOfQuestionAnswerPairs * 125 + 2), Answer(isCorrect: false, content: "Kurt", id: numberOfQuestionAnswerPairs * 125 + 3)]
        let question3 = Question(content: "Wie is 007?", id: numberOfQuestionAnswerPairs * 1111 + 2)
        let questionAnswerPair3 = QuestionAnswerPair(theme: "Film", answers: testAnswers3, question: question3)
        questionAnswerPairs.append(questionAnswerPair3)
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
         
