//
//  CashBoxViewModel.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 29/06/1444 AH.
//


import Foundation
import FirebaseFirestore
import Combine
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class CashBoxViewModel: ObservableObject {

    private var listenerRegistration: ListenerRegistration?
    private var db = Firestore.firestore()
    @Published var cashBox: CashBox
    @Published var cashBoxs = [CashBox]()
    @Published var totalCash: Double = 0
    @Published var finalTotalCash: Double = 0
    @Published var totalCreditCard: Double = 0
    @Published var totalSales: Double = 0


    init(cashBox: CashBox =  CashBox(optNum: "",
                                     openTime: "",
                                     closeTime: "",
                                     totalSales: 0.0,
                                     totalNetCash: 0.0,
                                     totalNetCreditCard: 0.0,
                                     openingCash: 0.0,
                                     totalNetSales: 0.0,
                                     openingCoins: [0.0 : 0],
                                     closingCoins: [0.0 : 0],
                                     openingFiatCash: [0.0 : 0],
                                     closingFiatCash: [0.0 : 0],
                                     uid: "")) {
        self.cashBox = cashBox

    }
   
    


    private func addNewCashBox(_ cashBox: CashBox){
         do {
             do {
                 let _ = try db.collection("CashBox").addDocument(from: cashBox)
             }
             catch{
                 print("error")
             }
         }
     }
 


    func addCashBox() {
       self.addNewCashBox(cashBox)

    }



    
    func fetchCashBox(uid: String){

                if listenerRegistration == nil {
                    listenerRegistration = db.collection("CashBox").whereField("uid", isEqualTo: uid).addSnapshotListener { (querySnapshot, error) in
                        guard let documents = querySnapshot?.documents else {
                            print("No documents")
                            return
                        }

                        self.cashBoxs = documents.compactMap { queryDocumentSnapshot in
                            try? queryDocumentSnapshot.data(as: CashBox.self)

                        }
                    }
                }
            }


//    func setOpeningData() {
//
//        self.cashBox.openTime =  Date.getCurrentDate()
//        self.cashBox.openingCoins = self.openingCoinsDictionary
//        self.cashBox.openingFiatCash = self.openingFiatCashDictionary
//
//
//    }


    func setClosingData() {

        self.cashBox.closeTime = Date.getCurrentDate()
        self.cashBox.totalSales = self.total()
        self.cashBox.totalNetSales = self.total()
        self.cashBox.totalNetCreditCard = self.totalCreditCard
        self.cashBox.totalNetCash = self.finalTotalCash
    }


    func cashTotal(cash: Double) {

        print("self.totalCash \(self.totalCash)")

        self.totalCash += cash


    }

    func creditCardTotal(creditCard: Double){

        self.totalCreditCard += creditCard


        print("self.totalCreditCard \(self.totalCreditCard)")

       // return self.totalCreditCard
    }

    func total() -> Double {


        self.totalSales = self.finalTotalCash +  self.totalCreditCard

        return self.totalSales
       
    }

    func finalCashTotal() {
        self.finalTotalCash = self.totalCash + self.cashBox.openingCash

    }
    
    
    func randomID() -> String {
        var result = ""
        repeat {
            result = String(format:"%06d", arc4random_uniform(10000) )
        } while result.count < 4 || Int(result)! < 1000
        print(result)
        return result
    }
    
    
  
}





//class CashBoxViewModel: ObservableObject {
//
//        private var listenerRegistration: ListenerRegistration?
//        private var db = Firestore.firestore()
//        @Published var cashBox: CashBox
//        @Published var cashBoxs = [CashBox]()
//        @Published var openingCoinsDictionary: [String: String] = ["":""]
//        @Published var openingFiatCashDictionary: [String: String] = ["":""]
//        @Published var closingCoinsDictionary: [String: String] = ["":""]
//        @Published var closingFiatCashDictionary: [String: String] = ["":""]
//        @Published var totalCash: Double = 0
//        @Published var finalTotalCash: Double = 0
//        @Published var totalCreditCard: Double = 0
//        @Published var totalSales: Double = 0
//
//
//    init(cashBox: CashBox = CashBox(openTime: "", closeTime: "", totalSales: 0.0, totalNetCash: 0.0, totalNetCreditCard: 0.0, openingCash: 0.0, totalNetSales: 0.0,
//                                   openingCoins: ["":""], closingCoins: ["":""], openingFiatCash: ["":""], closingFiatCash: ["":""],
//                                    uid: "") ) {
//
//        self.cashBox = cashBox
//    }
//
//
//    private func addNewCashBox(_ cashBox: CashBox){
//        do {
//            do {
//                let _ = try db.collection("CashBox").addDocument(from: cashBox)
//            }
//            catch{
//                print("error")
//            }
//        }
//    }
//
//
//    func addCashBox() {
//        self.addNewCashBox(cashBox)
//    }
//
//
//
//}
