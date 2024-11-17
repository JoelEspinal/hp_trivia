//
//  GamePlay.swift
//  hp_trivia
//
//  Created by Joel Espinal on 15/11/24.
//

import Foundation
import SwiftUI



struct GamePlay: View {
    @State private var animateViewIn = false
    
var body: some View {
    GeometryReader { geo in
        ZStack {
            Image("hogwarts")
                .renderingMode(.none)
                .resizable()
                .frame(width: geo.size.width * 3, height: geo.size.height * 1.05)
                .overlay(Rectangle().foregroundColor(Color.black.opacity(0.8)))
            VStack {
                // MARK: Controls
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
            .padding(.vertical, 30)
                
                //MARK: Question
                VStack {
                    if animateViewIn {
                        Text("Who is Harry Potter?")
                            .font(.custom(Constans.hpFont, size: 50))
                            .multilineTextAlignment(.center)
                            .padding()
                            .transition(.scale)
                    }
                }
                .animation(.easeInOut(duration: 2), value: animateViewIn)
                
                Spacer()
                
                // MARK: Question Hints
                HStack {
                    VStack {
                        if animateViewIn {
                            Image(systemName: "questionmark.app.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .foregroundColor(.cyan)
                                .rotationEffect(.degrees(-15))
                                .padding()
                                .padding(.trailing, 20)
                                .transition(.offset(x: -geo.size.width/2))
                        }
                    }
                    .animation(.easeOut(duration: 1.5).delay(2), value: animateViewIn)
                    
                    VStack{
                        if animateViewIn {
                            Image(systemName: "book.closed")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                                .foregroundColor(.black)
                                .frame(width: 100, height: 100)
                                .background(.cyan)
                                .cornerRadius(20)
                                .rotationEffect(.degrees(15))
                                .padding()
                                .padding(.trailing, 20)
                                .transition(.offset(x: geo.size.width/2))
                        }
                    }
                    .animation(.easeOut(duration: 1.5).delay(2), value: animateViewIn)
                    
                }
                .padding(.bottom)
                
                // MARK: Answers
                LazyVGrid(columns: [GridItem(alignment: .leading), GridItem()]){
                    ForEach(1..<5) { i in
                        VStack {
                            if animateViewIn {
                                
                                Text("Answer \(i)")
                                    .multilineTextAlignment(.center)
                                    .padding(10)
                                    .frame(width: geo.size.width/2.15,
                                           height: 80)
                                    .background(.green.opacity(0.5))
                                    .cornerRadius(25)
                                    .transition(.scale)
                            }
                        }
                        .animation(.easeOut(duration: 1).delay(1.5), value: animateViewIn)
                    }
                }
                
              
                // MARK: Celebration
                VStack {
                    Spacer()
                    
                    Text("5")
                        .font(.largeTitle)
                        .padding(.top, 50)
                    
                    Spacer()
                    
                    Text("Brilliant!")
                        .font(.custom(Constans.hpFont, size: 100))
                    
                    Spacer()
                    
                    Text("Answer 1")
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .frame(width: geo.size.width / 2.15, height: 80)
                        .background(.green.opacity(0.5))
                        .cornerRadius(25)
                        .scaleEffect(2)
                    
                    Group {
                        Spacer()
                        Spacer()
                    }
                    
                    Button("New Level>"){
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue.opacity(0.5))
                    .font(.largeTitle)
                    
                    Group {
                        Spacer()
                        Spacer()
                    }
                    
                }
                .foregroundColor(.white)
                .font(.largeTitle)
                
                Spacer()
        }
            .frame(width: geo.size.width, height: geo.size.height)
            .foregroundColor(.white)
        }
        .frame(width: geo.size.width, height: geo.size.height)
    }
        .ignoresSafeArea()
        .onAppear() {
//            animateViewIn = true
        }
    }
}

struct GamePlay_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GamePlay()
        }
    }
}
