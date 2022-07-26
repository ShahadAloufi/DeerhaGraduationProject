//
//  StoreViewModel.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 23/11/1443 AH.
//

import Foundation
import Firebase

class StoreViewModel : ObservableObject{
    
    func fetchStoreInfo(completion:@escaping((Store)->())){
        Firestore.firestore().collection("Store").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            } else {
                for document in snapshot!.documents {
                    let storeData = document.data()
                    print("The storeData is: \(storeData)")
                    let store =  Store(dictionary: storeData)
                    
                    completion(store)
                }
            }
        }
    }
}
