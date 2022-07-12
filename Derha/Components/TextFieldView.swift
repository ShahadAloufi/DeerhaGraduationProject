//
//  TextFieldView.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 14/11/1443 AH.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    let placeholder: String
    let KeyboardType: UIKeyboardType
    var body: some View {
        HStack{
        TextField(placeholder, text: $text)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .padding(.leading)
                    .keyboardType(KeyboardType)
                    .background(
                        
                        ZStack (alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(Color.gray.opacity(0.25))
                        }
                    )

            Image("CashBack")
                .resizable()
                .frame(width: 13, height: 18)
        }
        
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(text: .constant(""), placeholder: "Enter Text", KeyboardType: .default).preview(with: "Enter text")
    }
}
