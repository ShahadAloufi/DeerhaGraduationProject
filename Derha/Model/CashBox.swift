//
//  CashBox.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 29/06/1444 AH.
//



import Foundation
import FirebaseFirestoreSwift

struct CashBox: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var optNum: String
    var openTime: String
    var closeTime: String
    var totalSales: Double
    var totalNetCash: Double
    var totalNetCreditCard: Double
    var openingCash: Double
    var totalNetSales: Double
    var openingCoins : [Double:Int]
    var closingCoins : [Double:Int]
    var openingFiatCash: [Double:Int]
    var closingFiatCash: [Double:Int]
    var uid: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case optNum
        case openTime
        case closeTime
        case totalSales = "totalSales"
        case totalNetCash = "totalNetCash"
        case totalNetCreditCard = "totalNetCreditCard"
        case openingCash = "openingCash"
        case totalNetSales = "totalNetSales"
        case openingCoins = "openingCoins"
        case closingCoins = "closingCoins"
        case openingFiatCash = "openingFiatCash"
        case closingFiatCash = "closingFiatCash"
        case uid
        
      }
}



class CashBoxOpen: ObservableObject {
    @Published var isCashBoxOpen = false
    @Published var showingCashBoxAlert = false
}





