//
//  AddNewProduct.swift
//  AJ
//
//  Created by Areej Albaqami on 15/11/1443 AH.
//
import SwiftUI

struct AddNewProduct: View {
    
    @State var editMode: EditMode = .active
   
    @State var username = ""
    @State var password = ""
    @State var isLoading = false
   
    @EnvironmentObject var loginPopUpCheck: LoginPopUpCheck
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var cashBoxOpen: CashBoxOpen
   
    var body: some View {
        ZStack {
            Color(  red: 0.949, green: 0.949, blue: 0.971 )
            .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false)  {
                VStack {
                    ZStack {
                        Color(  red: 0.949, green: 0.949, blue: 0.971 )
                        .ignoresSafeArea()
                        ScrollView(.vertical, showsIndicators: false){
                        
                        ZStack{
          
                      
                            VStack(alignment: .center){
                         
                                ZStack{
                                    
                                   
                                    VStack {
                                        
                                        AddView(isEditing: .constant(true))
                     
                                        
                                          
                                
                                        .cornerRadius(10)
                                    }.padding(.top, 65.0)
                                  
                                    
                                    
                                }
                                TableNewProductView()
                                        .cornerRadius(10)
                            }
                            
                            
                            
                          
                            }
                            
                        }
                    }
                }.preferredColorScheme(.light)
            }
            
            
            if  loginPopUpCheck.showingLoginAlert {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.vertical)
                
                LoginPopUp(username: username, password: password, isLoading: isLoading, authViewModel: _authViewModel)
                    .opacity(loginPopUpCheck.showingLoginAlert ? 1 : 0)
            }
            
            if  cashBoxOpen.showingCashBoxAlert {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.vertical)

                CashBoxPopUpView()
                    .opacity(cashBoxOpen.showingCashBoxAlert ? 1 : 0)
            }

            
            
        }
        
    }
    
}
