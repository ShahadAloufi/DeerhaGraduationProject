//
//  ClearButton.swift
//  AJ
//
//  Created by Areej Albaqami on 10/11/1443 AH.
//

import SwiftUI

struct ClearButton: View {
    let title : String
    var body: some View {
        Text(title)
            .font(.title3)

            .foregroundColor(Color(red: 0.463, green: 0.483, blue: 1.034))
            .bold()
        .frame(width: UIScreen.main.bounds.width * 0.14, height: UIScreen.main.bounds.height * 0.05)
        .background(RoundedRectangle(cornerRadius: 6).stroke(Color(red: 0.463, green: 0.483, blue: 1.034), lineWidth: 2))

    }
}

struct ClearButton_Previews: PreviewProvider {
    static var previews: some View {
        ClearButton(title: "Clear")
            .previewLayout(.sizeThatFits)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
