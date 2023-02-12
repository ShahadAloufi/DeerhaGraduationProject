//
//  Order.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 10/11/1443 AH.
//

import Foundation
import Firebase

struct Order: Identifiable, Hashable, Codable{
    var id: String
    var subTotal: Double
    var orderType: Int
    var paymentMethod: Int
    var items: Array<String>
    var itemQuantityTotal: Int
    

    
    enum CodingKeys: String, CodingKey {
    case id
    case subTotal = "subTotal"
    case orderType = "orderType"
    case paymentMethod = "paymentMethod"
    case items
    case itemQuantityTotal = "itemQuantityTotal"

    }
    
    
    var dictionary: [String: Any] {
            let data = (try? JSONEncoder().encode(self)) ?? Data()
            return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
        }
    
    
}
