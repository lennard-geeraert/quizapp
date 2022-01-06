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
    // @StateObject is better than @ObservedObject, it will keep the var even when struct is destroyed and wait unit var is loaded to load the body
    @StateObject var viewModel: quizappViewModel
    // number of questions
    @State var i: Int = 0
    @State var isLoading = false
    @State var nrOfCorrectAnswers = 0
    @State var nrOfWrongAnswers = 0
    @State private var showAnswer = false
    
    @Binding var category: String
    
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
                        Label(
                            title: { Text("\(nrOfCorrectAnswers == 0 ? "" : "\(nrOfCorrectAnswers)")")
                                    .font(.largeTitle)
                            },
                            icon: { Image(systemName: "checkmark")
                                    .font(.largeTitle)
                                    .foregroundColor(.green)
                            }
                        )
                        Spacer()
                        Label(
                            title: { Text("\(nrOfWrongAnswers == 0 ? "" : "\(nrOfWrongAnswers)")")
                                    .font(.largeTitle)
                            },
                            icon: { Image(systemName: "xmark")
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                            }
                        )
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
                            .font(.title2)
                            .fontWeight(.heavy)
                            .lineLimit(nil)
                            .padding()
                    }
                    .offset(y: -55)
                    
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                        
                        Capsule()
                            .fill(Color.gray.opacity(0.5))
                            .frame(height: 6)
                        
                        Capsule()
                            .fill(Color.green)
                            .frame(width: progressBar(i: self.i, total: questions.count), height: 6)
                    }
                    .padding()
                    
                    let temporaryAnswers = giveArray(prefix: 3, incorrectAns: questions[self.i].incorrectAnswers, correctAns: questions[self.i].correctAnswer)
                    
                    let correctAnsw = questions[self.i].correctAnswer
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 250))])
                    {
                        ForEach(temporaryAnswers, id: \.self){ answer in
                            CardView(answer: answer)
                                .aspectRatio(5/1, contentMode: .fit)
                                .onTapGesture {
                                    self.showAnswer = true
                                    if(answer == correctAnsw) {
                                        nrOfCorrectAnswers = nrOfCorrectAnswers + 1
                                    }
                                    else {
                                        nrOfWrongAnswers = nrOfWrongAnswers + 1
                                    }
                                    self.i = self.i + 1
                                }
                                .actionSheet(isPresented: $showAnswer) {
                                    ActionSheet(title: Text("Correct answer: \(questions[self.i - 1].correctAnswer)"), message: Text("Score: \(self.nrOfCorrectAnswers)/\(i)"),
                                                buttons: [.cancel()])
                                }
                        }
                    }
                    .padding(.bottom)
                }
                else {
                    finalView(nrCorrect: $nrOfCorrectAnswers, nrInCorrect: $nrOfWrongAnswers, category: $category, viewModel: viewModel)
                }
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
        .onAppear{viewModel.giveCorrectQuestions(category: self.category)}
        .padding()
    }
}

func progressBar(i: Int, total: Int) -> CGFloat
{
    let x = CGFloat(i) / CGFloat(total)
    let y = UIScreen.main.bounds.width - 30
    return x * y
}

func giveArray(prefix: Int, incorrectAns: Array<String>, correctAns: String) -> Array<String>
{
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
                .stroke(lineWidth: 1.5)
                .foregroundColor(.gray)
                .cornerRadius(15)
            Text(answer)
                .font(.body)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .shadow(color: .black.opacity(0.05), radius: 5, x: 5, y: 5)
        .shadow(color: .black.opacity(0.05), radius: 5, x: -5, y: -5)
    }
}















//struct ContentView_Previews: PreviewProvider
//{
//    static var previews: some View
//    {
//        let game = quizappViewModel()
//        quizappView(viewModel: game)
//            .preferredColorScheme(.light)
//        quizappView(viewModel: game)
//            .preferredColorScheme(.dark)
//    }
//}
