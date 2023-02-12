//
//  InvoiceViewModel.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 03/06/1444 AH.
//

import Foundation
import FirebaseFirestore
import Combine
import SwiftUI
import Firebase
import FirebaseFirestoreSwift


class InvoiceViewModel: ObservableObject {
    
    @ObservedObject var orderViewModel = OrderViewModel()
    @Published var invoice: Invoice
    private var db = Firestore.firestore()
    @Published var invoices = [Invoice]()
    private var listenerRegistration: ListenerRegistration?
    var orderData: String
    var orderItems: Array<String>
   // @Published var order : Order
    @Published var orderItemsData = [OrderItem]()
    
    
    init(invoice: Invoice = Invoice(id: "", orderInfo: "", receivedAmount: 0.0, leftAmount: 0.0, deservedAmount: 0.0, total: 0.0, tax: 0.0, time: "", code: "", uid: "") ) {
        self.invoice = invoice
        orderData = ""
        orderItems = []

    }
    
    
    
    private func addNewInvoice(_ invoice: Invoice){
        do {
            let _ = db.collection("Invoice").addDocument(data: invoice.dictionary)
        }
    }
    
    
    func addInvoice() {
        self.addNewInvoice(invoice)
    }
    
    func fetchInvoice(uid: String){

                if listenerRegistration == nil {
                    listenerRegistration = db.collection("Invoice").whereField("uid", isEqualTo: uid).addSnapshotListener { (querySnapshot, error) in
                        guard let documents = querySnapshot?.documents else {
                            print("No documents")
                            return
                        }

                        self.invoices = documents.compactMap { queryDocumentSnapshot in
                            try? queryDocumentSnapshot.data(as: Invoice.self)

                        }
                    }
                }
            }
    
    
    
    func setInvoiceData( receivedAmount: Double, leftAmount:Double, deservedAmount: Double, total: Double, storeName: String) {
        self.invoice.id = self.randomID()
        self.invoice.receivedAmount = receivedAmount
        self.invoice.leftAmount = leftAmount
        self.invoice.deservedAmount = deservedAmount
        self.invoice.total = total
        self.invoice.tax = 0.15
        self.invoice.time = Date.getCurrentDate()
        
        let qrInfo = "\(storeName) 1234567 \(Date().description) 123.12 17.4"
        let base64Info = qrInfo.data(using: .utf8)?.base64EncodedString() ?? "N/A"
        
        self.invoice.code = base64Info
        
    }
    
    func randomID() -> String {
        var result = ""
        repeat {
            result = String(format:"%04d", arc4random_uniform(10000) )
        } while result.count < 4 || Int(result)! < 1000
        print(result)
        return result
    }
    
    
    func isToday(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yy"
        
        // Convert String to Date
        let date = dateFormatter.date(from: dateString)
        
        if Calendar.current.isDateInToday(date!){
            return "Today"
        }
        else {
            return dateString
        }
    }
    
    
    func dateOrTime(date: String, type: String) -> String {
        
        let fullNameArr : [String] = date.components(separatedBy: " ")
        
        // And then to access the individual words:
        
        if type == "date" {
            let date : String = fullNameArr[0]
            return date
        }
        else {
            let time : String = fullNameArr[1]
            return time
        }
        
    }
    
    
}
