//
//  Inventory.swift
//  Vending
//
//  Created by Colin on 5/13/20.
//  Copyright © 2020 Colin. All rights reserved.
//

import UIKit

class Inventory<T: Vendable> {
    
    typealias storageItemType = VendingItem
    var inventory: [storageItemType] = []
    
    func syncInventory() {
        UserDefaults.standard.synchronize()
    }
    
    static func createInitialInventory<T: Vendable>() -> [T] {
        var returnItems: [T] = []
        if let path = Bundle.main.path(forResource: "Items", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let items = try decoder.decode([T].self, from: data)
                returnItems = items
              } catch {
                   // handle error
                print(error)
              }
        }
        return returnItems
    }
}
