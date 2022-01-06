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
    @Published var questions_science: [Question] = []
    @Published var questions_geography: [Question] = []
    @Published var categories: [String] = ["Film and TV", "Music", "Food and Drinks", "Science", "Geography"]
    @Published var bestScore_food_and_drinks = 0
    @Published var bestScore_music = 0
    @Published var bestScore_movies = 0
    @Published var bestScore_science = 0
    @Published var bestScore_geography = 0
    
    @Published var questions: [Question] = []
    
    init()
    {
        fetchData()
    }
    
    // loading data from api
    
    func fetchData()
    {
        let url_food_and_drinks = "https://api.trivia.willfry.co.uk/questions?categories=food_and_drink&limit=10"
        let url_music = "https://api.trivia.willfry.co.uk/questions?categories=music&limit=10"
        let url_movies = "https://api.trivia.willfry.co.uk/questions?categories=movies&limit=10"
        let url_science = "https://api.trivia.willfry.co.uk/questions?categories=science&limit=10"
        let url_geography = "https://api.trivia.willfry.co.uk/questions?categories=geography&limit=10"
        
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
        // Science -
        getJSON(url: url_science) { (q:[Question]?) in
            DispatchQueue.main.async {
                self.questions_science = q ?? []
            }
        }
        // Gegraphy
        getJSON(url: url_geography) { (q:[Question]?) in
            DispatchQueue.main.async {
                self.questions_geography = q ?? []
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
    
    func getBestScore(category: String) -> Int
    {
        if(category == "Film and TV"){
            return bestScore_movies
        }
        else if(category == "Music"){
            return bestScore_music
        }
        else if(category == "Food and Drinks"){
            return bestScore_food_and_drinks
        }
        else if(category == "Science"){
            return bestScore_science
        }
        else if(category == "Geography"){
            return bestScore_geography
        }
        return 0
    }
    
    func setBestScore(category: String, score: Int)
    {
        if(category == "Film and TV" && score > bestScore_movies){
            bestScore_movies = score
        }
        else if(category == "Music" && score > bestScore_music){
            bestScore_music = score
        }
        else if(category == "Food and Drinks" && score > bestScore_food_and_drinks){
            bestScore_food_and_drinks = score
        }
        else if(category == "Science" && score > bestScore_science){
            bestScore_science = score
        }
        else if(category == "Geography" && score > bestScore_geography){
            bestScore_geography = score
        }
    }
    
    func getNumberOfQuestion(category: String) -> Int
    {
        if(category == "Film and TV"){
            return questions_movies.count
        }
        else if(category == "Music"){
            return questions_music.count
        }
        else if(category == "Food and Drinks"){
            return questions_food_and_drinks.count
        }
        else if(category == "Science"){
            return questions_science.count
        }
        else if(category == "Geography"){
            return questions_geography.count
        }
        return 0
    }
    
    // MARK: - Intent(s)
    
    func makeQuestion(category: String, quest: String, correctAns: String, incorrectAns: Array<String>)
    {
        if(category == "Film and TV"){
            questions_movies.append(Question(id: Int.random(in: 0..<9999), category: category, type: "Multiple choice", question: quest, correctAnswer: correctAns, incorrectAnswers: incorrectAns))
        }
        else if(category == "Music"){
            questions_music.append(Question(id: Int.random(in: 0..<9999), category: category, type: "Multiple choice", question: quest, correctAnswer: correctAns, incorrectAnswers: incorrectAns))
        }
        else if(category == "Food and Drinks"){
            questions_food_and_drinks.append(Question(id: Int.random(in: 0..<9999), category: category, type: "Multiple choice", question: quest, correctAnswer: correctAns, incorrectAnswers: incorrectAns))
        }
        else if(category == "Science"){
            questions_science.append(Question(id: Int.random(in: 0..<9999), category: category, type: "Multiple choice", question: quest, correctAnswer: correctAns, incorrectAnswers: incorrectAns))
        }
        else if(category == "Geography"){
            questions_geography.append(Question(id: Int.random(in: 0..<9999), category: category, type: "Multiple choice", question: quest, correctAnswer: correctAns, incorrectAnswers: incorrectAns))
        }
    }
    
    func giveCorrectQuestions(category: String)
    {
        if(category == "Film and TV"){
            questions = questions_movies
        }
        else if(category == "Music"){
            questions = questions_music
        }
        else if(category == "Food and Drinks"){
            questions = questions_food_and_drinks
        }
        else if(category == "Science"){
            questions = questions_science
        }
        else if(category == "Geography"){
            questions = questions_geography
        }
    }
}
