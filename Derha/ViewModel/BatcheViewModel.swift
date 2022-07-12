//
//  BatcheViewModel.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 07/12/1443 AH.
//

import Foundation
import Firebase
import Combine
import SwiftUI

class BatchViewModel : ObservableObject{
    
    @Published var newBatchesArray = [Batche]()
    @Published var batches = [Batche]()
    @Published var batchesID = [String]()
    private var db = Firestore.firestore()
    @Published var batche: Batche
    @Published var modified = false
    private var cancellables = Set<AnyCancellable>()
    
    
    init(batche: Batche = Batche(id: UUID().uuidString, batchName: "", expirationDate: "", quantity: 0.0)) {
        self.batche = batche
        
        
        self.$batche
            .dropFirst()
            .sink { [weak self] product in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    
    
    func emptyBatcheArray(expirationDate: String, quantity: Double) {
        print("Hi here is emptyBatcheArray!")
        self.batches.append(Batche(id: UUID().uuidString ,batchName: "Batch", expirationDate: expirationDate, quantity: quantity))
    }
    
    func newBatcheArray(batche: Batche) {
        print("The batch.expirationDate is \(batche.expirationDate)")
        print("The batche.quantity is \(batche.quantity)")
        self.newBatchesArray.append(batche)
        print("The newBatchesArray.count is \(newBatchesArray.count)")
        
    }
    
    
    func updateNewArray(index: Int){
        newBatchesArray = Array(batches[index..<batches.count])
        
    }
    
    
    func fetchBatch(batcheID: String, product: Product) {
        // Get a reference to the database
        let db = Firestore.firestore()
        
        db.collection("Batch").whereField("id", isEqualTo: batcheID).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else if querySnapshot != nil {
                DispatchQueue.main.async {
                    var _: [()] = querySnapshot!.documents.map { d in
                        
                        // Create a batch item for each document returned
                        let batche :Batche = Batche(id: d["id"] as? String ?? "",
                                                    batchName:  d["batchName"] as? String ?? "",
                                                    expirationDate: d["expirationDate"] as? String ?? "",
                                                    quantity: d["quantity"] as? Double ?? 0.0
                        )
                        print ("batche.expirationDate\(batche.expirationDate)")
                        
                        self.batches.append(batche)
                     
                        self.checkDate(batche: batche, product: product)
                        return
                    }
                    
                }
            }
            else{
                print("Something went wrong, please try agin.")
            }
            
        }
    }
    
    func fetchBatcheByID (productCode : String){
        

        let db = Firestore.firestore()
        db.collection("Product").whereField("barcodeNumber", isEqualTo: productCode).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else if let query = querySnapshot {
                let documents = query.documents
                for doc in documents {
                    let product = Product(id: doc.documentID,
                                          barcodeNumber: doc["barcodeNumber"] as? String ?? "",
                                          arabicProductName: doc["arabicProductName"] as? String ?? "",
                                          englishProductName:doc["englishProductName"] as? String ?? "",
                                          qy: doc["qy"] as? Double ?? 0.0,
                                          remainingQuantityAlert: doc["remainingQuantityAlert"] as? Int ?? 0,
                                          price: doc["price"] as? Double ?? 0.0,
                                          unit: doc["unit"] as? String ?? "",
                                          expdate: doc["expdate"] as? String ?? "",
                                          ProductCategory: doc["ProductCategory"] as? String ?? "",
                                          productDiscription: doc["productDiscription"] as? String ?? "",
                                          batches: doc["batches"] as? Array<String> ?? [String]()
                    )
                    
                    for producBatche in product.batches{
                        self.fetchBatch(batcheID: producBatche, product: product)
                        
                    }
                    
                }
            }else{
                print("Something went wrong, please try agin.")
            }
            
        }
    }
    
    
    func newBatch(product: Product, batche: Batche) {
        
        do {
            let docRef = try db.collection("Batch").addDocument(from: batche)
            batchesID.append(docRef.documentID)
            let totalQy = totalQy()
            updateQy(productToUpdate: product, newValue: totalQy)
        }
        catch {
            print(error)
        }
        
    }
    
    
    
    func updateBatche(productToUpdate: Product, batche: Batche){
      
        if productToUpdate.id != nil {
            do {
                db.collection("Product").document(productToUpdate.id ?? "").updateData([
                    "batches": FieldValue.arrayUnion([batche.id])])
               
            }
        }
    }

    
    
    func checkDate(batche: Batche, product: Product){
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dateString = df.string(from: date)
        
        if dateString <= batche.expirationDate {
            //removeBatch(batcheToDelet: batche, product: product)
        }
    }
    
    
    func deletBatche(batcheToDelet: Batche, product: Product) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Specify the document to delete
        db.collection("Batch").document(batcheToDelet.id).delete { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // Remove the todo that was just deleted
                    self.batches.removeAll { batche in
                        // Check for the product to remove
                        return batche.id == batcheToDelet.id
                    }
                    
                    
                    if self.batches.count > 0 {
                        self.updateDate(productToUpdate: product, newValue: self.batches[0].expirationDate)
                    }
                }
            }
        }
    }
    
    func removeBatch(batcheToDelet: Batche, product: Product) {
        //        if let documentId = batcheToDelet.id {
        
        db.collection("Batch").document(batcheToDelet.id).delete { error in
            if let error = error {
                print("Unable to remove document: \(error.localizedDescription)")
            }
            else{
                print("Hi we are in the else!")
                DispatchQueue.main.async {
                    
                    // Remove the batche that was just deleted
                    self.batches.removeAll { batche in
                        // Check for the product to remove
                        return batche.id == batcheToDelet.id
                    }
                    
                    let newValue = product.qy - batcheToDelet.quantity
                    self.updateQy(productToUpdate: product, newValue: newValue)
                    
                    if self.batches.count > 0 {
                        self.updateDate(productToUpdate: product, newValue: self.batches[0].expirationDate)
                    }
                }
            }
          
        }
    }
    
    
    func totalQy() -> Double {
        if batches.count > 0 {
            return batches.lazy.compactMap { Double($0.quantity) }
                .reduce(0, +)
        }
        return 0
    }
    
    
    func updateQy(productToUpdate: Product, newValue: Double){
        
        
        let db = Firestore.firestore()
        if productToUpdate.id != nil {
            db.collection("Product").document(productToUpdate.id ?? "").updateData([
                "qy": newValue
            ]){err in
                if let err = err {
                    print("Error updating doc: \(err)")
                }
            }
        }
    }
    
    
    func updateFilterByAscendingOrderToDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        batches
            .map { return ($0, dateFormatter.date(from: $0.expirationDate) ?? Date() ) }
            .sorted { $1.1 > $0.1}
            .map(\.0)
    }
    
    
    func updateDate(productToUpdate: Product, newValue: String){
        
       
        let db = Firestore.firestore()
        if productToUpdate.id != nil {
            db.collection("Product").document(productToUpdate.id ?? "").updateData([
                "expdate": newValue
            ]){err in
                if let err = err {
                    print("Error updating doc: \(err)")
                }
            }
        }
    }
}
