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
                        
                        Label("START QUIZ", systemImage: "gamecontroller")
                            .frame(width: 220, height: 40, alignment: .center)
                            .background(.gray)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        
                    })
                    .offset(y: -200)
                    NavigationLink(destination: makeQuestionView(viewModel: quizappViewModel()), label: {
                        
                        Label("EDIT QUIZ", systemImage: "pencil")
                            .frame(width: 220, height: 40, alignment: .center)
                            .background(.gray)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        
                    })
                    .offset(y: -200)
                }
            }
            .navigationBarTitle("Quizapp",displayMode: .inline)
        }
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
