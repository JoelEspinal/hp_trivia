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
}

struct InfoBackgroundImage: View {
    var body: some View {
        Image("parchment")
        .renderingMode(.none)
        .resizable()
        .ignoresSafeArea()
        .background(.brown)
        
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
