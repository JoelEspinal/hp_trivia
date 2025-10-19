//
//  Game.swift
//  hp_trivia
//
//  Created by Joel Espinal on 14/1/25.
//

import Foundation
import SwiftUI

@MainActor
class Game: ObservableObject {
    @Published var gameScore: Int = 0
    @Published var questionScore = 0

    @Published var recentScore = [0, 0, 0]
    
    private var allQuestions: [Question] = []
    
    private var answeredQuestions: [Int] = []
    
    var filteredQuesdtions: [Question] = []
    
    private let savePath = FileManager.documentsDiretory.appending(path: "SaveScores")
    
    var currentQuestion: Question? = Constans.sharedConstants.previewQuestion
    
    var answers: [String] = []
    
    var correctAnswqer: String {
        (currentQuestion?.answers.first(where: { $0.value == true })!.key)!
    }
    
    
    func startGame() {
        gameScore = 0
        questionScore = 5
        answeredQuestions = []
    }
    
    
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
        
        answers = []
        
        for answer in currentQuestion!.answers.keys {
            answers.append(answer)
        }
        
        answers.shuffle()
        questionScore = 5
    }
    
    func correct() {
        answeredQuestions.append(currentQuestion?.id ?? 0)
        withAnimation {
            gameScore += questionScore
        }
    }
    func endGame() {
        recentScore[2] = recentScore[1]
        recentScore[1] = recentScore[0]
        recentScore[0] = gameScore
        
        saveScores()
    }
    
    func loadScores() {
        do {
            let data = try Data(contentsOf: savePath)
            recentScore = try JSONDecoder().decode([Int].self, from: data)
        } catch {
            recentScore = [0, 0, 0]
//            print("Error loading JSON data: \(error)")
        }
    }
    
    
    init() {
        decodeQuestions()
    }
   
    private func saveScores() {
        do {
            let data = try JSONEncoder().encode(recentScore)
            try data.write(to: savePath)
        } catch {
            print("Unable to save data: \(error)")
        }
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
