//
//  finalView.swift
//  quizapp
//
//  Created by Lennard Geeraert on 04/01/2022.
//

import SwiftUI

struct finalView: View
{
    var nrCorrect: Int
    var nrInCorrect: Int
    
    var body: some View
    {
        let totalNr = nrCorrect + nrInCorrect
        
        VStack
        {
            if(nrCorrect < totalNr/2)
            {
                Text("Better luck next time...")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding()
                
                Text("Final score: \(nrCorrect)/\(totalNr)")
                    .padding()
                
                ZStack
                {
                    RoundedRectangle(cornerRadius: 20)
                        .fill()
                        .foregroundColor(.white)
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(lineWidth: 2)
                        .foregroundColor(.white)
                    Text("🤯").font(Font.system(size: 90))
                }
            }
            else {
                Text("Great Job!")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding()
                
                Text("Final score: \(nrCorrect)/\(totalNr)")
                    .padding()
                
                ZStack
                {
                    RoundedRectangle(cornerRadius: 20)
                        .fill()
                        .foregroundColor(.white)
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(lineWidth: 2)
                        .foregroundColor(.white)
                    Text("🥸").font(Font.system(size: 90))
                }
            }
        }
        .navigationTitle(" ")
        .toolbar
        {
            ToolbarItemGroup(placement: .navigationBarTrailing)
            {
                Button {
                }   label:
                {
                    NavigationLink(destination: homeView(viewModel: quizappViewModel()), label: {
                        Image(systemName: "house")
                    })
                    NavigationLink(destination: quizappView(viewModel: quizappViewModel()), label: {
                        Image(systemName: "arrow.counterclockwise")
                    })
                }
            
             }
         }
    }
}

func test() {
}
















struct finalView_Previews: PreviewProvider {
    static var previews: some View {
        finalView(nrCorrect: 0, nrInCorrect: 2)
    }
}
