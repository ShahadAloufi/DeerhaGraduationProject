//
//  InvoiceView.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 04/06/1444 AH.
//

import SwiftUI


struct InvoiceView: View {
    @State var presented = false
    @State private var isEditing = false
    let backgroundColor : Color = Color(red: 246/255, green: 246/255, blue: 246/255)
    let lightPurple : UIColor = UIColor(Color(red: 119/255, green: 123/255, blue: 255/255).opacity(0.3))
    let ourOrange: Color = Color(red: 254/255, green: 154/255, blue: 138/255)
    let purple: Color = Color(red: 119/255, green: 123/255, blue: 255/255)
    @State private var selectedIndex = 0
    @State private var selectedOrder: Invoice = Invoice(id: "", orderInfo: "", receivedAmount: 0.0, leftAmount: 0.0, deservedAmount: 0.0, total: 0.0, tax: 0.0, time: "", code: "", uid: "")
    @State var SearchText = ""
    let ourPurple : Color = Color(UIColor(red: 119/255, green: 123/255, blue: 255/255, alpha: 41))
   // @StateObject var invoiceViewModel = InvoiceViewModel()
    @StateObject var orderViewModel = OrderViewModel()
    @State private var order: Order = Order(id: "", subTotal: 0.0, orderType: 0, paymentMethod: 0, items: [], itemQuantityTotal: 0)
    @StateObject var storeViewModel = StoreViewModel()
    
    @State var username = ""
    @State var password = ""
    @State var isLoading = false

    @EnvironmentObject var loginPopUpCheck: LoginPopUpCheck
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var invoiceViewModel = InvoiceViewModel()
  //  let invoice: Invoice
    
    var body: some View {
        ZStack{
            
            Color(  red: 0.949, green: 0.949, blue: 0.971 )
                .ignoresSafeArea()
            
            
            VStack{
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            TextField(" Search by invoice number here".localized, text: $SearchText)
                                .padding(15)
                                .padding(.horizontal, 25)
                                .frame(width: 620, height: 40)
                               
                                .background(Color(.white))
                                .cornerRadius(8)
                                .overlay(
                                    HStack{
                                        Image(systemName: "magnifyingglass")
                                        
                                            .foregroundColor(.init(Color(red: 0.463, green: 0.483, blue: 1.034)))
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading, 15)
                                        
                                        
                                        if isEditing{
                                            Button(action: {
                                                self.SearchText = ""
                                            }, label: {
                                                Image(systemName: "multiply.circle.fill")
                                                    .foregroundColor(.gray)
                                                    .padding(.trailing, 12)
                                            })
                                        }
                                    }
                                ).onTapGesture {
                                    self.isEditing = true
                                }
                            if isEditing{
                                Button(action: {
                                    self.isEditing = false
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    
                                }){
                                    Text("Cancel")
                                        .padding()
                                    
                                }
                                .transition(.move(edge: .trailing))
                            }
                        }
                    }
                   
                }
                
                HStack(alignment: .bottom, spacing: 16) {
                    
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: UIScreen.main.bounds.width * 0.43, height: UIScreen.main.bounds.height * 0.89)
                        .foregroundColor(.white)
                        .overlay(){
                            VStack(alignment: .leading, spacing: 20){
                                
                                Picker("Favorite Color", selection: $selectedIndex, content: {
                                    Text("Daily").tag(0)
                                    Text("Monthly").tag(1)
                                    Text("Yearly").tag(2)
                                    
                                })
                                .pickerStyle(SegmentedPickerStyle()) // <1>
                                
                                switch(selectedIndex){
                                case 0:
                                    Text("Bills during this day")
                                    List{
                                        ForEach(self.invoiceViewModel.invoices.filter({"\($0.id)".contains(SearchText) || SearchText.isEmpty}), id: \.id) { i in
                                            
                                            HStack{
                                                VStack(alignment: .leading, spacing: 20){
                                                    Text("Invoice number #\(i.id)")
                                                        .bold()
                                                        .font(.system(size: 18))
                                                        .foregroundColor(.black)
                                                    
                                                    Text("Grand total \((i.total), specifier: "%.2f")")
                                                        .bold()
                                                        .font(.system(size: 15))
                                                        .foregroundColor(.black)
                                                }
                                                
                                                Spacer()
                                                
                                                
                                                VStack(alignment: .trailing, spacing: 20){
                                                    Text(i.time.components(separatedBy: " ").last!)
                                                        .font(.system(size: 15))
                                                        .foregroundColor(.black)
                                                    
                                                    Text(invoiceViewModel.isToday(dateString: invoiceViewModel.dateOrTime(date: i.time, type: "date")))
                                                        .font(.system(size: 15))
                                                        .foregroundColor(.black)
                                                }
                                            }
                                            .padding([.top, .bottom], 10)
                                            
                                            
                                            .listRowBackground(selectedOrder == i ? ourPurple.opacity(0.3) : Color(UIColor.white).opacity(0))
                                                                   
                                                                   

                                                 
                                            .contentShape(Rectangle())
                                            
                                            .onTapGesture {
                                                    self.selectedOrder = i
                                                    orderViewModel.fetchOrder(orderID: i.orderInfo)
                                                    orderViewModel.orderItems = []
                                                
                                                
                                       }
                                            
                                        }
                                       
                                      
                                    }
                                    .onAppear(perform: {
                                        invoiceViewModel.fetchInvoice(uid:                                         authViewModel.getCurrentUser())
                                        storeViewModel.fetchStore()
                                    }
                                    )
                                    
                                    
                                    .listStyle(PlainListStyle())
                                case 1:
                                    //SegmentContent(selectedOrder: selectedOrder, segmentName: "Monthly")
                                    
                                    List{
                                      //  MonthlyInvoicesView()
                                            
                                      
                                    }
                                    .listStyle(PlainListStyle())
                                   
                                case 2:
                                    //SegmentContent(selectedOrder: selectedOrder, segmentName: "yearly")
                                    List{
                                      //  MonthlyInvoicesView()
                                            
                                      
                                    }
                                    .listStyle(PlainListStyle())
                                    
                                    
                                    
                                default: Text("nothing")
                                }
                            } .padding()
                        }
                    
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: UIScreen.main.bounds.width * 0.42, height: UIScreen.main.bounds.height * 0.89)
                        .foregroundColor(.white)
                        .overlay() {
                            VStack(alignment: .leading, spacing: 20) {
                              
                                SelectedInvoiceView(orderViewModel: orderViewModel, storeViewModel: storeViewModel, presented: $presented, invoice: selectedOrder, order: orderViewModel.fetchOrder)
                               
                            } .padding()
                        }
                }
                .padding(6)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                //.padding(.top, 50)
                Spacer()
            }
            //.ignoresSafeArea(.keyboard, edges: .bottom)
            .preferredColorScheme(.light)
            
            if  loginPopUpCheck.showingLoginAlert {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.vertical)
                
                LoginPopUp(username: username, password: password, isLoading: isLoading, authViewModel: _authViewModel)
                    .opacity(loginPopUpCheck.showingLoginAlert ? 1 : 0)
            }
            
            
            
        } .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
