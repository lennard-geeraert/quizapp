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
    // number of questions
    @State var i: Int = 0
    
    @State var isLoading = false
    
    var body: some View
    {
        VStack
        {
            if(!isLoading)
            {
                let questions = viewModel.questionAnswerPairs
                
                if(self.i < questions.count)
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
                    
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: 20)
                            .fill()
                            .foregroundColor(.white)
                        Text(questions[self.i].question)
                            .foregroundColor(.black)
                            .padding()
                            .font(.largeTitle)
                    }
                    
                    let temporaryAnswers = giveArray(array: questions[self.i].incorrect_answers, string: questions[self.i].correct_answer)
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 180))])
                    {
                        ForEach(temporaryAnswers, id: \.self){ answer in
                            CardView(answer: answer)
                                .aspectRatio(5/1, contentMode: .fit)
                                .onTapGesture {
                                    viewModel.choose(questions[self.i].id!, answer: answer)
                                    self.i = self.i + 1
                                }
                        }
                    }
                    .padding(.bottom)
                }
                else {
                    finalView(nrCorrect: viewModel.nrOfRightAnswers, nrInCorrect: viewModel.nrOfWrongAnswers)
                }
            }
            else {
                ZStack {
                    Color(.systemBackground)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(3)
                }
            }
        }
        .onAppear{ loadData() }
        .padding()
    }
    
    func loadData() {
        isLoading = true
        DispatchQueue.main.async {
            viewModel.fetchData()
            isLoading = false
        }
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

func giveArray(array: Array<String>, string: String) -> Array<String> {
    var test = array
    test.append(string)
    return test
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
            shape
                .fill()
                .foregroundColor(.white)
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
