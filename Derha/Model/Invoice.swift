//
//  Invoice.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 13/11/1443 AH.
//

import Foundation
import FirebaseFirestoreSwift

struct Invoice: Identifiable, Hashable, Codable {
    var id: String
    var orderInfo: String
    var receivedAmount: Double
    var leftAmount: Double
    var deservedAmount: Double
    var total: Double
    var tax: Double
    var time: String
    var code: String
    var uid: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case orderInfo
        case receivedAmount = "receivedAmount"
        case leftAmount = "leftAmount"
        case deservedAmount = "deservedAmount"
        case total = "total"
        case tax = "tax"
        case time
        case code
        case uid
      }
    
    var dictionary: [String: Any] {
            let data = (try? JSONEncoder().encode(self)) ?? Data()
            return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
        }
    
}
