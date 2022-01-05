//
//  homeView.swift
//  quizapp
//
//  Created by Lennard Geeraert on 03/01/2022.
//

import SwiftUI

struct homeView: View
{
    @StateObject var viewModel: quizappViewModel
    @State var category: String = "Film and TV"
        
    var body: some View
    {
        let questions_food_and_drinks = viewModel.questions_food_and_drinks
        let questions_music = viewModel.questions_music
        let questions_movies = viewModel.questions_movies
        let categories = viewModel.categories
        
        if(!questions_food_and_drinks.isEmpty && !questions_music.isEmpty && !questions_movies.isEmpty)
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
                    
                    NavigationLink(destination: quizappView(viewModel: viewModel, category: $category), label: {
                        
                        labelView(text: "START QUIZ", image: "gamecontroller")
                    })
                    .offset(y: -200)
                    NavigationLink(destination: makeQuestionView(viewModel: viewModel), label: {
                        
                        labelView(text: "EDIT QUIZ", image: "pencil")
                    })
                    .offset(y: -200)
                    
                    Section {
                        Picker(selection: $category, label: Text("Choose Category"))
                        {
                            ForEach(categories, id: \.self) { cat in
                                Text(cat)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
        // show wait sign if data is not yet loaded
        else {
            ZStack {
                Color(.systemBackground)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    .scaleEffect(3)
            }
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
