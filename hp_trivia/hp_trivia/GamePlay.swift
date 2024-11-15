//
//  GamePlay.swift
//  hp_trivia
//
//  Created by Joel Espinal on 15/11/24.
//

import Foundation
import SwiftUI



struct GamePlay: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .renderingMode(.none)
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height * 1.05)
                   .overlay(Rectangle().foregroundColor(Color.black.opacity(0.8)))
                VStack {
                    
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }.ignoresSafeArea()
    }
}

struct GamePlay_Previews: PreviewProvider {
    static var previews: some View {
        GamePlay()
    }
}
