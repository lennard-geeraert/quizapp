//
//  quizappModel.swift
//  quizapp
//
//  Created by Lennard Geeraert on 02/01/2022.
//

import Foundation

struct quizappModel {
    private(set) var theme: Theme
    private(set) var questionAnswerPairs: Array<QuestionAnswerPair>
    private(set) var nrOfRightAnswers: Int
    
    mutating func choose(_ answer: Answer){
        if let correctAnswerIndex = questionAnswerPairs[0].answers.firstIndex(where: { $0.isCorrect == true }) {
            questionAnswerPairs[0].answers[correctAnswerIndex].backgroundColor = "green"
            if let chosenAnswerIndex = questionAnswerPairs[0].answers.firstIndex(where: { $0.id == answer.id}) {
                if(questionAnswerPairs[0].answers[correctAnswerIndex].content == questionAnswerPairs[0].answers[chosenAnswerIndex].content) {
                    nrOfRightAnswers += 1
                }
            }
        }
    }
    
    init(numberOfQuestionAnswerPairs: Int) {
        questionAnswerPairs = Array<QuestionAnswerPair>()
        theme = Theme(content: "Lisa")
        nrOfRightAnswers = 0
        // verlopig hard gecodeerd
        // later een betere id maken, die zeker niet dezelfde kan zijn
        let testAnswers = [Answer(isCorrect: false, content: "1956", backgroundColor: "white", id: numberOfQuestionAnswerPairs * 2), Answer(isCorrect: true, content: "2001", backgroundColor: "white", id: numberOfQuestionAnswerPairs * 2 + 1), Answer(isCorrect: false, content: "1999", backgroundColor: "white", id: numberOfQuestionAnswerPairs * 2 + 2), Answer(isCorrect: false, content: "1901", backgroundColor: "white", id: numberOfQuestionAnswerPairs * 2 + 3)]
        let question = Question(content: "In welk jaar is Lisa geboren?", id: numberOfQuestionAnswerPairs * 9 + 1)
        let questionAnswerPair = QuestionAnswerPair(answers: testAnswers, question: question)
        questionAnswerPairs.append(questionAnswerPair)
//        let testAnswers2 = [Answer(isCorrect: true, content: "komkommer"), Answer(isCorrect: false, content: "wortel"),                          Answer(isCorrect: false, content: "tomaat"), Answer(isCorrect: false, content: "kool")]
//        let question2 = Question(content: "Wat is een groene groente?")
//        let questionAnswerPair2 = QuestionAnswerPair(answers: testAnswers2, question: question2)
//        questionAnswerPairs.append(questionAnswerPair2)
//        for pairIndex in 0..<numberOfQuestionAnswerPairs {
//            questionAnswerPairs.append(QuestionAnswerPair())
//        }
    }
    
    struct Theme {
        var content: String
    }
    struct QuestionAnswerPair {
        var answers: Array<Answer>
        var question: Question
        
        func getAnswers() -> Array<Answer> {
            return answers
        }
    }
    struct Answer: Identifiable {
        var isCorrect: Bool
        var content: String
        var backgroundColor: String
        var id: Int
    }
    struct Question: Identifiable {
        var content: String
        var id: Int
    }
}
