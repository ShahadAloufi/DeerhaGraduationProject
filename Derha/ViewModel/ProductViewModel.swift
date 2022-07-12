//
//  AddProductViewModel.swift
//  shahadmufleh
//
//  Created by shahadmufleh on 11/07/2022.
//


import Foundation
import FirebaseFirestore
import Combine
import SwiftUI
import UserNotifications
class ProdctViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var product: Product
    @Published var modified = false
  
    init(product: Product = Product(barcodeNumber: "", arabicProductName: "", englishProductName: "", qy: 0.0, remainingQuantityAlert: 0, price: 0.0, unit: "", expdate: "", ProductCategory: "", productDiscription: "", batches: [String]())) {
        self.product = product
      
    
            self.$product
              .dropFirst()
              .sink { [weak self] product in
                self?.modified = true
              }
              .store(in: &self.cancellables)
          }
    
    
    private var db = Firestore.firestore()
        
    private func addNewProduct(_ product: Product){
        do {
            let _ = try db.collection("Product").addDocument(from: product)
        }
        catch {
          print(error)
        }
      }
       
    private func updateProduct(_ product: Product) {
        if let documentId = product.id {
          do {
            try db.collection("Product").document(documentId).setData(from: product)
          }
          catch {
            print(error)
          }
        }
      }
    
    private func updateOrAddProduct() {
       if let _ = product.id {
         self.updateProduct(self.product)
       }
       else {
           self.addNewProduct(product)
       }
     }
   
    
    private func removeProduct() {
        if let documentId = product.id {
          db.collection("Product").document(documentId).delete { error in
            if let error = error {
              print(error.localizedDescription)
            }
          }
        }
      }

    func handleDoneTapped() {
        self.updateOrAddProduct()
        self.product.batches.append(product.expdate)
        self.product.batches.append("\(product.qy)")
        print(product)
        
      }
       
      func handleDeleteTapped() {
        self.removeProduct()
      }

       

}



class ProductsViewModel: ObservableObject {
  @Published var product = [Product]()
 
  private var db = Firestore.firestore()
  private var listenerRegistration: ListenerRegistration?
   
  deinit {
    unsubscribe()
  }
   
  func unsubscribe() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
      listenerRegistration = nil
    }
  }
   
   
  func subscribe() {
    if listenerRegistration == nil {
      listenerRegistration = db.collection("Product").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.product = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: Product.self)
            
            
        }
      }
    }
  }
   
  func removeProducts(atOffsets indexSet: IndexSet) {
    let products = indexSet.lazy.map { self.product[$0] }
      products.forEach { product in
      if let documentId = product.id {
        db.collection("Product").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
    
    func notificationQy(_ product: Product) {
        if product.id != nil {
          do {
              if product.qy == Double(product.remainingQuantityAlert){
                  UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                      if success {
                          let content = UNMutableNotificationContent()
                          content.title = "Product Out of Stock"
                          content.subtitle = "Your product \(product.englishProductName) is about to be out of stock"
                          content.sound = UNNotificationSound.default
                          // show this notification five seconds from now
                          let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                          // choose a random identifier
                          let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                          // add our notification request
                          UNUserNotificationCenter.current().add(request)
                      } else if let error = error {
                          print(error.localizedDescription)
                      }
                  }
                  
              }
             
              
              
          }
         
        }
    }
    
    func notificationExpDate(_ product: Product){
        if product.id != nil {
          do {
            
                 
                  let date = Date.now
                  let dateFormatter = DateFormatter()
                  dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                  dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                  dateFormatter.dateFormat = "yyyy-MM-dd"
                  dateFormatter.string(from: date)
                  if product.expdate <= ("\(date)") {
                      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                          if success {
                              let content = UNMutableNotificationContent()
                              content.title = "Product Expired"
                              content.subtitle = "Your product \(product.englishProductName) has just expired"
                              content.sound = UNNotificationSound.default
                              // show this notification five seconds from now
                              let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                              // choose a random identifier
                              let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                              // add our notification request
                              UNUserNotificationCenter.current().add(request)
                          } else if let error = error {
                              print(error.localizedDescription)
                          }
                      }
                  
              }
             
              
              
          
         
        }
        
    }

    }
    
    
}



