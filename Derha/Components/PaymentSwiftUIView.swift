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

    var body: some View {
        
        VStack{
            
            HStack{
                Image(didTapFirst ?  imageInTap : defaultImage)
                    .resizable()
                    .frame(width: 52.0, height: 48.77)
                    .offset(x:-40)
                
                Text(creditCard)
                    .font(.headline)
                    .foregroundColor(Color("Checkout"))
                    .padding(.leading, -30)
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







struct PaymentSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(didTapFirst: .constant(false), didTapSecond: .constant(false), buttonName: "", imageInTap: "", defaultImage: "")
            .previewInterfaceOrientation(.landscapeRight).preview(with: "Payment")
    }
}
