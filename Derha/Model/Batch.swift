//
//  Batch.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 27/11/1443 AH.
//

import Foundation
import FirebaseFirestoreSwift


struct Batche : Identifiable, Codable, Hashable{
    var id: String
    var batchName: String
    var expirationDate: String
    var quantity: Double
    
    enum CodingKeys: String, CodingKey  {
        case id
        case batchName
        case expirationDate
        case quantity = "quantity"
      }
}
