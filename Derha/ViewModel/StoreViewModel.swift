//
//  StoreViewModel.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 23/11/1443 AH.
//
import Foundation
import FirebaseFirestore
import Combine
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class StoreViewModel: ObservableObject{
    
    private var listenerRegistration: ListenerRegistration?
    private var db = Firestore.firestore()
    @Published var store: Store = Store(id: "", address: "", storeName: "", storePhoneNumber: "", taxNumber: "")
    
  
    func fetchStore() {
        
        db.collection("Store").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else if querySnapshot != nil {
                DispatchQueue.main.async {
                    var _: [()] = querySnapshot!.documents.map { d in
                        
                        // Create a batch item for each document returned
                        let store :Store = Store(id: d["id"] as? String ?? "",
                                                 address: d["address"] as? String ?? "",
                                                 storeName: d["storeName"] as? String ?? "",
                                                 storePhoneNumber: d["storePhoneNumber"] as? String ?? "",
                                                 taxNumber: d["taxNumber"] as? String ?? ""
                        )
                        
                        
                        
                        self.store = store
                        
                        
                        
                        return
                    }
                }
            }
            
            else{
                print("Something went wrong, please try agin.")
            }
        }
    }
    
}
