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
            HStack {
                Button("End Game") {
                    // TODO: End Game
                }
                .buttonStyle(.borderedProminent)
                .tint(.red.opacity(0.5))
                
                Spacer()
                
                Text("Score: 33")
            }
            .padding()
                
            Text("Who is Harry Potter?")
                    .font(.custom(Constans.hpFont, size: 50))
                HStack {
                    Image(systemName: "questionmark.app.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .foregroundColor(.cyan)
                        .rotationEffect(.degrees(-15))
                }
        }
            .frame(width: geo.size.width, height: geo.size.height)
            .foregroundColor(.white)
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
