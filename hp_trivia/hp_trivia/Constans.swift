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

struct InfoBacogroundImage: View {
    var body: some View {
        Image("parchment")
        .resizable()
        .ignoresSafeArea()
        .background(.brown)
    }
}
