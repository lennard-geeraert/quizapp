//
//  quizappViewModel.swift
//  quizapp
//
//  Created by Lennard Geeraert on 02/01/2022.
//

import SwiftUI

class quizappViewModel: ObservableObject
{
    typealias Answer = quizappModel.Answer
    
    @Published private var model = quizappModel(numberOfQuestionAnswerPairs: 2) //hier later ook nog theme meegeven
    @Published var questions: [MyResult] = []
    
    var questionAnswerPairs: Array<quizappModel.QuestionAnswerPair> {
        return model.questionAnswerPairs
    }
    
//    var questionAnswerPairs: [MyResult] {
//        return questions
//    }
    
    var nrOfRightAnswers: Int {
        return model.nrOfRightAnswers
    }
    
    var nrOfWrongAnswers: Int {
        return model.nrOfWrongAnswers
    }
    
    init() {
        fetchData()
    }
    
    // loading data from api
    
    func fetchData() {
        getJSON { (q:Response?) in
            DispatchQueue.main.async {
                self.questions = q?.results ?? []
            }
        }
    }
    
    func getJSON(completion: @escaping (Response) -> Void)
    {
        let url = "https://opentdb.com/api.php?amount=10&category=12&difficulty=easy&type=multiple"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("Something went wrong...")
                return
            }
            // have data
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                print("Failed to convert \(error.localizedDescription)")
            }
                
            guard let json = result else {
                print("Not ok")
                return
            }
            print(json.results[0].question)
            print("\(json.response_code)")
            
            completion(json)
        }).resume()
    }
    
    struct Response: Codable
    {
        var results: Array<MyResult>
        var response_code: Int
    }
    
    struct MyResult: Codable, Identifiable
    {
        // Wanner dit erbij komt lukt het inlezen van de data niet meer
        var id: Int? = UUID().uuidString.hash
        
        var category: String
        var type: String
        var difficulty: String
        var question: String
        var correct_answer: String
        var incorrect_answers: Array<String>
        
        init(category: String, type: String, difficulty: String, question: String, correct_answer: String, incorrect_answers: Array<String>) {
            self.id = UUID().uuidString.hash
            self.category = category
            self.type = type
            self.difficulty = difficulty
            self.question = question
            self.correct_answer = correct_answer
            self.incorrect_answers = incorrect_answers
        }
    }
    
    // transforming loaded data
    
//    func transform(data: [MyResult]) -> Void {
////        model.transform(data)
//        ForEach(data) { dataObject in
//            var answers = [model]
//            ForEach(dataObject.incorrect_answers) { answer in
//
//            }
//            model.questionAnswerPairs.a
//        }
//    }
    
    
    // MARK: - Intent(s)
    
    func choose(_ answer: Answer) {
        // this will happen automatically when specifying @Published and mutating
        // objectWillChange.send()
        model.choose(answer)
        print(questions)
    }
}
