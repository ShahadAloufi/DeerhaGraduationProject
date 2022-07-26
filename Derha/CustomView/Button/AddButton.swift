//
//  AddButton.swift
//  AJ
//
//  Created by Areej Albaqami on 10/11/1443 AH.
//

import SwiftUI

struct AddButton: View {
   let title : String
    var body: some View {
        Text(title)
        .font(.title3)
        .fontWeight(.semibold)
        .frame(width: UIScreen.main.bounds.width * 0.14, height: UIScreen.main.bounds.height * 0.05)
        .background(Color(red: 0.463, green: 0.483, blue: 1.034))
        .foregroundColor(.white)
        .cornerRadius(6)
        
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton(title: "Add")
            .previewLayout(.sizeThatFits)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
