//
//  Store.swift
//  hp_trivia
//
//  Created by Joel Espinal on 29/1/25.
//


import Foundation


enum BookStatus {
    case active
    case inactive
    case locked
}



@MainActor
class Store: ObservableObject {
    @Published var books: [BookStatus] = [.active, .active, .inactive,
                                      .locked, .locked, .locked, .locked]
    
}
