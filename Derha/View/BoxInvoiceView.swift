//
//  BoxInvoiceView.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 03/07/1444 AH.
//

import SwiftUI


struct BoxInvoiceView: View {

        @State var presented = false
        @State var SearchText: String = ""
        @State private var selectedIndex = 0
    
  
    @State private var selectedCashBox: CashBox = CashBox(optNum: "",
                                                          openTime: "",
                                                          closeTime: "",
                                                          totalSales: 0.0,
                                                          totalNetCash: 0.0,
                                                          totalNetCreditCard: 0.0,
                                                          openingCash: 0.0,
                                                          totalNetSales: 0.0,
                                                          openingCoins: [0.0 : 0],
                                                          closingCoins: [0.0 : 0],
                                                          openingFiatCash: [0.0 : 0],
                                                          closingFiatCash: [0.0 : 0],
                                                          uid: "")
    
        let ourPurple : Color = Color(UIColor(red: 119/255, green: 123/255, blue: 255/255, alpha: 41))
    
        @StateObject var storeViewModel = StoreViewModel()
        @EnvironmentObject var authViewModel: AuthViewModel
        @EnvironmentObject var cashBoxViewModel: CashBoxViewModel
        
        
        var body: some View {
            ZStack{
                
                Color(  red: 0.949, green: 0.949, blue: 0.971 )
                    .ignoresSafeArea()
                
                
                ScrollView(showsIndicators: false) {
                    VStack{
                        
                        VStack {
                            VStack {
                               
                                SearchInvoiceView(SearchText: $SearchText)
                            }
                           
                        }
                        
                        HStack(alignment: .bottom, spacing: 16) {
                            
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: UIScreen.main.bounds.width * 0.24, height: UIScreen.main.bounds.height * 0.89)
                                .foregroundColor(.white)
                                .overlay(){
                                    VStack(alignment: .leading, spacing: 20){
                               
                                     
                                            Text("Cashier Box Invoices")
                                            .bold()
                                        
                                            List{
                                                ForEach(self.cashBoxViewModel.cashBoxs.filter({"\(String(describing: $0.id))".contains(SearchText) || SearchText.isEmpty}), id: \.id) { i in
                                                    
                                                    CashBoxRow(cashBox: i)
                                                        .listRowBackground(selectedCashBox == i ?
                                                                                       ourPurple.opacity(0.3)
                                                        .clipShape(RoundedRectangle(cornerRadius: 5)) :
                                                                            Color(UIColor.white).opacity(0)
                                                        .clipShape(RoundedRectangle(cornerRadius: 0)))
                                                         .onTapGesture {
                                                             self.selectedCashBox = i
                                                    }
                                                    
                                                }
                                              
                                            }
                                            .onAppear(perform: {
                                                cashBoxViewModel.fetchCashBox(uid: authViewModel.getCurrentUser())
                                                storeViewModel.fetchStore()
                                            }
                                            )
                                            
                                            .listStyle(PlainListStyle())
                                    
                                     
                                    } .padding()
                                }
                            
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.89)
                                .foregroundColor(.white)
                                .overlay() {
                                    VStack(alignment: .leading, spacing: 10) {
                                      
                                        OpeningBoxInvoiceView(storeViewModel: storeViewModel, presented: $presented, cashBox: selectedCashBox)
                                      
                                        
                                    } .padding()
                                }
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.89)
                                .foregroundColor(.white)
                                .overlay() {
                                    VStack(alignment: .leading, spacing: 20) {
                                      
                                        closingBoxInvoiceView(storeViewModel: storeViewModel, presented: $presented, cashBox: selectedCashBox)
                                        
                                        
                                    } .padding()
                                }
                            
                            
                            
                            
                        }
                        .padding(6)
                        //.padding(.top, 50)
                        Spacer()
                    }
                }
            } .preferredColorScheme(.light)
        }
    }

//
//struct BoxInvoiceView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoxInvoiceView()
//    }
//}
