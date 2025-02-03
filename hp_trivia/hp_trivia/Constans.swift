//
//  Constans.swift
//  hp_trivia
//
//  Created by Joel Espinal on 29/10/24.
//      

import Foundation
import SwiftUI

final class Constans {
    
    static let sharedConstants: Constans = Constans()
    
    static let hpFont = "PartyLetPlain"
                                                
  
    var questions: [Question] = []
    var previewQuestion: Question!
    
    private init () {
        initQuestions()
    }
    
    func initQuestions() {
        let path =  Bundle.main.path(forResource: "trivia", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            questions = try JSONDecoder().decode([Question].self, from: Data(contentsOf: url))
            previewQuestion = questions[0]
        } catch {
            print(error)
        }
    }
}


    struct InfoBackgroundImage: View {
        var body: some View {
            Image("parchment")
                .renderingMode(.none)
                .resizable()
                .background(.brown)
                .ignoresSafeArea()
            
        }
    }
    
    extension Button {
        func doneButton() -> some View {
            self
                .font(.largeTitle)
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .foregroundColor(.white)
        }
    }

