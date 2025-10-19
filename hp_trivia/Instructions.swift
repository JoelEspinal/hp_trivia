//
//  Instructions.swift
//  hp_trivia
//
//  Created by Joel Espinal on 4/11/24.
//

import Foundation
import SwiftUI



struct Instructions: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                InfoBackgroundImage()
            }
            
            VStack {
                Image("appiconwithradius")
                .renderingMode(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 150)
                .padding(.top)
                VStack {
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
                        .font(.title3)
                        Text("Good luck! 🥳")
                            .font(.title)
                    }
                    
                }
                Button("Done") {
                    dismiss()
                }
                .font(.largeTitle)
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .foregroundColor(.white)
            }
        }
    }
}

struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        Instructions()
    }
}
