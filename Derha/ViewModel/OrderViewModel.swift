//
//  OrderViewModel.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 10/11/1443 AH.
//


import SwiftUI
import Firebase

class OrderViewModel: ObservableObject {
    
    @Published var orderItems: [OrderItem] = []
    var orderItemID: [String] = []
    let orderDocRef: String = ""
    @ObservedObject var storeViewModel = StoreViewModel()
    
    
    func fictchItem(ItemId: String) {
        DispatchQueue.main.async {
            print("ItemId: \(ItemId)")

            Firestore.firestore().collection("Product").whereField("barcodeNumber", isEqualTo: ItemId)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                        return
                    } else {
                        for document in querySnapshot!.documents {
                            _ = document.data()
                            let product = Product(id: document.documentID,
                                                  
                                                  barcodeNumber: document["barcodeNumber"] as? String ?? "",
                                                  arabicProductName: document["arabicProductName"] as? String ?? "",
                                                  englishProductName:document["englishProductName"] as? String ?? "",
                                                  qy: document["qy"] as? Double ?? 0.0 ,
                                                  remainingQuantityAlert: document["remainingQuantityAlert"] as? Int ?? 0,
                                                  price: Double(document["price"] as? Int ?? 0),
                                                  unit: document["unit"] as? String ?? "",
                                                  expdate: document["expdate"] as? String ?? "" ,
                                                  ProductCategory: document["ProductCategory"] as? String ?? "",
                                                  productDiscription: document["productDiscription"] as? String ?? "",
                                                  batches: document["batches"] as? Array<String> ?? [String]()
                            )
                            
                            let newValue = product.qy - 1
                            print("newValue is \(newValue)")
                            
                            self.updateQy(productToUpdate: product, newValue: newValue)
                            
                          
                     if self.orderItems.contains(where:{ $0.productId == ItemId}){
                                let orderItem = self.orderItems.first(where: { $0.productId == ItemId})
                                orderItem?.quantity += 1
                                print("The price is: \(product.price)")
                              
                                orderItem!.priceForEachItem = product.price *  orderItem!.quantity
                             
                            } else {
                                let orderItem :OrderItem = OrderItem(dictionary: [OrderItem.id : UUID().uuidString,
                                                                                  OrderItem.productId: product.barcodeNumber,
                                                                                  OrderItem.itemNameAR: product.arabicProductName,
                                                                                  OrderItem.itemNameEng: product.englishProductName,
                                                                                  OrderItem.quantity: 1,
                                                                                  OrderItem.priceForEachItem: product.price
                                                                                 ])

                            
                                self.orderItems.append(orderItem)

                            }
                        }
                    }
                }
        }
    }
    
    
    
    func newOrder(total: Double, orderType: Int, paymentMethod: Int, itemQuantityTotal: Int ) {
        
        let orderDocRef = Firestore.firestore().collection("Orders").document()
        
        let data : [String:Any] = [Order.id : orderDocRef.documentID,
                                   Order.total : total,
                                   Order.date : Timestamp(date: Date()),
                                   Order.orderType : orderType,
                                   Order.paymentMethod : paymentMethod,
                                   Order.items : orderItemID,
                                   Order.itemQuantityTotal : itemQuantityTotal ]
        
        orderDocRef.setData(data)
    }
    
    
    func newOrderItem(productId: String, quantity: Int) {
        
        let docRef = Firestore.firestore().collection("OrderItems").document()
        
        let data : [String:Any] = [OrderItem.id : docRef.documentID,
                                 
                                   OrderItem.productId : productId,
                                   OrderItem.quantity : quantity ]
        docRef.setData(data)
        
        orderItemID.append(docRef.documentID)
    }
    
    
    
    func newInvoice( receivedAmount: Double, leftAmount:Double, deservedAmount: Double, subTotal: Double, tax: Double) {
        
        let docRef = Firestore.firestore().collection("Invoice").document()
       
        let data : [String:Any] = [Invoice.id : docRef.documentID,
                                   Invoice.storeId : "1",
                                   Invoice.orderInfo : orderDocRef,
                                   Invoice.receivedAmount : receivedAmount,
                                   Invoice.leftAmount : leftAmount,
                                   Invoice.deservedAmount : deservedAmount,
                                   Invoice.subTotal : subTotal,
                                   Invoice.tax : tax ]
        
        docRef.setData(data)
    }
    
    func getStoreID() -> String{
        var storeId: String = ""
        
        storeViewModel.fetchStoreInfo(completion: { store in
            storeId = store.StoreID
            print("The store id is : \(store.StoreID)")
            print("The store id is : \(store.storeName)")
            
        })
        return storeId
    }
    
    
    
    func totalItem() -> Double {
        if orderItems.count > 0 {
            return orderItems.lazy.compactMap { $0.priceForEachItem }
                .reduce(0, +)
            
        }
        return 0
    }
    
    
    func updateQy(productToUpdate: Product, newValue: Double){
        
        print("productToUpdate id is \(String(describing: productToUpdate.id))")
        let db = Firestore.firestore()
        db.collection("Product").document(productToUpdate.id ?? "").updateData([
            "qy": newValue
        ]){err in
            if let err = err {
                print("Error updating doc: \(err)")
            }
        }
    }
    
    
}
