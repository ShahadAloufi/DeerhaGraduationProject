//
//  OrderSearchView.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 16/12/1443 AH.
//


import SwiftUI

struct OrderSearchView: View {
    @Binding var SearchText: String
    @StateObject var orderViewModel = OrderViewModel()
    @State private var isEditing = false
    @Binding var showCam: Bool
    @Binding var presented: Bool
    
    var body: some View {
        VStack{
            HStack {
                TextField(" Scan barcode number here".localized, text: $SearchText).onChange(of: SearchText, perform: { newValue in
                    orderViewModel.fictchItem(ItemId: newValue)
                    
                })
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
                ).onTapGesture{
                    self.isEditing = true
                }
                if isEditing{
                    Button(action: {
                        self.isEditing = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }){
                        Text("Cancel".localized)
                           
                    }
                    .transition(.move(edge: .trailing))
                }
                HStack{
                Button {
                    print("barcodeButton clicked")
                    showCam.toggle()

                } label: {
                    Image("barcodeButton")
                        .foregroundColor(Color("Color-3"))
                      
                }
                }  .padding(.leading, 8)
                
                HStack{
                Button {
                    print("barcodeButton clicked")
                    presented = true

                } label: {
                    Image("printer")
                        .resizable()
                        .foregroundColor(Color("Color-3"))
                        .frame(width: 70, height: 55)
                }
                }  .padding(.leading, 10)
                
                
            }
        }.padding(.top, 1.0)
    }
}


struct OrderSearchView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSearchView(SearchText: .constant(""), showCam: .constant(false), presented: .constant(false))
    }
}
