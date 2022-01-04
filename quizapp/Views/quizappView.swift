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
    @State var nrOfCorrectAnswers = 0
    @State var nrOfWrongAnswers = 0
    
    var body: some View
    {
        VStack
        {
            let questions = viewModel.questions
            
            if(!questions.isEmpty)
            {
                if(self.i < questions.count)
                {
                    HStack
                    {
//                        back
//                        Spacer()
                        Text("✅ \(nrOfCorrectAnswers)")
                        Spacer()
                        Text("❌ \(nrOfWrongAnswers)")
//                        forward
                    }
                    .font(.largeTitle)
                    .padding()
                    .offset(y: -70)
                    
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: 20)
                            .fill()
                            .foregroundColor(.white)
                        Text(questions[self.i].question)
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                            .lineLimit(nil)
                            .padding()
//                            .font(.largeTitle)
                    }
                    .offset(y: -55)
                    
                    let temporaryAnswers = giveArray(prefix: 3, incorrectAns: questions[self.i].incorrectAnswers, correctAns: questions[self.i].correctAnswer)
                    
                    let correctAnsw = questions[self.i].correctAnswer
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 180))])
                    {
                        ForEach(temporaryAnswers, id: \.self){ answer in
                            CardView(answer: answer)
                                .aspectRatio(5/1, contentMode: .fit)
                                .onTapGesture {
//                                    viewModel.choose(questions[self.i].id, answer: answer)
                                    if(answer == correctAnsw) {
                                        nrOfCorrectAnswers = nrOfCorrectAnswers + 1
                                    }
                                    else {
                                        nrOfWrongAnswers = nrOfWrongAnswers + 1
                                    }
                                    self.i = self.i + 1
                                }
                        }
                    }
                    .padding(.bottom)
                }
                else {
                    finalView(nrCorrect: nrOfCorrectAnswers, nrInCorrect: nrOfWrongAnswers)
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
//        .onAppear{ loadData() }
        .padding()
    }
    
//    func loadData() {
//        isLoading = true
//        DispatchQueue.main.async {
//            viewModel.fetchData()
//            isLoading = false
//        }
//    }
    
//    var back: some View
//    {
//        Button{
//            // ga een vraag terug
//        } label: {
//            Image(systemName: "arrowshape.turn.up.backward")
//        }
//    }
//    var forward: some View
//    {
//        Button{
//            // ga een vraag verder
//        } label: {
//            Image(systemName: "arrowshape.turn.up.forward")
//        }
//    }
}

func giveArray(prefix: Int, incorrectAns: Array<String>, correctAns: String) -> Array<String> {
    var test: Array<String> = []
    if(incorrectAns.count >= 3) {
        for n in 0...2 {
            test.append(incorrectAns[n])
        }
    }
    else {
        for n in 0...1 {
            test.append(incorrectAns[n])
        }
    }
    test.append(correctAns)
    test.shuffle()
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
                .stroke(lineWidth: 2)
                .foregroundColor(.gray)
            Text(answer)
                .font(.body)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .padding()
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
