//
//  Store.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 23/11/1443 AH.
//

import Foundation
import Firebase

struct Store {
    
    let StoreID: String
    let address: String
    let storeName: String
    let storePhoneNumber: String
    let taxNumber: String
    
    
    init(dictionary: [String: Any]) {
        self.StoreID = dictionary[Store.StoreID] as? String ?? ""
        self.address = dictionary[Store.address] as? String ?? ""
        self.storeName = dictionary[Store.storeName] as? String ?? ""
        self.storePhoneNumber = dictionary[Store.storePhoneNumber] as? String ?? ""
        self.taxNumber = dictionary[Store.taxNumber] as? String ?? ""
    }
    
    
    static let StoreID = "StoreID"
    static let address = "address"
    static let storeName = "storeName"
    static let storePhoneNumber = "storePhoneNumber"
    static let taxNumber = "taxNumber"
  
}
