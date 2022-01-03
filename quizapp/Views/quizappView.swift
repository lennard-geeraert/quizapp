//
//  quizappView.swift
//  quizapp
//
//  Created by Lennard Geeraert on 24/12/2021.
//

import SwiftUI

struct quizappView: View
{
    // body will change when viewmodel notifice us that model changed
    @ObservedObject var viewModel: quizappViewModel
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                back
                Spacer()
                Text("✅ \(viewModel.nrOfRightAnswers) ❌ \(viewModel.nrOfWrongAnswers)")
                    .foregroundColor(.black)
                Spacer()
                forward
            }
            .font(.largeTitle)
            .padding()
            
            ForEach(viewModel.questions, id: \.id){ question in
                
                ZStack
                {
                    RoundedRectangle(cornerRadius: 20)
                        .fill()
                        .foregroundColor(.white)
                    Text(question.question)
                        .foregroundColor(.black)
                        .padding()
                        .font(.largeTitle)
                }
                
//                var temporaryAnswers: Array<String> = answer.incorrect_answers.append(answer.correct_answer)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 180))])
                {
                    ForEach(question.incorrect_answers, id: \.self){ answer in
                        CardView(answer: answer)
                            .aspectRatio(5/1, contentMode: .fit)
                            .onTapGesture {
//                                viewModel.choose(answer)
                            }
                    }
                }
                .padding(.bottom)
            }
            
            
        }
        .padding()
    }
    var back: some View
    {
        Button{
            // ga een vraag terug
        } label: {
            Image(systemName: "arrowshape.turn.up.backward")
        }
    }
    var forward: some View
    {
        Button{
            // ga een vraag verder
        } label: {
            Image(systemName: "arrowshape.turn.up.forward")
        }
    }
}

struct CardView: View
{
    let answer: String
    
    var body: some View
    {
        // use let when value doesn't change == constant
        // use var when the value changes
        let shape = RoundedRectangle(cornerRadius: 20)
        ZStack
        {
//            let color = answer.backgroundColor
            
//            if(color == "green") {
//                shape
//                    .fill()
//                    .foregroundColor(.green)
//            }
//            else {
                shape
                    .fill()
                    .foregroundColor(.white)
//            }
            shape
                .stroke(lineWidth: 3)
                .foregroundColor(.gray)
            Text(answer)
                .foregroundColor(.black)
                .padding()
                .font(.largeTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        let game = quizappViewModel()
        quizappView(viewModel: game)
            .preferredColorScheme(.light)
        quizappView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
