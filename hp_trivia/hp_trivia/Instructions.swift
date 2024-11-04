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
                    .padding(.top: )
            }
        }
    }
}

struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        Instructions()
    }
}
