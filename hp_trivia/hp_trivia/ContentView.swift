//
//  ContentView.swift
//  hp_trivia
//
//  Created by Joel Espinal on 27/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var scalePlayButton = false
    @State private var moveBackgroundImage = false
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height)
                    .padding(.top, 3)
                    .offset(x: moveBackgroundImage ?
                            geo.size.width * 1.1 :
                            -geo.size.width * 1.1)
                    .onAppear {
                        withAnimation(.linear(duration: 60).repeatForever()) {
                            moveBackgroundImage.toggle()
                        }
                    }
            }
            
            Spacer()
            
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
                
                VStack {
                    Text("Recent Score").colorInvert()
                        .font(.title2)
                    Text("text1")
                    Text("text2")
                    Text("text3")
                }
                .font(.title3)
                .padding(.horizontal)
                .foregroundColor(.white)
                .background(.gray.opacity(0.7))
                .cornerRadius(15)
                HStack {
                    
                    Spacer()
                    
                    Button {
                        // show instructios screen
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                    }
                    
                    Spacer()
                    
                    Button() {
                        // start a new game
                    } label: {
                        Text("Play")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 50)
                            .background(.brown)
                            .cornerRadius(7)
                            .shadow(radius: 5)
                    }
                    .scaleEffect(scalePlayButton ? 1.2 : 1)
                    .onAppear{
                        withAnimation(.easeIn(duration: 0.3).repeatForever()){
                            scalePlayButton.toggle()
                            
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                    }
                    
                    
                    Spacer()
                    
                }
//                .frame(width: geo.size.width)
            }
//            .frame(width: geo.size.width, height: geo.size.height)
        } .ignoresSafeArea()
    }
}
        
        //#Preview {
        //    ContentView()
        //}
        
    
