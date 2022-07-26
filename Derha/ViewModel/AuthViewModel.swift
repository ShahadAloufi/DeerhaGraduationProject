//
//  AuthViewModel.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 14/12/1443 AH.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


final class AuthViewModel:ObservableObject{
  
    @Published var user : User?
    

    
    let auth = Auth.auth()
   
    @Published var signedIn = false
   
     var isSignedIn: Bool{
        
        return auth.currentUser != nil
    }
    func loginAction(user: String, pass: String){
        
        auth.signIn(withEmail: user, password: pass) { authResult, error in

            if let error = error {
             print("no sucess \(error)")
            }else {
                DispatchQueue.main.async {
                    self.signedIn = true
                }
            }
        }
    }

  
    
    
    func logout(){
        try? auth.signOut()
        self.signedIn = false
    }
    func getCurrentUser() -> String{
            guard let userID = Auth.auth().currentUser?.uid  else {return ""}
            
            return userID
          
        }
}
