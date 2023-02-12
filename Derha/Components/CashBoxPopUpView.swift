//
//  CashBoxPopUpView.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 03/07/1444 AH.
//

import SwiftUI

struct CashBoxPopUpView: View {
    
    @EnvironmentObject var cashBoxOpen: CashBoxOpen

    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
            
        VStack {
            
            Image ("HiOutlineLockOpen")
                .resizable()
                .frame(width: 42.0, height: 42.0)
                .padding()

            Text("Please open the Cashbox!")
                .foregroundColor(.init(Color(red: 0.463, green: 0.483, blue: 1.034)))
                .padding()
       
            
            Button(action: {
                
                cashBoxOpen.showingCashBoxAlert.toggle()
                
            }, label: {
                Text("OK")
                    .foregroundColor(.init(Color(red: 0.463, green: 0.483, blue: 1.034)))
            })
            
        }
      }
       .frame(width: 300, height: 200)
    }
}

