//
//  Wallet.swift
//  Vending
//
//  Created by Colin on 5/12/20.
//  Copyright © 2020 Colin. All rights reserved.
//

/**
 Wallet Class
 Stores and retrieves money loaded into your account
 */

import UIKit

@propertyWrapper
struct StateSaveable<T: Codable> {
    
    private let key: String
    private var initialValue: T
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    var store: UserDefaults = .standard
    
    init(key: String, initialValue: T) {
        self.key = key
        self.initialValue = initialValue
    }
    
    var wrappedValue: T {
        get {
            guard let retrieved = store.value(forKey: key) as? T else {
                return initialValue
            }
            return retrieved
        }
        set {
            store.set(newValue, forKey: key)
            initialValue = newValue
        }
    }
}

protocol Spendable {
    var value: Double { get }
    func displayableValue() -> String
    func purcased(price: Double)
    func addFunds(funds: Double)
}


class Wallet<T: Vendable>: Spendable {
    typealias storageItemType = T
    
    @StateSaveable(key: "cash", initialValue: 0.0)
    private(set) var value: Double
    
    func displayableValue() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency

        return formatter.string(from: value as NSNumber) ?? "Error"
    }

    func purcased(price: Double) {
        value -= price
    }
    
    func addFunds(funds: Double) {
        value += funds
    }
}
