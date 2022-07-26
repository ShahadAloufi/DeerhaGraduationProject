//
//  PopUpView.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 14/11/1443 AH.
//
import SwiftUI

struct CustomAlert: View {
    @Binding var total: String
    @Binding var receivedAmount: String
    @Binding var leftAmount: String
    @Binding var showingAlert: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
            VStack {
                TextField("Total", text: $total)
                   .padding()
                   
                   .frame(width: 360, height: 55.0)
                   .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                  
                  .cornerRadius(11)
                  .padding(.bottom, 10)
                TextField("Received Amount", text: $receivedAmount)
                   .padding()
                   
                   .frame(width: 360, height: 55.0)
                   .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                  
                  .cornerRadius(11)
                  .padding(.bottom, 10)
                TextField("Left", text: $leftAmount)
                   .padding()
                   
                   .frame(width: 360, height: 55.0)
                   .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                  
                  .cornerRadius(11)
                  .padding(.bottom, 10)
                 
                HStack {
                  
                    
                    Button(action: {
                        withAnimation {
                            self.showingAlert.toggle()
                        }
                       
                    }) {
                        Text("Add".localized)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .padding()
                    }
                    
                    .frame(width: 180, height: 10, alignment: .center)
                    .padding(.all, 20)
                    .background(Color("Checkout"))
                    .cornerRadius(10)
                    
                }
                .padding(20)
                .padding(.horizontal, 30)
            }
            
            
        }
        .frame(width: 400, height: 340)
    }
}

struct PopUpView: View {
    @State private var textEntered = ""
    @State private var showingAlert = false
    @State private var total = ""
    @State var receivedAmount = ""
    @State var leftAmount = ""
    
    var body: some View {

            ZStack {
                Color.red.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Button("Show Alert") {
                        self.showingAlert.toggle()
                        self.textEntered = ""
                    }
                    Text("\(textEntered)")
                }
                
                CustomAlert(total: $total, receivedAmount: $receivedAmount, leftAmount: $leftAmount, showingAlert: $showingAlert)
                    .opacity(showingAlert ? 1 : 0)
                
                
            }
        
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView()
    }
}
