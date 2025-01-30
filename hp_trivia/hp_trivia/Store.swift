//
//  Store.swift
//  hp_trivia
//
//  Created by Joel Espinal on 29/1/25.
//


import Foundation
import StoreKit

enum BookStatus {
    case active
    case inactive
    case locked
}



@MainActor
class Store: ObservableObject {
    @Published var books: [BookStatus] = [.active, .active, .inactive,
                                      .locked, .locked, .locked, .locked]
    
    @Published var products: [Product] = []
    
    private var productIDs = ["hp4", "hp5", "hp6", "hp7"]
    
    func loadProducrs() async {
        do {
            products = try await Product.products(for: productIDs)
        } catch {
            print("Couldn't fetch those products: \(error)")
        }
            
    }
}
    
