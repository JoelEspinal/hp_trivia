//
//  Instructions.swift
//  hp_trivia
//
//  Created by Joel Espinal on 4/11/24.
//

import SwiftUI

struct Instructions: View {
    var body: some View {
        ZStack {
            InfoBacogroundImage()
            VStack {
                Image("appiconwithradius")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.top)
                ScrollView {
                    Text("How to play")
                        .font(.largeTitle)
                        .padding()
                    VStack(alignment: .leading){
                        Text("Welcom to HP trivia 😅")
                        .padding([.horizontal, .bottom])
                        Text("More text 🥲")
                            .padding([.horizontal, .bottom])
                        Text("More play conditions and hint 🤨")
                            .padding([.horizontal, .bottom])
                        Text("Last message")
                            .padding(.horizontal)
                    }
                    Text("Good luck 🥳")
                }
            }
        }
    }
}

struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        Instructions()
    }
}
