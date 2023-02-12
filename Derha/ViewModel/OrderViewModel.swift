//
//  OrderViewModel.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 10/11/1443 AH.
//


import SwiftUI
import Firebase
import FirebaseFirestore


class OrderViewModel: ObservableObject {
    
    @Published var order: Order
    @Published var orderItems = [OrderItem]()
    var orderItemID: [String] = []
    var orderID: String = ""
    @ObservedObject var storeViewModel = StoreViewModel()
    @Published var fetchOrder: Order
    @Published var fetchOrder1: Order = Order(id: "", subTotal: 0.0, orderType: 0, paymentMethod: 0, items: [], itemQuantityTotal: 0)
    private var db = Firestore.firestore()

    
    init(order: Order = Order(id: "", subTotal: 0.0, orderType: 0, paymentMethod: 0, items: [], itemQuantityTotal: 0) ) {
        self.order = order
        fetchOrder =  Order(id: "", subTotal: 0.0, orderType: 0, paymentMethod: 0, items: [], itemQuantityTotal: 0)
    }
    

  
    
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
                                                  batches: document["batches"] as? Array<String> ?? [String](), uid: ""
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
    
    
    
    func setOrderData(subTotal: Double, orderType: Int, paymentMethod: Int, itemQuantityTotal: Int ) {
        
        order.id = UUID().uuidString
        order.subTotal = subTotal
        order.orderType = orderType
        order.paymentMethod = paymentMethod
        order.items = orderItemID
        order.itemQuantityTotal = itemQuantityTotal
        orderID = order.id
    }
    
    
    private func addNewOrder(_ order: Order){
        do {
            let _ = db.collection("Orders").addDocument(data: order.dictionary)
        }
    }
    
    
    func newOrder() {
        self.addNewOrder(order)
    }
    
    
    func fetchOrder(orderID: String) {
        print("Hi here is fetchOrder")
        db.collection("Orders").whereField("id", isEqualTo: orderID).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else if querySnapshot != nil {
                DispatchQueue.main.async {
                    var _: [()] = querySnapshot!.documents.map { d in
                        
                        // Create a batch item for each document returned
                        let order :Order = Order(id: d["id"] as? String ?? "",
                                                 subTotal: d["subTotal"] as? Double ?? 0.0,
                                                 orderType: d["orderType"] as? Int ?? 0,
                                                 paymentMethod: d["paymentMethod"] as? Int ?? 0,
                                                 items: d["items"] as? Array<String> ?? [String](),
                                                 itemQuantityTotal: d["itemQuantityTotal"] as? Int ?? 0
                        )
                        
                        
                        
                        self.fetchOrder = order
                       
                        
                        print("self.fetchOrder.items.count \((self.fetchOrder.items.count))")
                       
                        
                        
                      print("fetchOrder id \(self.fetchOrder.id)")
                        return
                    }
                    
                    for orderItem in self.fetchOrder.items {
                               usleep(100000)
                                print("hi here is for orderItem in self.fetchOrder.items !!")
                                print("orderItemId \(orderItem)")
                               self.fetchOrderItem(orderItemID: orderItem)
                           }
                   
                }
        
            }
            
            
            else{
                print("Something went wrong, please try agin.")
            }
            
        }
   }
    
    
    
    func newOrderItem(productId: String, quantity: Int, priceForEachItem: Double, itemNameEng: String, itemNameAR: String) {
        
        let docRef = Firestore.firestore().collection("OrderItems").document()
        
        let data : [String:Any] = [OrderItem.id : docRef.documentID,
                                   OrderItem.itemNameEng : itemNameEng,
                                   OrderItem.itemNameAR: itemNameAR,
                                   OrderItem.productId : productId,
                                   OrderItem.quantity : quantity,
                                   OrderItem.priceForEachItem : priceForEachItem]
        docRef.setData(data)
        
        orderItemID.append(docRef.documentID)
    }
    
    
    func fetchOrderItem(orderItemID: String) {
        print("Hi here is fetchOrderItem")
        db.collection("OrderItems").whereField("id", isEqualTo: orderItemID).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else if querySnapshot != nil {
                DispatchQueue.main.async {
                    var _: [()] = querySnapshot!.documents.map { d in
                        
                        // Create a batch item for each document returned
                        let orderItem :OrderItem = OrderItem(dictionary: [
                            OrderItem.id: d["id"] as? String ?? "",
                            OrderItem.itemNameAR: d["itemNameAR"] as? String ?? "",
                            OrderItem.itemNameEng: d["itemNameEng"] as? String ?? "",
                            OrderItem.productId: d["productId"] as? String ?? "",
                            OrderItem.quantity: d["quantity"] as? Double ?? 0.0,
                            OrderItem.priceForEachItem: d["priceForEachItem"] as? Double ?? 0.0
                                                 ])
                        
                        
                        
                        self.orderItems.append(orderItem)
                        
                        print(" self.orderItems.count \(self.orderItems.count)")
                        return
                    }
                }
            }
            else{
                print("Something went wrong, please try agin.")
            }
            
        }
    }
    

    func subTotalItem() -> Double {
        if orderItems.count > 0 {
            return orderItems.lazy.compactMap { $0.priceForEachItem }
                .reduce(0, +)
            
        }
        return 0
    }
    
    
    func tax() -> Double {
        
        return totalItem() * 0.15
    }
    
    
    func totalItem() -> Double {
       
        return ((subTotalItem()) + ((subTotalItem() * 0.15)))
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


extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"

        return dateFormatter.string(from: Date())

    }
}

