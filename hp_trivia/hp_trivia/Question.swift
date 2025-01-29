//
//  Question.swift
//  hp_trivia
//
//  Created by Joel Espinal on 12/1/25.
//

import Foundation

struct Question: Codable {
    let id: Int
    let question: String
    var answers:[String : Bool] = [:]
    let book: Int
    let hint: String
    var wrong: [String : Bool] = [:]
    
    
    enum QuestionKeys: String, CodingKey {
        case id
        case question
        case answer
        case wrong
        case book
        case hint
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.question = try container.decode(String.self, forKey: .question)
        self.book = try container.decode(Int.self, forKey: .book)
        self.hint = try container.decode(String.self, forKey: .hint)
        
        let correctAnswer = try container.decode(String.self , forKey: .answers)
        answers[correctAnswer] = true
        
        let wrongAnswers = try container.decode([String].self, forKey: .wrong)
        
        for answer in wrongAnswers {
            answers[answer] = false
        }
    }
}
