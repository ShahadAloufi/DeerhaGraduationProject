//
//  SearchInvoiceView.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 03/07/1444 AH.
//

import SwiftUI

struct SearchInvoiceView: View {
    
    @State private var isEditing = false
    @Binding var SearchText: String

    
    var body: some View {
       HStack {
            TextField(" Search by invoice number here".localized, text: $SearchText)
                .padding(15)
                .padding(.horizontal, 25)
                .frame(width: 620, height: 40)
               
                .background(Color(.white))
                .cornerRadius(8)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                        
                            .foregroundColor(.init(Color(red: 0.463, green: 0.483, blue: 1.034)))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                        
                        
                        if isEditing{
                            Button(action: {
                                self.SearchText = ""
                            }, label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 12)
                            })
                        }
                    }
                ).onTapGesture {
                    self.isEditing = true
                }
            if isEditing{
                Button(action: {
                    self.isEditing = false
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                }){
                    Text("Cancel")
                        .padding()
                    
                }
                .transition(.move(edge: .trailing))
            }
        }
    }
}


