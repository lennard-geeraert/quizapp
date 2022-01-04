//
//  homeView.swift
//  quizapp
//
//  Created by Lennard Geeraert on 03/01/2022.
//

import SwiftUI

struct homeView: View
{
//        @State var score = 0
        
    var body: some View
    {
        NavigationView
        {
            VStack(spacing: 20)
            {
                Text("Welcome to the quizapp game")
                
                // hier later thema en difficulty kiezen
                // naargelang difficulty en thema wordt er een API van het internet ingeladen
                
                NavigationLink(destination: quizappView(viewModel: quizappViewModel()))
                {
                    Text("START QUIZ")
                }
                NavigationLink(destination: makeQuestionView(viewModel: quizappViewModel()))
                {
                    Text("EDIT QUIZ")
                }
//                    HStack{
//                        Text("last score : \(self.score) / \(myQuiz1.count)")          .onAppear(){
//                                self.score = LoadScore(quiz:"myQuiz1")
//
//                        }
//
//                    }
            }
        }
        .navigationBarTitle("Quizapp",displayMode: .inline)
    }
}



















struct homeView_Previews: PreviewProvider
{
    static var previews: some View
    {
        homeView()
    }
}
