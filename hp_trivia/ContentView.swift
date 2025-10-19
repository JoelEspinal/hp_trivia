    //
    //  ContentView.swift
    //  hp_trivia
    //
    //  Created by Joel Espinal on 27/10/24.
    //

    import SwiftUI
    import AVKit

struct ContentView: View {
    @EnvironmentObject private var store: Store
    @EnvironmentObject private var game: Game
    @State private var audioPlayer: AVAudioPlayer!
    @State private var scalePlayButton = false
    @State private var moveBackgroundImage = false
    @State private var animateViewsIn = false
    @State private var showInstruction = false
    @State private var showSettings = false
    @State private var playGame = false
    
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
                    .ignoresSafeArea()
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
                    Text("\(game.recentScore[0])")
                    Text("\(game.recentScore[1])")
                    Text("\(game.recentScore[2])")
                        .font(.title3)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .background(.gray.opacity(0.7))
                        .cornerRadius(15)
                        .transition(.opacity)
                    HStack {
                        Spacer()
                        
                        VStack {
                            if animateViewsIn {
                                Button {
                                    showInstruction.toggle()
                                } label: {
                                    Image(systemName: "info.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .shadow(radius: 5)
                                }
                                .transition(.offset(x: -geo.size.width / 4))
                                .animation(.easeOut(duration: 0.7).delay(0.7), value: animateViewsIn)
                                .sheet(isPresented: $showInstruction) {
                                    Instructions()
                                }
                            }
                        }
                        
                        Spacer()
                        
                        VStack {
                            if animateViewsIn {
                                Button() {
                                    filterQuestions()
                                    game.startGame()
                                    playGame.toggle()
                                    
                                    print("pressed")
                                    
                                } label: {
                                    Text("Play")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 7)
                                        .padding(.horizontal, 50)
                                        .background(store.books.contains(.active) ? .brown : .gray)
                                        .cornerRadius(7)
                                        .shadow(radius: 5)
                                }
                                .sheet(isPresented: $playGame) {
                                    //                                    Settings()
                                    //                                    Instructions()
                                    
                                    //                                    GamePlay(game: )
                                }
                                .scaleEffect(scalePlayButton ? 1.2 : 1)
                                .onAppear{
                                    withAnimation(.easeIn(duration: 0.3).repeatForever()){
                                        scalePlayButton.toggle()
                                    }
                                }
                                // .transition(.offset(y: geo.size.height / 3))
                                //
                                //                        }.animation(.easeOut(duration: 0.7).delay(2), value: animateViewsIn)
                                
                                //                            }
                                //                            .animation(.easeOut(duration: 0.7).delay(2))
                            }
                            
                        }//.animation(.easeOut(duration: 0.7).delay(2), value: animateViewsIn)
                        
                        Spacer()
                        
                        
                        VStack {
                            if animateViewsIn {
                                Button {
                                    showSettings.toggle()
                                }
                                label: {
                                    Image(systemName: "gearshape.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .shadow(radius: 5)
                                }
                                .transition(.offset(x: geo.size.width / 4))
                                .fullScreenCover(isPresented: $playGame) {
                                    GamePlay().environmentObject(store)
                                    //                                    Game().environmentObject(game)
                                    //                                    Settings().environmentObject(store)
                                        .onAppear {
                                            audioPlayer.setVolume(0, fadeDuration: 2)
                                        }
                                        .onDisappear {
                                            audioPlayer.setVolume(1, fadeDuration: 3)
                                        }
                                }
                                
                                .sheet(isPresented: $showSettings) {
                                    Settings().environmentObject(store)
                                    
                                }
                                .disabled(store.books.contains(.active) ? false : true)
                                
                            }
                        }
                        .animation(.easeOut(duration: 0.7).delay(2), value: animateViewsIn)
                        
                        Spacer()
                    }
                    .frame(width: geo.size.width)
                }
                .frame(width: geo.size.width, height: geo.size.height)
                
                VStack {
                    if animateViewsIn {
                        if store.books.contains(.active) == false {
                            Text("No questions avaliable. Go to setings.")
                                .multilineTextAlignment(.center)
                                .transition(.opacity)
                        }
                    }
                }
                .animation(.easeInOut.delay(3), value: animateViewsIn)
                
                Spacer()
            } .ignoresSafeArea()
                .onAppear() {
                    animateViewsIn = true
                    playAudio()
                }
        }
    }
    
    func playAudio() {
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
    
    private func filterQuestions() {
        var books: [Int] = []
        
        
        for (index, status) in store.books.enumerated() {
            if status == .active {
                books.append(index+1)
            }
        }
        
        game.filterQuestions(to: books)
        game.newQuestion()
    }
}

#Preview {
    ContentView()
        .environmentObject(Store())
        .environmentObject(Game())
}
