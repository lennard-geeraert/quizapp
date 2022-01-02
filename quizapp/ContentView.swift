//
//  ContentView.swift
//  quizapp
//
//  Created by Lennard Geeraert on 24/12/2021.
//

import SwiftUI

struct ContentView: View {
    // body will change when viewmodel notifice us that model changed
    @ObservedObject var viewModel: quizappViewModel
    
    var body: some View {
        VStack {
            HStack {
                back
                Spacer()
                // hier een groen vinkje zetten naast aantal juiste antwoorden en rood kruis naast het aantal onjuiste antwoorden
                Text("\(viewModel.nrOfRightQuestions)")
                    .foregroundColor(.black)
                Spacer()
                forward
            }
            .font(.largeTitle)
            .padding()
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill()
                    .foregroundColor(.white)
                Text(viewModel.questionAnswerPairs[0].question.content)
                    .foregroundColor(.black)
                    .padding()
                    .font(.largeTitle)
            }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 180))]) {
                ForEach(viewModel.questionAnswerPairs[0].getAnswers()){ answer in
                    CardView(answer: answer)
                        .aspectRatio(5/1, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(answer)
                        }
                }
            }
            .padding(.bottom)
        }
        .padding()
    }
    var back: some View {
        Button{
            // ga een vraag terug
        } label: {
            Image(systemName: "arrowshape.turn.up.backward")
        }
    }
    var forward: some View {
        Button{
            // ga een vraag verder
        } label: {
            Image(systemName: "arrowshape.turn.up.forward")
        }
    }
}

struct CardView: View {
    let answer: quizappModel.Answer
    
    var body: some View {
        // use let when value doesn't change == constant
        // use var when the value changes
        let shape = RoundedRectangle(cornerRadius: 20)
        ZStack {
            let color = answer.backgroundColor
            if(color == "green") {
                shape
                    .fill()
                    .foregroundColor(.green)
            }
            else {
                shape
                    .fill()
                    .foregroundColor(.white)
            }
            shape
                .stroke(lineWidth: 3)
                .foregroundColor(.gray)
            Text(answer.content)
                .foregroundColor(.black)
                .padding()
                .font(.largeTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = quizappViewModel()
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
