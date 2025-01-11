//
//  GamePlay.swift
//  hp_trivia
//
//  Created by Joel Espinal on 15/11/24.
//

import Foundation
import SwiftUI
import AVKit



struct GamePlay: View {
    
    @Environment(\.dismiss) private var dismiss
    @Namespace private var namespace
    @State private var musicPlayer: AVAudioPlayer!
    @State private var sfxPlayer: AVAudioPlayer!
    @State private var animateViewIn = false
    @State private var tappedCorrectAnswer = false
    @State private var hintWiggle = false
    @State private var scaleNextButton = false
    @State private var movePointsToScore = false
    @State private var revealHint = false
    @State private var revealBook = false
    @State private var wrongAnswerTapped: [Int] = []
    
    let tempAnswers = [true, false, false, false]
    
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
                    dismiss()
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
                            .opacity(tappedCorrectAnswer ? 0.1 : 1)
                    }
                }
                .animation(.easeInOut(duration: animateViewIn ? 2 : 0), value: animateViewIn)
                
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
                                .rotationEffect(.degrees(hintWiggle ? -13 : -17))
                                .padding()
                                .padding(.trailing, 20)
                                .transition(.offset(x: -geo.size.width/2))
                                .onAppear {
                                    withAnimation(
                                        .easeInOut(duration: 0.1)
                                        .repeatCount(9)
                                        .delay(5)
                                        .repeatForever()){
                                            hintWiggle = true
                                        }
                                }
                                .onTapGesture {
                                    withAnimation(.easeOut(duration: 1)) {
                                        revealHint =  true
                                    }
                                }
                                .rotation3DEffect(.degrees(revealHint ? 1440 : 0), axis: (x: 0, y: 1, z: 0))
                                .scaleEffect(revealHint ? 5 : 1)
                                .opacity(revealHint ? 0 : 1)
                                .offset(x: revealHint ? geo.size.width/2 : 0)
                                .overlay(
                                    Text("The boy who ___")
                                        .padding(.leading, 33)
                                        .minimumScaleFactor(0.5)
                                        .multilineTextAlignment(.center)
                                        .opacity(revealHint ? 1 : 0)
                                        .scaleEffect(revealHint ? 1.33 : 1)
                                    
                                )
                                .opacity(tappedCorrectAnswer ? 0.1 : 1)
                                .disabled(tappedCorrectAnswer)
                        }
                    }
                    .animation(.easeOut(duration: animateViewIn ? 1.5 : 0).delay(animateViewIn ? 2 : 0), value: animateViewIn)
                    
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
                                .rotationEffect(.degrees(hintWiggle ? 13 : 17))
                                .padding()
                                .padding(.trailing, 20)
                                .transition(.offset(x: geo.size.width/2))
                                .onAppear {
                                    withAnimation(
                                        .easeInOut(duration: 0.1)
                                        .repeatCount(9)
                                        .delay(5)
                                        .repeatForever()){
                                            hintWiggle = true
                                        }
                                }
                                .onTapGesture {
                                    withAnimation(.easeOut(duration: 1)) {
                                        revealBook =  true
                                    }
                                }
                                .rotation3DEffect(
                                    .degrees(revealBook ? 1440 : 0), axis: (x: 0, y: 1, z: 0))
                                .scaleEffect(revealBook ? 5 : 1)
                                .opacity(revealBook ? 0 : 1)
                                .offset(x: revealBook ? geo.size.width/2 : 0)
                                .overlay(
                                    Image("hp1")
                                    .renderingMode(.original)
                                    .resizable()
                                        .scaledToFit()
                                        .padding(.trailing, 33)
                                        .opacity(revealBook ? 1 : 0)
                                        .scaleEffect(revealBook ? 1.33 : 1)
                                )
                            
                            .opacity(tappedCorrectAnswer ? 0.1 : 1)
                            .disabled(tappedCorrectAnswer)
                        }
                        
                    }
                    .animation(.easeOut(duration: animateViewIn ? 1.5 : 0).delay(animateViewIn ? 2 : 0), value: animateViewIn)
                    
                }
                .padding(.bottom)
                
                // MARK: Answers
                LazyVGrid(columns: [GridItem(alignment: .leading), GridItem()]){
                    ForEach(1..<5) { i in
                        if tempAnswers[i-1] == true {
                            VStack {
                                if animateViewIn {
                                    if tappedCorrectAnswer == false {
                                        Text("Answer \(i)")
                                            .multilineTextAlignment(.center)
                                            .padding(10)
                                            .frame(width: geo.size.width/2.15,
                                                   height: 80)
                                            .background(.green.opacity(0.5))
                                            .cornerRadius(25)
                                        
                                            .transition(.asymmetric(insertion: .scale, removal:
                                                    .scale(scale: 0.5).combined(with:  .opacity.animation(.easeOut(duration: 0.5)))))
                                        
                                            .matchedGeometryEffect(id: "answer", in: namespace)
                                            .onTapGesture {
                                                withAnimation(.easeOut(duration: 1)) {
                                                    tappedCorrectAnswer = true
                                                }
                                            }
                                    }
                                }
                            }
                            .animation(
                                .easeOut(duration: animateViewIn ? 1 : 0)
                                .delay(animateViewIn ? 1.5 : 0), value: animateViewIn)
                        } else {
                            VStack {
                                Text("Answer \(i)")
                                    .minimumScaleFactor(0.5)
                                    .multilineTextAlignment(.center)
                                    .padding(10)
                                    .frame(width: geo.size.width/2.15,
                                           height: 80)
                                
                                    .background(wrongAnswerTapped.contains(i) ? .red.opacity(0.5) : .green.opacity(0.5))
                                    .cornerRadius(25)
                                    .transition(.scale)
                                    .onTapGesture {
                                        withAnimation(.easeOut(duration: 1)){
                                            wrongAnswerTapped.append(i)
                                        }
                                    }
                                    .scaleEffect(wrongAnswerTapped.contains(i) ? 0.8 : 1)
                                    .disabled(tappedCorrectAnswer || wrongAnswerTapped.contains(i))
                                    .opacity(tappedCorrectAnswer ? 0.1 : 1)
                            }
                            .animation(
                                .easeOut(duration: animateViewIn ? 1 : 0)
                                .delay(animateViewIn ? 1.5 : 0), value: animateViewIn)
                        }
                    }
                }
                
              
                // MARK: Celebration
                VStack {
                    
                    Spacer()
                    
                    VStack{
                        if tappedCorrectAnswer {
                            Text("5")
                                .font(.largeTitle)
                                .padding(.top, 50)
                                .transition(.offset(y: -geo.size.height/4))
                                .offset(x: movePointsToScore ? geo.size.width/2.3 : 0,
                                        y: movePointsToScore ? -geo.size.height/13 : 0)
                                .opacity(movePointsToScore ? 0 : 1)
                                .onAppear {
                                    withAnimation(
                                        .easeInOut(
                                            duration: 1).delay(3)) {
                                                movePointsToScore = true
                                            }
                                }
                            
                        }
                    }
                    .animation(.easeInOut(duration: 1).delay(2), value: tappedCorrectAnswer)
                    
                    Spacer()
                    
                    VStack {
                        if tappedCorrectAnswer {
                            Text("Brilliant!")
                                .font(.custom(Constans.hpFont, size: 100))
                                .transition(.scale.combined(with: .offset(y: -geo.size.height/2)))
                        }
                    }
                    .animation(.easeInOut(duration: tappedCorrectAnswer ? 1 : 0).delay(tappedCorrectAnswer ? 1 : 0), value: tappedCorrectAnswer)
                        
                    Spacer()
                    
                    if tappedCorrectAnswer {
                        Text("Answer 1")
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .frame(width: geo.size.width / 2.15, height: 80)
                            .background(.green.opacity(0.5))
                            .cornerRadius(25)
                            .scaleEffect(2)
                            .matchedTransitionSource(id: "answer", in: namespace)
                    }
                    
                    Group {
                        Spacer()
                        Spacer()
                    }
                    
                    VStack {
                        if tappedCorrectAnswer {
                            Button("New Level>"){
                                animateViewIn = false
                                tappedCorrectAnswer = false
                                revealHint = false
                                revealBook = false
                                movePointsToScore = false
                                wrongAnswerTapped = []
                                
                                DispatchQueue.main
                                    .asyncAfter(deadline: .now() + 0.5) {
                                        animateViewIn = true
                                    }
                                
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.blue.opacity(0.5))
                            .font(.largeTitle)
                            .transition(.offset(y: geo.size.height/3))
                            .scaleEffect(scaleNextButton ? 1.2 : 1)
                            .onAppear{
                                withAnimation(.easeIn(duration: 0.3).repeatForever()){
                                    scaleNextButton.toggle()
                                }
                            }
                        }
                    }
                    .animation(.easeInOut(duration: tappedCorrectAnswer ? 2.7 : 0).delay(tappedCorrectAnswer ? 2.7 : 0), value: tappedCorrectAnswer)
                    
                    
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
          animateViewIn = true
          playMusic()
        }
    }
    
    
    private func playMusic() {
        let songs = ["hiding-place-in-the-forest", "deep-in-the-dell", "let-the-mystery-unfold", "let-the-mystery-unfold"]
        
        let i = Int.random(in: 0...3)
        
        let sound = Bundle.main.path(forResource: songs[i], ofType: "mp3")
        musicPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        musicPlayer.volume = 0.1
        musicPlayer.numberOfLoops = -1
        musicPlayer.play()
    }
}

struct GamePlay_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GamePlay()
        }
    }
}
