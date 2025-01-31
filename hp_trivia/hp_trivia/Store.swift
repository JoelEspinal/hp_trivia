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
    @Published var purchasedIDs = Set<String>()
    
    private var productIDs = ["hp4", "hp5", "hp6", "hp7"]
    
    private var updates: Task<Void, Never>? = nil
    
    init() {
        updates = watchForUpdates()
    }
    
    func loadProducrs() async {
        do {
            let results = try await Product.products(for: productIDs)
            products = results
        }
        catch {
            print("Couldn't fetch those products: \(error)")
            
        }
    }
    
    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verificationResult):
                switch verificationResult {
                case .verified:
                    print("Product purchased!")
                    
                case .unverified(let signedType, let verificationError):
                    print("Error on: \(signedType): \(verificationError)")
                    
                case .verified(let signedType):
                    purchasedIDs.insert(signedType.productID)
                    
                }
            case .userCancelled:
                break
                
            case .pending:
                break
            @unknown default:
                break
            }
        } catch {
            print("Couldn't purchase the product: \(error)")
        }
    }
    
    private func checkProducs() async {
        for product in products {
            guard let state = await product.currentEntitlement else { return }
            
            switch state {
            case .unverified(let signedType, let verificationError):
                print("Eror on \(signedType): \(verificationError)")
            case .verified(let singnedType):
                if singnedType.revocationDate == nil {
                    purchasedIDs.insert(singnedType.productID)
                }
                else {
                    purchasedIDs.remove(singnedType.productID)
                }
            }
        }
    }
    
    private func watchForUpdates() -> Task<Void, Never> {
        Task(priority: .background){
          for await _ in Transaction.updates {
                await self.checkProducs()
            }
        }
    }
}
    
