//
//  SwiftUIView.swift
//  finalTables
//
//  Created by shahadmufleh on 09/06/2022.
//

import SwiftUI

struct SearchView: View {
    @Binding var SearchText: String
    @State private var isEditing = false
    var body: some View {
        VStack {
            HStack {
                TextField(" Scan barcode number here".localized, text: $SearchText)
                    .padding(15)
                    .padding(.horizontal, 25)
                    .frame(width: 620, height: 35)
                    .background(Color(.white))
                    .cornerRadius(8)
                    .overlay(
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
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
        }.padding(.top, 12.0)
    }
    
    
}
