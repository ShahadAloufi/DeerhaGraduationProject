
import SwiftUI
import Printer

struct CheckOutView: View {
     let totaltext: LocalizedStringKey = "Total"
    @State var SearchText: String = ""
    @State var total: String = ""
    @State var receivedAmount: String = ""
    @State var leftAmount: String = ""
    @State var showPopUp: Bool = false
    @State private var didTapFirst:Bool = false
    @State private var didTapSecond:Bool = false
    @State private var isEditing = false
    @State var itemQuantityTotalEachOreder = 0
    @State var scanError: String = ""
    @State var showCam: Bool = false
    @State var showingAlert: Bool = false
    @State var presented = false
    @State var username = ""
    @State var password = ""
    @State var isLoading = false
   
    @EnvironmentObject var loginPopUpCheck: LoginPopUpCheck
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var cashBoxViewModel: CashBoxViewModel
    @EnvironmentObject var cashBoxOpen: CashBoxOpen
    @StateObject var orderViewModel = OrderViewModel()
    @StateObject var invoiceViewModel = InvoiceViewModel()
    @StateObject var storeViewModel = StoreViewModel()
   

    func scannedCode(_ code: String){
        print("code: \(code)")
    }
    
    func scanErrorMessage(_ message: String){
        print("error: \(message)")
    }
    
    func scannerView() -> some View {
        
        return QRScannerView(scannedCode: $SearchText.didSet(execute: { scannedCode in
            
            
            orderViewModel.fictchItem(ItemId: scannedCode)
            
            
        }), scanError: $scanError.didSet(execute: { errorMessage  in
            
            self.scanErrorMessage(errorMessage)
            
        }))
        
    }
    
    
    init(){
        UITableView.appearance().backgroundColor = .white
    }
    
