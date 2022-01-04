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
        VStack {
            Text("Final score: \(nrCorrect)/\(nrInCorrect + nrCorrect)")
        }
    }
}
















struct finalView_Previews: PreviewProvider {
    static var previews: some View {
        finalView(nrCorrect: 0, nrInCorrect: 2)
    }
}
