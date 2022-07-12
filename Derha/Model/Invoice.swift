//
//  Invoice.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 13/11/1443 AH.
//

import Foundation

struct Invoice: Identifiable{
    let id: String
    let storeId: String
    let orderInfo: String
    let receivedAmount: Double
    let leftAmount: Double
    let deservedAmount: Double
    let subTotal: Double
    let tax: Double
    
    init(dictionary: [String: Any]) {
        
        self.id = dictionary[Invoice.id] as? String ?? ""
        self.storeId = dictionary[Invoice.storeId] as? String ?? ""
        self.orderInfo = dictionary[Invoice.orderInfo] as? String ?? ""
        self.receivedAmount = dictionary[Invoice.receivedAmount] as? Double ?? 0.0
        self.leftAmount = dictionary[Invoice.leftAmount] as? Double ?? 0.0
        self.deservedAmount = dictionary[Invoice.deservedAmount] as? Double ?? 0.0
        self.subTotal = dictionary[Invoice.subTotal] as? Double ?? 0.0
        self.tax = dictionary[Invoice.tax] as? Double ?? 0.0
    }
    
    
    static let order :Order = Order(dictionary: [Invoice.id: "123",
                                                 Invoice.storeId: "1234",
                                                 Invoice.orderInfo: "1234",
                                                 Invoice.receivedAmount: 0.0,
                                                 Invoice.leftAmount: 0.0,
                                                 Invoice.deservedAmount: 0.0,
                                                 Invoice.invoiceRef: "12345",
                                                 Invoice.subTotal: 0.0,
                                                 Invoice.tax: 0.0
                                                ])
    
    static let id = "id"
    static let storeId = "storeId"
    static let orderInfo = "orderInfo"
    static let receivedAmount = "receivedAmount"
    static let leftAmount = "leftAmount"
    static let deservedAmount = "deservedAmount"
    static let invoiceRef = "invoiceRef"
    static let subTotal = "subTotal"
    static let tax = "tax"
    
}
