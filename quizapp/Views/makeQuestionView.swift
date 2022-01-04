//
//  makeQuestionView.swift
//  quizapp
//
//  Created by Lennard Geeraert on 04/01/2022.
//

import SwiftUI

struct makeQuestionView: View
{
    @ObservedObject var viewModel: quizappViewModel
    
    
    
    var body: some View
    {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}



















struct makeQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        let game = quizappViewModel()
        makeQuestionView(viewModel: game)
    }
}
