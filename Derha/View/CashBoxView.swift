//
//  CashBoxView.swift
//  Derha
//
//  Created by shahadmufleh on 16/01/2023.
//

import SwiftUI

struct CashBoxView: View {
    
    @State var cash = ""
    @State var creditCard = ""
    
    //coins
    @State var coins01s = ""
    @State var coins05s = ""
    @State var coins10s = ""
    @State var coins25s = ""
    @State var coins50s = ""
    @State var coins1s = ""
    @State var coins2s = ""
    
    //
    @State var fiatCash1s = ""
    @State var fiatCash5s = ""
    @State var fiatCash10s = ""
    @State var fiatCash20s = ""
    @State var fiatCash50s = ""
    @State var fiatCash100s = ""
    @State var fiatCash500s = ""
    
    @State var username = ""
    @State var password = ""
    @State var isLoading = false
   
    
    @EnvironmentObject var loginPopUpCheck: LoginPopUpCheck
    @EnvironmentObject var cashBoxOpen : CashBoxOpen
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var cashBoxViewModel  : CashBoxViewModel
  //  @StateObject var cashBoxViewModel = CashBoxViewModel()

    
    var buttonLabel: String {
        cashBoxOpen.isCashBoxOpen ? "Close the cashbox".localized : "Open the cashbox".localized
    }
    
    var boxStatus: String {
        cashBoxOpen.isCashBoxOpen ?  "Opened".localized : "Closed".localized
    }
    
