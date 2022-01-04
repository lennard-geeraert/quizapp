//
//  makeQuestionView.swift
//  quizapp
//
//  Created by Lennard Geeraert on 04/01/2022.
//

import SwiftUI

struct makeQuestionView: View
{
    @ObservedObject var viewModel: quizappViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var category = ""
    @State private var type = ""
    @State private var difficulty = ""
    @State private var question = ""
    @State private var correct_answer = ""
    @State private var incorrect_answers: Array<String> = []
//    var id: Int = UUID().uuidString.hash
    
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
                        Image(systemName: "house")
                    }
                    NavigationLink(destination: homeView(), label: {
                            Button(action: {makeQuestion()}, label: {
                                Text("Save")
                            }).disabled(!allesCorrect())
                    })
                 }
             }
        }
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
        viewModel.makeQuestion(theme: self.category)
        presentationMode.wrappedValue.dismiss()
    }
    
    func allesCorrect() -> Bool
    {
        if(!category.isEmpty) {
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
