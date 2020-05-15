//
//  VendingMachinePresenter.swift
//  VendingMachine
//
//  Created by Colin on 5/14/20.
//  Copyright © 2020 Colin. All rights reserved.
//

/**
 This class is a presenter for the ViewController Class
 It functions to contain all the business logic for the view
 */

import UIKit
import Swinject

protocol VendingMachinePresentable {
    associatedtype itemType
    func numberOfItems() -> Int
    func item(for row: Int) -> itemType
    func makePurchase(_ item: itemType?)
    func addFunds(_ funds: String)
}

class VendingMachinePresenter<T: Vender>: VendingMachinePresentable {
    typealias itemType = Vendable
    
    private weak var view: VendingMachineView!
    private var machine: T!
    private var wallet: Spendable!
    
    init(view: VendingMachineView) {
        self.view = view
        machine = Container.shared.resolve()
        wallet = Container.shared.resolve()
        view.updateFundsText(wallet.displayableValue())
    }
    
    func numberOfItems() -> Int {
        return machine.items.count
    }
    
    func item(for row: Int) -> Vendable {
        return machine.items[row]
    }
    
    func makePurchase(_ item: Vendable?) {
        guard let item = item else { return }
        let status = machine.purchaseMade(for: item, wallet: wallet)
        switch status {
        case .normal:
            view.updateFundsText(wallet.displayableValue())
            view.needsReload()
        case .outOfFunds:
            view.displayError("Insufficient Funds")
        case .outOfItems:
            view.displayError("Out Of Item: \(item.name)")
        case .outOfOrder:
            view.displayError("Out Of Order")
        case .serviceNeeded(let code):
            view.displayError("Error \(code): Please contact servicer")
        }
    }
    
    func addFunds(_ funds: String) {
        guard let funds = Double(funds) else {
            return
        }
        wallet.addFunds(funds: funds)
        view.updateFundsText(wallet.displayableValue())
    }
}
