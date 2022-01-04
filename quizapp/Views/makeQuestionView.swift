//
//  makeQuestionView.swift
//  quizapp
//
//  Created by Lennard Geeraert on 04/01/2022.
//

import SwiftUI

struct makeQuestionView: View
{
    @StateObject var viewModel: quizappViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var category = ""
    @State private var question = ""
    @State private var correctAnswer = ""
    @State private var incorrectAnswer1 = ""
    @State private var incorrectAnswer2 = ""
    @State private var incorrectAnswer3 = ""
    
    var body: some View
    {
        ZStack
        {
            Form
            {
                Section(header: Text("General information"))
                {
                    TextField("Theme of question", text: $category)
                        .foregroundColor(isStringCorrect(string: category) ? .green : .red)
                    TextField("Question", text: $question)
                        .foregroundColor(isStringCorrect(string: question) ? .green : .red)
                    TextField("Correct Answer", text: $correctAnswer)
                        .foregroundColor(isStringCorrect(string: correctAnswer) ? .green : .red)
                    TextField("Wrong Answer 1", text: $incorrectAnswer1)
                        .foregroundColor(isStringCorrect(string: incorrectAnswer1) ? .green : .red)
                    TextField("Wrong Answer 2", text: $incorrectAnswer2)
                        .foregroundColor(isStringCorrect(string: incorrectAnswer2) ? .green : .red)
                    TextField("Wrong Answer 3", text: $incorrectAnswer3)
                        .foregroundColor(isStringCorrect(string: incorrectAnswer3) ? .green : .red)
                }
            }
            .navigationTitle("Add Question ")
            .toolbar
            {
                ToolbarItemGroup(placement: .navigationBarTrailing)
                {
                    Button {
                    }   label:
                    {
                        NavigationLink(destination: homeView(viewModel: viewModel)) {
                            Button(action: {makeQuestion()}, label: {
                                Image(systemName: "house")
                            })
                        }
                    }
                    Button(action: {clearText()}, label: {
                        Image(systemName: "trash")
                    })
                    NavigationLink(destination: homeView(viewModel: viewModel), label: {
                            Button(action: {makeQuestion()}, label: {
                                Image(systemName: "checkmark")
                            }).disabled(!allesCorrect())
                    })
                 }
             }
        }
    }
    
    func clearText()
    {
        category = ""
        question = ""
        correctAnswer = ""
        incorrectAnswer1 = ""
        incorrectAnswer2 = ""
        incorrectAnswer3 = ""
    }
    
    func isStringCorrect(string: String) -> Bool
    {
        if string.isEmpty {
            return false
        }
        return true
    }
    
    func makeQuestion()
    {
        let incAnswers = [incorrectAnswer1, incorrectAnswer2, incorrectAnswer3]
        viewModel.makeQuestion(theme: self.category, quest: self.question, correctAns: self.correctAnswer, incorrectAns: incAnswers)
        presentationMode.wrappedValue.dismiss()
    }
    
    func allesCorrect() -> Bool
    {
        if(!category.isEmpty && !question.isEmpty && !correctAnswer.isEmpty && !incorrectAnswer1.isEmpty && !incorrectAnswer2.isEmpty && !incorrectAnswer3.isEmpty) {
            return true
        }
        return false
    }
}



















struct makeQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        let game = quizappViewModel()
        makeQuestionView(viewModel: game)
    }
}
