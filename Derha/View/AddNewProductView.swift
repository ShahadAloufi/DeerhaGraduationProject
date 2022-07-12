//
//  AddNewProduct.swift
//  AJ
//
//  Created by Areej Albaqami on 15/11/1443 AH.
//

import SwiftUI

struct AddNewProduct: View {
    @State var editMode: EditMode = .active
    
    var body: some View {
        ZStack {
            Color(  red: 0.949, green: 0.949, blue: 0.971 )
                .ignoresSafeArea()
            ScrollView  {
                VStack {
                    ZStack {
                        Color(  red: 0.949, green: 0.949, blue: 0.971 )
                            .ignoresSafeArea()
                        ScrollView{
                            
                            ZStack{
                                VStack(alignment: .center){
                                    
                                    ZStack{
                                        
                                        VStack {
                                            
                                            NewProductView()
                                                .cornerRadius(10)
                                        }.padding(.top, 65.0)
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                    }
                }
            }
        }
        
    }
    
}

