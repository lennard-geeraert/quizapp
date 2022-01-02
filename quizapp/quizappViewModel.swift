//
//  quizappViewModel.swift
//  quizapp
//
//  Created by Lennard Geeraert on 02/01/2022.
//

import SwiftUI

class quizappViewModel {
    private var model: quizappModel = quizappModel(numberOfQuestionAnswerPairs: 2) //hier later ook nog theme meegeven
    
    var questionAnswerPairs: Array<quizappModel.QuestionAnswerPair> {
        return model.questionAnswerPairs
    }
    
    // MARK: - Intent(s)
    
    func choose(_ answer: quizappModel.Answer) {
        model.choose(answer)
    }
}
