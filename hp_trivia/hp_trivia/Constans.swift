//
//  Constans.swift
//  hp_trivia
//
//  Created by Joel Espinal on 29/10/24.
//      

import Foundation
import SwiftUI

enum Constans {
    static let hpFont = "PartyLetPlain"
    
    static let previewQuertion = try! JSONDecoder().decode([Question].self,
                                                           from: Data(contentsOf: Bundle.main.url(forResource: "trivia", withExtension: "json")!))[0]
    
    
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
