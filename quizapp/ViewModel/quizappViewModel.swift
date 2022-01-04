//
//  quizappViewModel.swift
//  quizapp
//
//  Created by Lennard Geeraert on 02/01/2022.
//

import SwiftUI

class quizappViewModel: ObservableObject
{
    @Published private var model = quizappModel()
    @Published var questions: [Question] = []
    
    init() {
        fetchData()
    }
    
    // loading data from api
    
    func fetchData() {
        getJSON { (q:[Question]?) in
            DispatchQueue.main.async {
                self.questions = q ?? []
            }
        }
    }
    
    func getJSON(completion: @escaping ([Question]) -> Void)
    {
        // food and drinks
//        let url = "https://api.trivia.willfry.co.uk/questions?categories=food_and_drink&limit=10"
        // random questions
        let url = "https://api.trivia.willfry.co.uk/questions?limit=10"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("Something went wrong...")
                return
            }
            // have data
            var result: [Question]?
            do {
                result = try JSONDecoder().decode([Question].self, from: data)
            }
            catch {
                print("Failed to convert \(error.localizedDescription)")
            }
                
            guard let json = result else {
                print("Not ok")
                return
            }
            print(json[0].question)
            
            completion(json)
        }).resume()
    }
    
    // MARK: - Intent(s)
    
    func makeQuestion(theme: String, quest: String, correctAns: String, incorrectAns: Array<String>) {
        questions.append(Question(id: Int.random(in: 0..<9999), category: theme, type: "Multiple choice", question: quest, correctAnswer: correctAns, incorrectAnswers: incorrectAns))
        print(questions)
        print("----------------------------------------------------------------")
    }
}