    var body: some View {
        ZStack{
            Color(red: 0.949, green: 0.949, blue: 0.971 )
                .ignoresSafeArea()
            VStack{
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        OrderSearchView(SearchText: $SearchText, orderViewModel: orderViewModel, showCam: $showCam, presented: $presented)
                        HStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width * 0.63, height: UIScreen.main.bounds.height * 0.89 ,alignment: .center)
                                .overlay(
                                    VStack{
                                       
                                        OrderViewHeader()
                                        
                                        List {
                                            ForEach(self.orderViewModel.orderItems.filter({"\($0.productId)".contains(SearchText) || SearchText.isEmpty}), id: \.productId) { i in
                                                
                                                RowViewForCheckout(item: i)
                                                
                                            }.listRowBackground(Color(red: 0.958, green: 0.958, blue: 0.958))
                                        }
                                        Spacer()
                                    }
                                )
                            
                            
                            VStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: UIScreen.main.bounds.width * 0.23, height:  UIScreen.main.bounds.height * 0.55)
                                    .foregroundColor(.white)
                                    .overlay(
                                        VStack {
                                            VStack(alignment: .leading, spacing: 0){
                                                HStack(alignment: .center) {
                                                    
                                                    Text(totaltext)
                                                        .font(.headline)
                                                        .fontWeight(.bold)
                                                        .frame(width: UIScreen.main.bounds.width * 0.05)
                                                    
                                                } .padding(.vertical)
                                                
                                                Divider()
                                            }
                                            //
                                            
                                            VStack{
                                                VStack{
                                                    TotalText(titel: Text("Sub Total"), total: orderViewModel.subTotalItem())

                                                    TotalText(titel:  Text("Tax 15%"), total: orderViewModel.tax())
                                               
                                                    TotalText(titel:  Text(totaltext), total: orderViewModel.totalItem())
                                                   
                                                }
                                                Spacer()
                                                
                                                VStack{
                                                    
                                                    VStack{
                                                    Button(action: {
                                                        self.didTapFirst = true
                                                        self.didTapSecond = false
                                                    }) {
                                                        CustomButton(didTapFirst: $didTapFirst, didTapSecond: $didTapSecond, buttonName: "Credit Card", imageInTap: "CriditCard", defaultImage: "CriditCard2")
                                                    }
                                                    
                                                    
                                                    Button(action: {
                                                        withAnimation {
                                                            self.didTapFirst = false
                                                            self.didTapSecond = true
                                                            self.showingAlert.toggle()
                                                            self.total = ""
                                                            self.receivedAmount = ""
                                                            self.leftAmount = ""
                                                        }
                                                        
                                                    }) {
                                                        CustomButton(didTapFirst: $didTapSecond, didTapSecond: $didTapFirst, buttonName: "Cash", imageInTap: "Cash", defaultImage: "Cash2")
                                                    }
                                                  
                                                    } .padding(.bottom, 10)
                                                    
                                                    Button(action: {
                                                       
                                                        

                                                        if authViewModel.signedIn {
                                                            
                                                            if cashBoxOpen.isCashBoxOpen {
                                                                
                                                        for item in orderViewModel.orderItems {
                                                            orderViewModel.newOrderItem(productId: item.productId, quantity: Int(item.quantity), priceForEachItem: item.priceForEachItem, itemNameEng: item.itemNameEng, itemNameAR: item.itemNameAR)
                                                            itemQuantityTotalEachOreder = itemQuantityTotalEachOreder + Int(item.quantity)
                                                        }
                                                        
                                                          //  orderViewModel.order.
                                                         orderViewModel.setOrderData(subTotal: orderViewModel.subTotalItem(), orderType: 1, paymentMethod: didTapSecond ? 0 : 1 , itemQuantityTotal: itemQuantityTotalEachOreder)
                                                        
                                                            orderViewModel.newOrder()
                                                     
                                                            let userID = authViewModel.getCurrentUser()
                                                            invoiceViewModel.invoice.uid = userID
                                                            invoiceViewModel.invoice.orderInfo = orderViewModel.orderID
                                                            
                                                            invoiceViewModel.setInvoiceData(receivedAmount: Double(receivedAmount) ?? 0.0, leftAmount: Double(leftAmount) ?? 0.0, deservedAmount: Double(leftAmount) ?? 0.0, total: orderViewModel.totalItem(), storeName: storeViewModel.store.storeName)
                                                            
                                                            invoiceViewModel.addInvoice()
                                                            
                                                            PrintManager.shared.printTicket(storeViewModel.store.storeName, cartItems: orderViewModel.orderItems, code: invoiceViewModel.invoice.code)
                                                            
                                                            if didTapFirst {
                                                                
                                                            cashBoxViewModel.creditCardTotal(creditCard: orderViewModel.totalItem())
                                                                
                                                            }
                                                            else {
                                                        
                                                            cashBoxViewModel.cashTotal(cash: orderViewModel.totalItem())

                                                            }
                                                           
                                                        }
                                                            else {
                                                                cashBoxOpen.showingCashBoxAlert.toggle()
                                                            }
                                                            
                                                    }
                                                            else {
                                                                loginPopUpCheck.showingLoginAlert.toggle()
                                                            }
                                                       
                                                    }) {

                                                        checkoutButton()
                                                            .background((self.didTapFirst==false) &&  (self.didTapSecond==false) ? Color.init(UIColor(red: 0.437, green: 0.452, blue: 0.946, alpha: 0.38)) : Color.init(UIColor(red: 0.437, green: 0.452, blue: 0.946, alpha: 1)))
                                                            .cornerRadius(10)
                                                    }  .disabled((self.didTapFirst==false) &&  (self.didTapSecond==false))

                                                }
                                            } .padding()
                                            
                                            Spacer()
                                        }
                                    )
                                
                                VStack{
                                    CameraView(showCam: $showCam, SearchText: $SearchText, orderViewModel: orderViewModel)
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .preferredColorScheme(.light)
            if $showingAlert.wrappedValue {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.vertical)
                
                CustomAlert(total: $total, receivedAmount: $receivedAmount, leftAmount: $leftAmount, showingAlert: $showingAlert)
                    .opacity(showingAlert ? 1 : 0)
            }
            
            if  loginPopUpCheck.showingLoginAlert {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.vertical)
                
                LoginPopUp(username: username, password: password, isLoading: isLoading, authViewModel: _authViewModel)
                    .opacity(loginPopUpCheck.showingLoginAlert ? 1 : 0)
            }
            
            
            if  cashBoxOpen.showingCashBoxAlert {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.vertical)
                
                CashBoxPopUpView()
                    .opacity(cashBoxOpen.showingCashBoxAlert ? 1 : 0)
            }
            
            
        }
        .sheet(isPresented: $presented) {
            PrinterVC()
        }
        .onAppear(perform: {
            storeViewModel.fetchStore()
        })
    }
}


struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView()
            .environmentObject(OrderViewModel())
    }
}


