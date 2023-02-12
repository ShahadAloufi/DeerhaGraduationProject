//
//  cashTextField.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 29/06/1444 AH.
//

import SwiftUI

struct CashTextField: View {
    @Binding var text: String
    let placeholder: String
//    let KeyboardType: UIKeyboardType
    let titel :Text
  //  @State private var myValue: Int

    var body: some View {
       

        VStack(alignment:.leading) {
          
            titel
                .bold()
         
            
            TextField(placeholder, text: $text)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.23, height: UIScreen.main.bounds.height * 0.04)
                    .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                    .cornerRadius(11)
    
            
            
        } .padding(.bottom, 5)
    }
}


struct TotalTextField: View {
    @Binding var text: String
   // let placeholder: String
//    let KeyboardType: UIKeyboardType
    let titel :Text

    var body: some View {
       

        VStack(alignment:.leading) {
          
            titel
                .bold()
         
            
            TextField("", text: $text,   onEditingChanged: {newValue in
                
            })
                .padding()
                .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.height * 0.05)
                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
               .cornerRadius(11)
        } .padding(.bottom, 5)
    }
}

struct cashBoxText: View  {
    let total: Text
    let titel :Text

    var body: some View {
       

        HStack() {
          
            titel
                .bold()
                .fontWeight(.semibold)
                .frame(width: UIScreen.main.bounds.width * 0.16, height: UIScreen.main.bounds.height * 0.03, alignment: .leading)
         
            Spacer()
               .frame(width: UIScreen.main.bounds.width * 0.06, height:  UIScreen.main.bounds.height * 0.03)

            
            total
               // .bold()
                .foregroundColor(.init(Color(red: 0.463, green: 0.483, blue: 1.034)))
                .frame(width: UIScreen.main.bounds.width * 0.05, height:  UIScreen.main.bounds.height * 0.03)

            
            Text("SAR".localized)
              .frame(width: UIScreen.main.bounds.width * 0.03, height:  UIScreen.main.bounds.height * 0.03)
            

        }
        .padding(.bottom, 5)
    }
}