    var body: some View {
        
        VStack {
            NavigationView {

            ZStack {
                Color(red: 0.949, green: 0.949, blue: 0.971 )
                    .ignoresSafeArea()
                
                VStack {
                    HStack (spacing: 1){
                        VStack {
                            HStack {
                                ZStack {
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.height * 0.70 ,alignment: .center)
                                    
                                    VStack {
                                        
                                        VStack(alignment: .leading, spacing: 0) {
                                            HStack(alignment: .center) {
                                                
                                                Text("Coins")
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                    .frame(width: UIScreen.main.bounds.width * 0.12)
                                                
                                            }
                                            .padding(.vertical, 8)
                                            
                                            Divider()
                                        }
//                                         .padding(.bottom,2)
//                                         .padding(.trailing, 6)
//                                         .padding(.leading, 6)
                                        
                                        
                                        CashTextField(text: $coins01s, placeholder: "", titel: Text("0.01s"))
                                            .keyboardType(.numberPad)
                                        
                                        
                                        
                                        CashTextField(text: $coins05s, placeholder: "", titel: Text("0.05s"))
                                            .keyboardType(.numberPad)
                                        
                                        CashTextField(text: $coins10s, placeholder: "", titel: Text("0.10s"))
                                            .keyboardType(.numberPad)
                                        
                                        CashTextField(text: $coins25s, placeholder: "", titel: Text("0.25s"))
                                            .keyboardType(.numberPad)
                                        
                                        CashTextField(text: $coins50s, placeholder: "", titel: Text("0.50s"))
                                            .keyboardType(.numberPad)
                                        
                                        CashTextField(text: $coins1s, placeholder: "", titel: Text("1s"))
                                            .keyboardType(.numberPad)
                                        
                                        CashTextField(text: $coins2s, placeholder: "", titel: Text("2s"))
                                            .keyboardType(.numberPad)
                                       
                                    }
                                    
                                }
                                
                                ZStack {
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.height * 0.70 ,alignment: .center)
                                
                                    
                                    
                                    VStack {
                                        VStack(alignment: .leading, spacing: 0) {
                                            HStack(alignment: .center) {
                                                
                                                Text("Fiat Cash")
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                    .frame(width: UIScreen.main.bounds.width * 0.08)
                                                
                                            }
                                            .padding(.vertical, 8)
                                            
                                            Divider()
                                        }
                                        
//                                        .padding(.bottom,2)
//                                        .padding(.trailing, 6)
//                                        .padding(.leading, 6)
                                        
                                        
                                        CashTextField(text: $fiatCash1s, placeholder: "", titel: Text("1s"))
                                            .keyboardType(.numberPad)
                                        
                                        CashTextField(text: $fiatCash5s, placeholder: "", titel: Text("5s"))
                                            .keyboardType(.numberPad)
                                        
                                        CashTextField(text: $fiatCash10s, placeholder: "", titel: Text("10s"))
                                            .keyboardType(.numberPad)
                                        
                                        CashTextField(text: $fiatCash20s, placeholder: "", titel: Text("20s"))
                                            .keyboardType(.numberPad)
                                        
                                        CashTextField(text: $fiatCash50s, placeholder: "", titel: Text("50s"))
                                            .keyboardType(.numberPad)
                                        
                                        CashTextField(text: $fiatCash100s, placeholder: "", titel: Text("100s"))
                                            .keyboardType(.numberPad)
                                        
                                        CashTextField(text: $fiatCash500s, placeholder: "", titel: Text("500s"))
                                            .keyboardType(.numberPad)
                                        
                                        
                                    }
                                }
                            }
                            ZStack {
                                
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .frame(width: UIScreen.main.bounds.width * 0.51, height: UIScreen.main.bounds.height * 0.15 ,alignment: .center)
                            
                                
                                
                                
                                VStack {
                                    
                                    HStack(spacing: 22) {
                                        
                                        VStack(alignment:.leading) {
                                            
                                            Text("Cash Total")
                                                .bold()
                                            
                                            
                                            TextField("\((cashBoxViewModel.finalTotalCash),specifier: "%.2f")", text: $cash,
                                                      onCommit: {
                                                
                                                if !cashBoxOpen.isCashBoxOpen {
                                                    
                                                    print("!cashBoxOpen.isCashBoxOpen\(!cashBoxOpen.isCashBoxOpen)")
                                                    cashBoxViewModel.cashBox.openingCash = Double(cash) ?? 0.0
                                                    print("cashBoxViewModel.cashBox.openingCash\(cashBoxViewModel.cashBox.openingCash)")
                                                }
                                            })
                                            .padding()
                                            .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.height * 0.05)
                                            .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                            .cornerRadius(11)
                                        }
                                        .padding(.bottom, 5)
                                        
                                        
                                        VStack(alignment: .leading) {
                                            Text("Credit Card Total".localized)
                                                .bold()
                                            
                                            //as a text
                                            Text("\((cashBoxViewModel.totalCreditCard),specifier: "%.2f")")
                                                .padding(.trailing, 240)
                                                .foregroundColor(.gray)
                                                .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.height * 0.05)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                        }
                                    }
                                }
                            }
                        }
                        
                        
                        VStack {
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .frame(width: UIScreen.main.bounds.width * 0.33, height: UIScreen.main.bounds.height * 0.35 ,alignment: .center)
                            
                                
                                VStack(spacing: 35) {
                                
                                VStack(alignment: .leading, spacing: 20) {
                                    HStack(spacing: 170) {
                                        
                                        Button {
                                            
                                            print("testing")
                                            
                                        } label: {
                                            NavigationLink(destination: BoxInvoiceView()) {
                                                
                                                Image("8095561")
                                                    .padding(.leading)
                                                   // .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.04)
                                                
                                            }
                                        }
                                        
                                      

                                        HStack {
                                        Text("Cashbox Status is")
                                            .bold()
                                        Text(boxStatus)
                                               .bold()
                                            .foregroundColor(.init(Color(red: 0.463, green: 0.483, blue: 1.034)))

                                        }
//                                        .padding(.trailing)
//                                        .frame(width: UIScreen.main.bounds.width * 0.17, height: UIScreen.main.bounds.height * 0.04)
                                        .frame(width:250, height: 80)
                                    }
                                    
                                    
                                    VStack(alignment: .leading) {
                                        
                                        HStack(spacing: 5) {
                                            Image("History")
                                             
                                            
                                            VStack {
                                                Text("History for today".localized)
                                                    .foregroundColor(.init(Color(red: 0.463, green: 0.483, blue: 1.034)))
                                               // .frame(width: UIScreen.main.bounds.width * 0.10, height: UIScreen.main.bounds.height * 0.02)
                                                
                                                Divider()
                                                    .frame(width: 153)
                                            }
                                            
                                        }
                                        .padding(.leading)
                                       
                                        
                                       
                                           
                                        VStack(spacing: 10){
                                        
                                        HStack {
                                            Image("Lock")
                                                .foregroundColor(.init(Color(red: 0.463, green: 0.483, blue: 1.034)))
                                            
                                               // .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.05)
                                            
                                            Text("\(cashBoxViewModel.cashBox.openTime)")
                                             //  .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.height * 0.05)
                                                .frame(width: 182, height: 18)
                                            
                                        }
                                        .padding()
                                        
                                        HStack {
                                            Image("Lock")
                                                .foregroundColor(.init(Color(red: 0.463, green: 0.483, blue: 1.034)))
                                               // .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.05)
                                            
                                            Text("\(cashBoxViewModel.cashBox.closeTime)")
                                               // .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.height * 0.05)
                                                .frame(width: 182, height: 18)
                                        }
                                            
                                        }
                                    }.padding(7)
                                }
                                   //.padding(.bottom)
                                    
                                    
                                    // Spacer()
                                    
                                    Button {
                                        //action
                                        cashBoxOpen.isCashBoxOpen.toggle()
                                        
                                        
                                        if cashBoxOpen.isCashBoxOpen {
                                            print("call the setOpenData")
                                            
                                            
                                            cashBoxViewModel.cashBox.optNum = cashBoxViewModel.randomID()
                                            
                                            cashBoxViewModel.cashBox.openTime = Date.getCurrentDate()
                                            
                                            cashBoxViewModel.cashBox.openingCoins = [0.01: cheakInput(input: coins01s),
                                                                                     0.05:  cheakInput(input:coins05s),
                                                                                     0.10:  cheakInput(input:coins10s),
                                                                                     0.25:  cheakInput(input:coins25s),
                                                                                     0.50:  cheakInput(input:coins50s),
                                                                                     1.0 :  cheakInput(input:coins1s) ,
                                                                                     2.0 :  cheakInput(input:coins2s) ]


                                            cashBoxViewModel.cashBox.openingFiatCash = [  1.0: cheakInput(input: fiatCash1s) ,
                                                                                          5.0:  cheakInput(input: fiatCash5s) ,
                                                                                          10.0:  cheakInput(input: fiatCash10s),
                                                                                          20.0:  cheakInput(input: fiatCash20s),
                                                                                          50.0:  cheakInput(input: fiatCash50s),
                                                                                          100.0: cheakInput(input: fiatCash100s),
                                                                                          500.0: cheakInput(input: fiatCash500s)]
    //
                                          

                                          //  cashBoxViewModel.setOpeningData()
                                            ClearTextFields()
                                            
                                        }
                                        else {
                                            
                                            print("call the setCloseData")
                                            
                                            cashBoxViewModel.cashBox.closingCoins = [0.01: cheakInput(input: coins01s),
                                                                                     0.05:  cheakInput(input:coins05s),
                                                                                     0.10:  cheakInput(input:coins10s),
                                                                                     0.25:  cheakInput(input:coins25s),
                                                                                     0.50:  cheakInput(input:coins50s),
                                                                                     1.0 :  cheakInput(input:coins1s) ,
                                                                                     2.0 :  cheakInput(input:coins2s) ]


                                            cashBoxViewModel.cashBox.closingFiatCash = [  1.0: cheakInput(input: fiatCash1s) ,
                                                                                          5.0:  cheakInput(input: fiatCash5s) ,
                                                                                          10.0:  cheakInput(input: fiatCash10s),
                                                                                          20.0:  cheakInput(input: fiatCash20s),
                                                                                          50.0:  cheakInput(input: fiatCash50s),
                                                                                          100.0: cheakInput(input: fiatCash100s),
                                                                                          500.0: cheakInput(input: fiatCash500s)]
    //
                                          

                                            
                                            let userID = authViewModel.getCurrentUser()
                                            cashBoxViewModel.cashBox.uid = userID
                                            
    //                                        cashBoxViewModel.cashBox.closeTime = Date.getCurrentDate()
    //                                        cashBoxViewModel.cashBox.totalSales = 0.0
    //                                        cashBoxViewModel.cashBox.totalNetSales = 0.0
    //                                        cashBoxViewModel.cashBox.totalNetCreditCard = 0.0
    //                                        cashBoxViewModel.cashBox.totalNetCash = 0.0
                                            
                                           cashBoxViewModel.setClosingData()
                                            
                                             cashBoxViewModel.addCashBox()
                                            
                                   //   createCashBoxViewModel.addCashDay(cashBoxViewModel.cashBox)
                                            
                                            ClearTextFields()
                                            ClearTotal()
                                       
                                        }
                                        
                                    } label: {
                                        
                                        HStack {
                                            
                                            Text(buttonLabel)
                                                .font(.title3)
                                                .fontWeight(.semibold)
                                                //.frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.05)
                                                .frame(width: 320, height: 50)
                                                .background(Color(red: 0.463, green: 0.483, blue: 1.034))
                                                .foregroundColor(.white)
                                                .cornerRadius(6)
                                            
                                        }
                                    }
                                }
                            }
                            
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .frame(width: UIScreen.main.bounds.width * 0.33, height: UIScreen.main.bounds.height * 0.50 ,alignment: .center)
                                
                                
                                
                                VStack {
                                    
                                    VStack{
                                    Text("Sales")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                          //  .frame(width: 150, height: 50)

                               //      Divider()
                                        
                                        
                                        VStack(alignment: .leading, spacing: 38){
                                            
                                            cashBoxText(total: Text("\((cashBoxViewModel.cashBox.openingCash),specifier: "%.2f")"), titel: Text("Previous Balance"))

                                            cashBoxText(total: Text("\((cashBoxViewModel.finalTotalCash),specifier: "%.2f")"), titel: Text("Total Net Cash"))
                                            
                                            cashBoxText(total: Text("\((cashBoxViewModel.totalCreditCard),specifier: "%.2f")"), titel: Text("Total Net Credit Card"))
                                            
                                          cashBoxText(total: Text("\((cashBoxViewModel.totalCreditCard + cashBoxViewModel.finalTotalCash),specifier: "%.2f")"), titel: Text("Total Net Sales"))
                                        
                                          cashBoxText(total: Text("\((cashBoxViewModel.totalCreditCard + cashBoxViewModel.finalTotalCash),specifier: "%.2f")"), titel: Text("Total Sales"))
                                            
                                        }.padding(.trailing)
                                        
                                    }
//                                    .padding(.trailing, 6)
//                                    .padding(.leading, 6)
//
                                    
                                

                                     
                                }
                                 
                            }
                        }.padding(.trailing)
                    }.padding()
                }
               
