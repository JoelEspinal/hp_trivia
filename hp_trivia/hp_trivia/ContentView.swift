//
//  ContentView.swift
//  hp_trivia
//
//  Created by Joel Espinal on 27/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height)
                    .padding(.top, 3)
                
                VStack {
                    VStack {
                        Image(systemName: "bolt.fill")
                            .font(.largeTitle)
                            .imageScale(.large)
                            .colorInvert()
                        Text("HP")
                            .font(.custom(Constans.hpFont, size: 70))
                            .colorInvert()
                            .padding(.bottom, -50)
                        Text("Trivia")
                            .font(.custom(Constans.hpFont, size: 60))
                            .colorInvert()
                    }
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
