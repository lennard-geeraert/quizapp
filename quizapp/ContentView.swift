//
//  ContentView.swift
//  quizapp
//
//  Created by Lennard Geeraert on 24/12/2021.
//

import SwiftUI

struct ContentView: View {
    var answers = ["Antwoord 1", "Antwoord 2", "Antwoord 3"]
    
    var body: some View {
        VStack {
            HStack {
                back
                Spacer()
                forward
            }
            .font(.largeTitle)
            .padding()
            Spacer()
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 400))]) {
                ForEach(answers, id: \.self){ answer in
                    CardView(content: answer)
                        .aspectRatio(3/1, contentMode: .fit)
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
    var content: String
    
    var body: some View {
        // use let when value doesn't change == constant
        // use var when the value changes
        let shape = RoundedRectangle(cornerRadius: 20)
        ZStack {
            shape
                .fill()
                .foregroundColor(.white)
            shape
                .stroke(lineWidth: 3)
                .foregroundColor(.gray)
            Text(content)
                .foregroundColor(.black)
                .padding()
                .font(.largeTitle)
        }
        .onTapGesture {
            // hier ga je naar de volgende vraag
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
.previewInterfaceOrientation(.portrait)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
