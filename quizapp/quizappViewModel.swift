//
//  quizappViewModel.swift
//  quizapp
//
//  Created by Lennard Geeraert on 02/01/2022.
//

import SwiftUI

class quizappViewModel: ObservableObject {
    @Published private var model: quizappModel = quizappModel(numberOfQuestionAnswerPairs: 2) //hier later ook nog theme meegeven
    
    var questionAnswerPairs: Array<quizappModel.QuestionAnswerPair> {
        return model.questionAnswerPairs
    }
    
    var nrOfRightQuestions: Int {
        return model.nrOfRightAnswers
    }
        
    // MARK: - Intent(s)
    
    func choose(_ answer: quizappModel.Answer) {
        // this will happen automatically when specifying @Published and mutating
        // objectWillChange.send()
        model.choose(answer)
    }
}