//                .padding(.top, 30)
                if  loginPopUpCheck.showingLoginAlert {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.vertical)
                    
                    LoginPopUp(username: username, password: password, isLoading: isLoading, authViewModel: _authViewModel)
                        .opacity(loginPopUpCheck.showingLoginAlert ? 1 : 0)
                }
                
                
            }
            .onAppear(perform: {
                cashBoxViewModel.total()
                cashBoxViewModel.finalCashTotal()
            })
           // .padding(.bottom)
            
            }.navigationViewStyle(StackNavigationViewStyle())
                .accentColor(.init(Color(red: 0.463, green: 0.483, blue: 1.034)))
        }
  }
    
    
    func ClearTextFields() {
        
        coins01s = ""
        coins05s = ""
        coins10s = ""
        coins25s = ""
        coins50s = ""
        coins1s  = ""
        coins2s  = ""
        
        fiatCash1s  = ""
        fiatCash5s  = ""
        fiatCash10s = ""
        fiatCash20s = ""
        fiatCash50s = ""
        fiatCash100s = ""
        fiatCash500s = ""
        
        
    }
    
    func ClearTotal() {
        
        cashBoxViewModel.finalTotalCash = 0.0
        cash = ""
        cashBoxViewModel.totalCreditCard = 0.0
        cashBoxViewModel.totalSales = 0.0
        cashBoxViewModel.finalTotalCash = 0.0
        cashBoxViewModel.totalCreditCard = 0.0
        cashBoxViewModel.cashBox.openingCash = 0.0
        cashBoxViewModel.totalCreditCard = 0.0
    }
    
    func cheakInput(input: String) -> Int{
        if Int(input) != nil {
              return Int(input)!
           } else {
               return 0
    }
   
    }
}

struct CashBoxView_Previews: PreviewProvider {
   
    static var previews: some View {
        
        let cashBoxOpen = CashBoxOpen()
        let cashBoxViewModel = CashBoxViewModel()
        let authViewModel = AuthViewModel()
        let loginPopUpCheck = LoginPopUpCheck()
        CashBoxView()
            .environmentObject(cashBoxOpen)
            .environmentObject(cashBoxViewModel)
            .environmentObject(authViewModel)
            .environmentObject(loginPopUpCheck)
    }
}
