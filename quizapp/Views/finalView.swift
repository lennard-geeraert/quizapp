//
//  finalView.swift
//  quizapp
//
//  Created by Lennard Geeraert on 04/01/2022.
//

import SwiftUI

struct finalView: View
{
    @Binding var nrCorrect: Int
    @Binding var nrInCorrect: Int
    
    var body: some View
    {
        let totalNr = nrCorrect + nrInCorrect
        
        VStack
        {
            if(nrCorrect < totalNr/2)
            {
                textView(text: "Better luck next time...")
                
                Text("Final score: \(nrCorrect)/\(totalNr)")
                    .padding()
                
                imageView(image: "🤯")
            }
            else {
                textView(text: "Great Job!")
                
                Text("Final score: \(nrCorrect)/\(totalNr)")
                    .padding()

                imageView(image: "🥸")
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

struct textView: View
{
    var text: String
    
    var body: some View
    {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.thin)
            .foregroundColor(.green)
            .multilineTextAlignment(.center)
            .lineLimit(nil)
            .padding()
    }
}

struct imageView: View
{
    var image: String
    
    var body: some View
    {
        ZStack
        {
            RoundedRectangle(cornerRadius: 20)
                .fill()
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(lineWidth: 2)
                .foregroundColor(.white)
            Text(image).font(Font.system(size: 90))
        }
    }
}














// how to initialize binding values here

//struct finalView_Previews: PreviewProvider
//{
//    static var previews: some View
//    {
//        finalView($nrCorrect: 0, $nrInCorrect: 2)
//    }
//}
