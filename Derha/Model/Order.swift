//
//  Order.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 10/11/1443 AH.
//

import Foundation
import Firebase

struct Order: Identifiable{
    let id: String
    let total: Double
    let date: Timestamp
    let orderType: Int
    let paymentMethod: Int
    let items: Array<String>
    let items3: Array<OrderItem>
    let itemQuantityTotal: Int
    
    init(dictionary: [String: Any]) {
        self.id = dictionary[Order.id] as? String ?? ""
        self.total = dictionary[Order.total] as? Double ?? 0.0
        self.date = dictionary[Order.date] as? Timestamp ?? Timestamp(date: Date())
        self.orderType = dictionary[Order.orderType] as? Int ?? 0
        self.paymentMethod = dictionary[Order.paymentMethod] as? Int ?? 0
        self.items = dictionary[Order.items] as? Array<String> ?? [String]()
        self.items3 = dictionary[Order.items3] as? Array<OrderItem> ?? [OrderItem]()
        self.itemQuantityTotal = dictionary[Order.itemQuantityTotal] as? Int ?? 0
    }
    
    
    static let order :Order = Order(dictionary: [Order.id: "123",
                                                 Order.total: 0.0,
                                                 Order.date: Timestamp(date: Date()),
                                                 Order.orderType: 0,
                                                 Order.paymentMethod: 0,
                                                 Order.items: ["Milk", "water"],
                                                 Order.itemQuantityTotal: 0
                                                ])
    
    
    static let id = "id"
    static let total = "total"
    static let date = "date"
    static let orderType = "orderType"
    static let paymentMethod = "paymentMethod"
    static let items = "items"
    static let itemQuantityTotal = "itemQuantityTotal"
    static let items3 = "items3"

    
}
