//
//  OrderItems.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 10/11/1443 AH.
//

import Foundation
class OrderItem: Identifiable, ObservableObject {
    
    @Published var  id: String
    @Published var itemNameAR: String
    @Published var itemNameEng: String
    @Published var productId: String
    @Published var quantity: Double = 0.0
    @Published var priceForEachItem: Double = 0.0
    
    
    init(dictionary: [String: Any]) {
        self.id = dictionary[OrderItem.id] as? String ?? ""
        self.itemNameAR = dictionary[OrderItem.itemNameAR] as? String ?? ""
        self.itemNameEng = dictionary[OrderItem.itemNameEng] as? String ?? ""
        self.productId = dictionary[OrderItem.productId] as? String ?? ""
        self.quantity = dictionary[OrderItem.productId] as? Double ?? 1
        self.priceForEachItem = dictionary[OrderItem.priceForEachItem] as? Double ?? 0.0
    }
    
    
    static let id = "id"
    static let itemNameAR = "itemNameAR"
    static let itemNameEng = "itemNameEng"
    static let productId = "productId"
    static let quantity = "quantity"
    static let priceForEachItem = "priceForEachItem"
    
}
