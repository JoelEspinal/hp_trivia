//
//  Game.swift
//  hp_trivia
//
//  Created by Joel Espinal on 14/1/25.
//

import Foundation

@MainActor
class Game: ObservableObject {
    
    private var allQuestions: [Question] = []
    
    private var answeredQuestions: [Int] = []
    
    var filteredQuesdtions: [Question] = []
    
    var currentQuestion: Question? = Constans.sharedConstants.previewQuestion
    
    func filterQuestions(to books: [Int]) {
        filteredQuesdtions = allQuestions.filter { books.contains($0.book) }
    }
    
    func newQuestion() {
        if filteredQuesdtions.isEmpty { return }
        
        if answeredQuestions.count == filteredQuesdtions.count {
            answeredQuestions = []
        }
        
        var potentialQuestion = filteredQuesdtions.randomElement()!
        while answeredQuestions.contains(potentialQuestion.id) {
            potentialQuestion = filteredQuesdtions.randomElement()!
        }
        currentQuestion = potentialQuestion
    }
    
    init() {
        decodeQuestions()
    }
    
    private func decodeQuestions() {
        if let url = Bundle.main.url(forResource: "trivia", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                allQuestions = try decoder.decode([Question].self, from: data)
            } catch {
                print("Error loading JSON data: \(error)")
            }
        }
    }
}
