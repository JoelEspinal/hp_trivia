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
    @EnvironmentObject private var store: Store


var body: some View {
ZStack {
    InfoBackgroundImage()
VStack {
    Text ("Witch books would you like to see question from?")
        .font(.title)
        .multilineTextAlignment(.center)
        .padding(.top)
    ScrollView {
        LazyVGrid(columns: [GridItem(), GridItem()]){
            ForEach(1 ..< 7) { i in
                
                if store.books[i] == .active
                    || (store.books[i] == .locked && store.purchasedIDs.contains("hp\(i+1)"))
                {
                    ZStack(alignment: .bottomTrailing) {
                        Image("hp\(i+1)")
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
                    .task {
                        store.books[i] = .active
                        store.saveStatus()
                    }
                    .onTapGesture {
                        store.books[i] = .inactive
                        store.saveStatus()
                    }
                } else if store.books[i] == .inactive {
                        ZStack(alignment: .bottomTrailing) {
                            Image("hp\(i+1)")
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
                        
                    .onTapGesture {
                        store.books[i] = .active
                        store.saveStatus()
                    }
                    } else {
                        ZStack {
                            Image("hp\(i+1)")
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
                        .onTapGesture {
                            let product = store.products[i-3]
                            
                            Task {
                                await
                                store
                                .purchase(product)
                            }
                        }
                    }
                }
            }
        }
    }
    .padding()
    }
    
    Button("Done") {
        dismiss()
    }
        .doneButton()
    }
//    .foregroundColor(.black)

}

#Preview {
    Settings().environmentObject(Store())
}
