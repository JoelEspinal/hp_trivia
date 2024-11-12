//
//  ContentView.swift
//  hp_trivia
//
//  Created by Joel Espinal on 27/10/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!
    @State private var scalePlayButton = false
    @State private var moveBackgroundImage = false
    @State private var animateViewsIn = false
    @State private var showInstruction = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .renderingMode(.none)
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
            
            VStack {
                VStack {
                    if animateViewsIn {
                        Button {
                            showInstruction.toggle()
                        } label: {
                            Image(systemName: "bolt.fill")
                                .font(.largeTitle)
                                .imageScale(.large)
                                .colorInvert()
                        }
                        VStack {
                            Text("HP")
                                .font(.custom(Constans.hpFont, size: 70))
                                .colorInvert()
                                .padding(.bottom, -50)
                            Text("Trivia")
                                .font(.custom(Constans.hpFont, size: 60))
                                .colorInvert()
                        }
                        .padding(.top, 70)
                        .transition(.move(edge: .top))
                    }
                }.animation(.easeOut(duration: 0.7).delay(2), value: animateViewsIn)
                
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
                .transition(.opacity)
                HStack {
//                    VStack {
//                        if showInstruction {
//                            Button {
//                                showInstruction.toggle()
//                            }
//                            label: {
//                                Image(systemName: "info.circle.fill")
//                                    .font(.largeTitle)
//                                    .foregroundStyle(.white)
//                                    .shadow(radius: 5)
//                            }
//                            .scaleEffect(scalePlayButton ? 1.2 : 1)
//                            .sheet(isPresented: $showInstruction) {
//                                Instructions()
//                            }
//                        }
//                        
//                    }
//                    .scaleEffect(scalePlayButton ? 1.2 : 1)
//                    .onAppear{
//                        withAnimation(.easeIn(duration: 0.3).repeatForever()){
//                            scalePlayButton.toggle()
//                        }
//                    }
//                    .transition(.offset(y: geo.size.height / 3))
//                    
//                    
                    
                    
                    
                    //
                    
                    //.animation(.easeOut(duration: 0.7).delay(2.7))
                    //.withAnimation(Animation.easeOut(duration: 0.7).delay(2.7))
                    
//                    
                    Spacer()
                    
                    VStack {
                        if animateViewsIn {
                            Button {
                                animateViewsIn.toggle()
                            } label: {
                                Image(systemName: "info.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .shadow(radius: 5)
                            }
                          .transition(.offset(x: -geo.size.width / 4))
                        }
                    }
                    .animation(.easeOut(duration: 0.7).delay(0.7), value: animateViewsIn)
                    .sheet(isPresented: $showInstruction) {
                        Instructions()
                    }
                    
                    Spacer()
                    
                    VStack {
                        if animateViewsIn {
                            
                            Button() {
                                showInstruction.toggle()
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
                            .transition(.offset(y: geo.size.height / 3))
                            //
                            //                        }.animation(.easeOut(duration: 0.7).delay(2), value: animateViewsIn)
                            
                            //                            }
                            //                            .animation(.easeOut(duration: 0.7).delay(2))
                        }
                        
                    }.animation(.easeOut(duration: 0.7).delay(2), value: animateViewsIn)
                    
                    Spacer()
                    
                    
                    VStack {
                        if animateViewsIn {
                            Button {
                                
                            } label: {
                                Image(systemName: "gearshape.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                            }
                            .transition(.offset(x: geo.size.width / 4))
                        }
                    }.animation(.easeOut(duration: 0.7).delay(2), value: animateViewsIn)
                    
                    Spacer()
                    
                }
//                .frame(width: geo.size.width)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        } .ignoresSafeArea()
        .onAppear() {
            animateViewsIn = true
            //                playAudio()
            }
    }
    
    private func playAudio() {
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
}

#Preview {
    ContentView()
}


