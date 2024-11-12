//
//  Settings.swift
//  hp_trivia
//
//  Created by Joel Espinal on 12/11/24.
//

import Foundation
import SwiftUI


struct Settings: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            InfoBackgroundImage()
            
            VStack {
                
                Text ("Witch books would you like to see question from?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()]){
                        ZStack(alignment: .bottomTrailing) {
                            Image("hp1")
                                .renderingMode(.none)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 7)
                            
                            Image(systemName: "checkmark.circle.fill")
                                .font(.largeTitle)
                                .imageScale(.large)
                                .foregroundColor(Color.green)
                                .shadow(radius: 1)
                                .padding(3)
                        }
                        ZStack(alignment: .bottomTrailing) {
                            Image("hp2")
                                .renderingMode(.none)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 7)
                            
                                .overlay(Rectangle().opacity(0.33))
                                
                            Image(systemName: "circle")
                                .font(.largeTitle)
                                .foregroundColor(.green.opacity(0.5))
                                .shadow(radius: 1)
                                .padding(3)
                            
                        }
                        
                        
                        ZStack {
                            Image("hp3")
                                .renderingMode(.none)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 7)
                            
                                .overlay(Rectangle().opacity(0.75))
                                
                            Image(systemName: "lock.fill")
                                .font(.largeTitle)
                                .imageScale(.large)
                                .shadow(color: .white.opacity(0.75), radius: 1)
                               
                        }
                    }
                    .padding()
                }
                
                Button("Done") {
                }
                .doneButton()
            }
        }
    }
}

#Preview {
    Settings()
}
    
