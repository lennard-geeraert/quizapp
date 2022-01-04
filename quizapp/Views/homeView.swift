//
//  homeView.swift
//  quizapp
//
//  Created by Lennard Geeraert on 03/01/2022.
//

import SwiftUI

struct homeView: View
{
    @ObservedObject var viewModel: quizappViewModel
        
    var body: some View
    {
        let questions = viewModel.questions
        
        if(!questions.isEmpty)
        {
            NavigationView
            {
                VStack(spacing: 20)
                {
                    Text("Welcome to the quizapp game")
                        .font(.title2)
                        .fontWeight(.thin)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .padding()
                        .offset(y: -200)
                    
                    NavigationLink(destination: quizappView(viewModel: quizappViewModel()), label: {
                        
                        labelView(text: "START QUIZ", image: "gamecontroller")
                    })
                    .offset(y: -200)
                    NavigationLink(destination: makeQuestionView(viewModel: quizappViewModel()), label: {
                        
                        labelView(text: "EDIT QUIZ", image: "pencil")
                    })
                    .offset(y: -200)
                }
            }
            .navigationBarTitle("Quizapp",displayMode: .inline)
        }
    }
}

struct labelView: View
{
    var text: String
    var image: String
    
    var body: some View
    {
        Label(text, systemImage: image)
            .frame(width: 220, height: 40, alignment: .center)
            .background(.gray)
            .foregroundColor(.white)
            .cornerRadius(12)
    }
}



















struct homeView_Previews: PreviewProvider
{
    static var previews: some View
    {
        let game = quizappViewModel()
        homeView(viewModel: game)
    }
}
