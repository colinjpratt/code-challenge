//
//  VendingItem.swift
//  Vending
//
//  Created by Colin on 5/12/20.
//  Copyright © 2020 Colin. All rights reserved.
//
/**
 Represents a purchable item
 */
import UIKit

protocol Vendable: Codable{
    var imageName: String { get }
    var name: String { get }
    var price: Double { get }
    var quantity: Int { get }
    
    func getDisplayablePrice() -> String
    func getDisplayableQuantity() -> String
    func purchased()
}

class VendingItem: Vendable, NSCoding {
    
    var imageName: String = ""
    var name: String = ""
    var price: Double = 0.0
    var quantity: Int = 0 
    
    init(imageName: String, name: String, price: Double, quantity: Int) {
        self.imageName = imageName
        self.name = name
        self.price = price
        self.quantity = quantity
    }
    
    required convenience init(coder: NSCoder) {
        let imageName = coder.decodeObject(forKey: "imageName") as! String
        let name = coder.decodeObject(forKey: "name") as! String
        let price = coder.decodeDouble(forKey: "price")
        let quantity = coder.decodeInteger(forKey: "quantity")
        self.init(imageName: imageName, name: name, price: price, quantity: quantity)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(imageName, forKey: "imageName")
        coder.encode(name, forKey: "name")
        coder.encode(price, forKey: "price")
        coder.encode(quantity, forKey: "quantity")
    }

    func getDisplayablePrice() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency

        return formatter.string(from: price as NSNumber) ?? "Error"
    }
    
    func getDisplayableQuantity() -> String {
        return "\(quantity) left"
    }
    
    func purchased() {
        quantity -= 1
    }
    
        
}
