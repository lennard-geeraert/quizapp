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
    @Published var questions_food_and_drinks: [Question] = []
    @Published var questions_music: [Question] = []
    @Published var questions_movies: [Question] = []
    @Published var categories: [String] = ["Film and TV", "Music", "Food and Drinks"]
    
    @Published var questions: [Question] = []
    
    init()
    {
        fetchData()
    }
    
    // loading data from api
    
    func fetchData()
    {
        // food and drinks
        let url_food_and_drinks = "https://api.trivia.willfry.co.uk/questions?categories=food_and_drink&limit=10"
        let url_music = "https://api.trivia.willfry.co.uk/questions?categories=music&limit=10"
        let url_movies = "https://api.trivia.willfry.co.uk/questions?categories=movies&limit=10"
        
        // food and drinks
        getJSON(url: url_food_and_drinks) { (q:[Question]?) in
            DispatchQueue.main.async {
                self.questions_food_and_drinks = q ?? []
            }
        }
        
        // music
        getJSON(url: url_music) { (q:[Question]?) in
            DispatchQueue.main.async {
                self.questions_music = q ?? []
            }
        }
        
        // movies
        getJSON(url: url_movies) { (q:[Question]?) in
            DispatchQueue.main.async {
                self.questions_movies = q ?? []
            }
        }
    }
    
    func getJSON(url: String, completion: @escaping ([Question]) -> Void)
    {
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
    
    func makeQuestion(category: String, quest: String, correctAns: String, incorrectAns: Array<String>)
    {
        if(category == "Film and TV"){
            questions_movies.append(Question(id: Int.random(in: 0..<9999), category: category, type: "Multiple choice", question: quest, correctAnswer: correctAns, incorrectAnswers: incorrectAns))
        }
        if(category == "Music"){
            questions_music.append(Question(id: Int.random(in: 0..<9999), category: category, type: "Multiple choice", question: quest, correctAnswer: correctAns, incorrectAnswers: incorrectAns))
        }
        if(category == "Food and Drinks"){
            questions_food_and_drinks.append(Question(id: Int.random(in: 0..<9999), category: category, type: "Multiple choice", question: quest, correctAnswer: correctAns, incorrectAnswers: incorrectAns))
        }
        
        print(questions_movies)
        print("----------------------------------------------------------------")
    }
    
    func giveCorrectQuestions(category: String)
    {
        if(category == "Film and TV"){
            questions = questions_movies
        }
        if(category == "Music"){
            questions = questions_music
        }
        if(category == "Food and Drinks"){
            questions = questions_food_and_drinks
        }
    }
}
