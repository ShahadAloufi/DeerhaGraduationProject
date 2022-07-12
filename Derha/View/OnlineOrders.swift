//
//  Derha
//
//  Created by Shorouq Alyami on 02/06/2022.
//
//
import SwiftUI

struct onlineOrders: View {
   var body: some View {
       ZStack{
           Color(  red: 0.949, green: 0.949, blue: 0.971 )
           .ignoresSafeArea()
           VStack(alignment: .center){
               Image("order-online-icon-12")
                   .resizable()
                   .scaledToFit()
                   .foregroundColor(.secondary)
                   .padding()
                   .frame(width: 130, height: 110)
               VStack{
                   Text("You still have not received any orders".localized)
                       .font(.title2)
                       .foregroundColor(.secondary)
               }
           }.padding(.trailing, 120)
       }
   }
}

struct onlineOrders_Previews: PreviewProvider {
   static var previews: some View {
       onlineOrders()
.previewInterfaceOrientation(.landscapeLeft)
   }
}
