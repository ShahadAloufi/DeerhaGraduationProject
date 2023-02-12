//
//  PaymentSwiftUIView.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 10/11/1443 AH.
//

import SwiftUI

struct CustomButton: View {
    @Binding var didTapFirst: Bool
    @Binding var didTapSecond: Bool
    var buttonName: String
    var imageInTap: String
    var defaultImage: String
    let creditCard: LocalizedStringKey = "Credit Card"
    let cash: LocalizedStringKey = "Cash"

    var body: some View {
        
        VStack{
            
            HStack{
                
                if buttonName == "Credit Card" {
                Image(didTapFirst ?  imageInTap : defaultImage)
                    .resizable()
                    .frame(width: 52.0, height: 48.77)
                    .offset(x:-40)
                    
                    Text(creditCard)
                        .font(.headline)
                        .foregroundColor(Color("Checkout"))
                        .padding(.leading, -30)
                }
                else {
                    Image(didTapFirst ?  imageInTap : defaultImage)
                       .resizable()
                       .frame(width: 41.0, height: 41.0)
                        .offset(x:-60)

                    Text(cash)
                        .font(.headline)
                        .foregroundColor(Color("Checkout"))
                        .padding(.leading, -30)
                 }
                }
        }
        .frame(width: UIScreen.main.bounds.width * 0.18, height:  UIScreen.main.bounds.height * 0.01, alignment: .center)
        .padding(.all, 20)
        .background(Color("ButtonColor"))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(didTapFirst ? Color("Checkout") :  Color("ButtonColor"), lineWidth: 2)
        )
    }
}




struct checkoutButton: View {
    
    let checkout: LocalizedStringKey = "Checkout"

    var body: some View {
        VStack{
            Text(checkout)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
        }
        .frame(width: UIScreen.main.bounds.width * 0.18, height:  UIScreen.main.bounds.height * 0.01, alignment: .center)
        .padding(.all, 20)
        
        
    }
    
}



struct RowViewForCheckout: View {
    
    @StateObject var item: OrderItem
    
    var body: some View {
        
        
        HStack {
            Text(item.productId)
                .frame(width: UIScreen.main.bounds.width * 0.11, height: 40)
            Text("\(item.itemNameAR)")
                .frame(width: UIScreen.main.bounds.width * 0.15, height: 40)
            Text("\(item.itemNameEng)")
                .frame(width: UIScreen.main.bounds.width * 0.13, height: 30)
            Text("\(Int(item.quantity))")
                .frame(width: UIScreen.main.bounds.width * 0.09, height: 30)
            Text("\(item.priceForEachItem, specifier: "%.2f")")
                .frame(width: UIScreen.main.bounds.width * 0.05, height: 30)
        }
    }
}



struct OrderViewHeader: View {
    let price: LocalizedStringKey = "Price"

    var body: some View {
        VStack( spacing: 0){
            HStack(alignment: .center) {
                
                Text("Product Code")
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width * 0.11)
                Text("Arabic Name")
                    .font(.headline)
                    .fontWeight(.bold)
                
                    .frame(width: UIScreen.main.bounds.width * 0.13)
                Text("English Name")
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width * 0.13)
                HStack {
                    
                    Text("Quantity")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                } .frame(width: UIScreen.main.bounds.width * 0.09)
                HStack {
                    Text(price)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                } .frame(width: UIScreen.main.bounds.width * 0.06)
                
            } .padding(.vertical)
            
            Divider()
        }
        
    }
}

struct TotalText: View {
    let titel :Text
    let total :Double
    
    var body: some View {
        HStack{
            titel
                .fontWeight(.semibold)
                .frame(width: UIScreen.main.bounds.width * 0.07, height: UIScreen.main.bounds.height * 0.05, alignment: .leading)
            
            
            Spacer()
            Text("\((total), specifier: "%.2f")")
            
                .frame(width: UIScreen.main.bounds.width * 0.05, height:  UIScreen.main.bounds.height * 0.05)
            
            Text("SAR".localized)
            
                .frame(width: UIScreen.main.bounds.width * 0.03, height:  UIScreen.main.bounds.height * 0.05)
            
            
        }
    }
}
