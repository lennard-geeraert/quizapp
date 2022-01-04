//
//  quizappViewModel.swift
//  quizapp
//
//  Created by Lennard Geeraert on 02/01/2022.
//

import SwiftUI

class quizappViewModel: ObservableObject
{
    @Published private var model = quizappModel() //hier later ook nog theme meegeven
    @Published var questions: [MyResult] = []
    
//    var questionAnswerPairs: Array<QuestionAnswerPair> {
//        return model.questionAnswerPairs
//    }
    
    var questionAnswerPairs: Array<MyResult> {
        fetchData()
        return questions
    }
    
    var nrOfRightAnswers: Int {
        return model.nrOfRightAnswers
    }
    
    var nrOfWrongAnswers: Int {
        return model.nrOfWrongAnswers
    }
    
    init() {
//        fetchData()
    }
    
    // loading data from api
    
    func fetchData() {
        getJSON { (q:Response?) in
            DispatchQueue.main.async {
                self.questions = q?.results ?? []
            }
        }
        
//        print(self.questions[0].question)
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
    
    // MARK: - Intent(s)
    
    func choose(_ id: Int, answer: String) {
        // this will happen automatically when specifying @Published and mutating
        // objectWillChange.send()
        model.choose(id, answer: answer)
        print(questions)
        print("----------------------------------------------------------------")
        print(questionAnswerPairs)
        print("----------------------------------------------------------------")
    }
    
    func makeQuestion(theme: String) {
        model.makeQuestion(theme: theme)
        print("!!!!!!!! \(theme) !!!!!!!!!!!!!!!!")
    }
}
