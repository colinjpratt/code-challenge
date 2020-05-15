//
//  VendingMachine.swift
//  Vending
//
//  Created by Colin on 5/12/20.
//  Copyright © 2020 Colin. All rights reserved.
//

import UIKit

enum ErrorCode {
    case malfunction
    case changeEmpty
    case changeFull
    case jamAt(Int)
}

enum StatusCode {
    case normal
    case outOfFunds
    case outOfItems
    case serviceNeeded(ErrorCode)
    case outOfOrder
}

protocol Vender: Identifiable {
    var items: [Vendable] {get}
    var statusCode: StatusCode {get}
    func purchaseMade(for item: Vendable, wallet: Spendable) -> StatusCode
}

class VendingMachine: Vender {
    
    private(set) var items: [Vendable] = []
    private(set) var statusCode: StatusCode = .normal
    
    init(with inventory: Inventory<VendingItem>) {
        self.items = inventory.inventory
    }
    
    func purchaseMade(for item: Vendable, wallet: Spendable) -> StatusCode{
        if item.quantity < 1 {
            return .outOfItems
        }
        if wallet.value < item.price {
            return .outOfFunds
        }
        
        item.purchased()
        wallet.purcased(price: item.price)
        return .normal
    }
}
