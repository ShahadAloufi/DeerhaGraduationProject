//
//  Store.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 23/11/1443 AH.
//

import Foundation
import Firebase

struct Store: Identifiable, Hashable, Codable{
    
    var id: String
    var address: String
    var storeName: String
    var storePhoneNumber: String
    var taxNumber: String
    
    enum CodingKeys: String, CodingKey {
    case id
    case address
    case storeName
    case storePhoneNumber
    case taxNumber
  
    }
    
    var dictionary: [String: Any] {
            let data = (try? JSONEncoder().encode(self)) ?? Data()
            return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
        }
}
