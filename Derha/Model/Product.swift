//
//  product.swift
//  AJ
//
//  Created by Areej Albaqami on 12/11/1443 AH.
//

import Foundation
import FirebaseFirestoreSwift

struct Product: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var barcodeNumber: String
    var arabicProductName: String
    var englishProductName: String
    var qy: Double
    var remainingQuantityAlert: Int
    var price: Double
    var unit: String
    var expdate : String
    var ProductCategory : String
    var productDiscription: String
    var batches: Array <String>
    var uid: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case barcodeNumber
        case arabicProductName
        case englishProductName
        case qy = "qy"
        case remainingQuantityAlert = "remainingQuantityAlert"
        case price = "price"
        case unit
        case expdate
        case ProductCategory
        case productDiscription
        case batches
        case uid
        
      }
}
