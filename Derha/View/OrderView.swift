import SwiftUI

struct OrderView: View {
    let checkout: LocalizedStringKey = "Checkout"
    let totaltext: LocalizedStringKey = "Total"
    let price: LocalizedStringKey = "Price"
    @State var SearchText: String = ""
    @State var total: String = ""
    @State var receivedAmount: String = ""
    @State var leftAmount: String = ""
    @State var showingAlert: Bool = false
    @State private var didTapFirst:Bool = false
    @State private var didTapSecond:Bool = false
    @ObservedObject var orderViewModel = OrderViewModel() 
    @State private var isEditing = false
    @State var itemQuantityTotalEachOreder = 0
    @State var scannedCode: String = ""
        @State var scanError: String = ""
        @State var showCam: Bool = false
    
        func scannedCode(_ code: String){
            print("code: \(code)")
        }
    
        func scanErrorMessage(_ message: String){
            print("error: \(message)")
        }
    
        func scannerView() -> some View {
    
            return QRScannerView(scannedCode: $SearchText.didSet(execute: { scannedCode in
    
                self.scannedCode(scannedCode)
                orderViewModel.fictchItem(ItemId: scannedCode)
    
    
            }), scanError: $scanError.didSet(execute: { errorMessage in
    
                self.scanErrorMessage(errorMessage)
    
            }))
    
        }
    
    init(){
        UITableView.appearance().backgroundColor = .white
    }
    
    var body: some View {
        
        ZStack {
            Color(  red: 0.949, green: 0.949, blue: 0.971 )
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    ZStack{
                        
                        
                        VStack{
                            VStack {
                                
                                HStack {
                                    TextField(" Scan barcode number here".localized, text: $SearchText).onChange(of: SearchText, perform: { newValue in
                                        orderViewModel.fictchItem(ItemId: newValue)
                                    })
                                    .padding(15)
                                    .padding(.horizontal, 25)                       .frame(width: 620, height: 35)
                                    .background(Color(.white))
                                    .cornerRadius(8)
                                    
                                    .overlay(
                                        HStack{
                                            Image(systemName: "magnifyingglass")
                                                .foregroundColor(.gray)
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
                                    ).onTapGesture{
                                        self.isEditing = true
                                    }
                                    if isEditing{
                                        Button(action: {
                                            self.isEditing = false
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        }){
                                            Text("Cancel".localized)
                                                .padding()
                                        }
                                        .transition(.move(edge: .trailing))
                                    }
                                    Button {
                                        print("barcodeButton clicked")
                                        showCam.toggle()

                                    } label: {
                                        Image("barcodeButton")
                                        
                                            .foregroundColor(Color("Color-3"))
                                            .padding(8)
                                    }
                                }
                          
                                
                            }
                            
                            VStack{
                                HStack {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white)
                                        
                                        VStack{
                                            VStack {
                                                HStack {
                                                    
                                                    HStack {
                                                        
                                                        Text("Product Code")
                                                            .font(.headline)
                                                            .fontWeight(.bold)
                                                            .frame(width: UIScreen.main.bounds.width * 0.11, height: 20)
                                                        Text("Arabic Name")
                                                            .font(.headline)
                                                            .fontWeight(.bold)
                                                        
                                                            .frame(width: UIScreen.main.bounds.width * 0.14, height: 20)
                                                        Text("English Name")
                                                            .font(.headline)
                                                            .fontWeight(.bold)
                                                            .frame(width: UIScreen.main.bounds.width * 0.14, height: 20)
                                                        HStack {
                                                            
                                                            Text("Quantity")
                                                                .font(.headline)
                                                                .fontWeight(.bold)
                                                            
                                                            
                                                            
                                                            
                                                        } .frame(width: UIScreen.main.bounds.width * 0.08, height: 20)
                                                        HStack {
                                                            Text(price)
                                                                .font(.headline)
                                                                .fontWeight(.bold)
                                                            
                                                            
                                                            
                                                            
                                                        } .frame(width: UIScreen.main.bounds.width * 0.06, height: 20)
                                                        
                                                        
                                                    }
                                                    
                                                    
                                                    
                                                    
                                                } .padding([.bottom, .top], 18)
                                                
                                                Divider()
                                            }
                                            
                                            
                                            
                                            List {
                                                ForEach(self.orderViewModel.orderItems.filter({"\($0.productId)".contains(SearchText) || SearchText.isEmpty}), id: \.productId) { i in
                                                    RowViewForCheckout(item: i)
                                                    
                                                }.listRowBackground(Color(red: 0.958, green: 0.958, blue: 0.958))
                                            }
                                            
                                        }
                                        
                                    }
                                    .frame(width: 711, height: 700)
                                    
                                    
                                    VStack {
                                        VStack{
                                            VStack(alignment: .leading){
                                                VStack {
                                                    Text(totaltext)
                                                        .font(.headline)
                                                        .fontWeight(.bold)
                                                        .padding(.bottom, 12)
                                                }.padding(3)
                                                Divider()
                                                
                                                HStack{
                                                    Text("Sub Total")
                                                        .fontWeight(.semibold)
                                                    Spacer()
                                                    Text("\((orderViewModel.totalItem()), specifier: "%.2f")")
                                                    Text("SAR".localized)
                                                    
                                                    
                                                }
                                                HStack{
                                                    Text("Tax 15%")
                                                        .fontWeight(.semibold)
                                                    
                                                    Spacer()
                                                    Text("\((orderViewModel.totalItem() * 0.15), specifier: "%.2f")")
                                                    Text("SAR".localized)
                                                    
                                                }.padding(.top)
                                                HStack{
                                                    Text(totaltext)
                                                        .fontWeight(.semibold)
                                                    Spacer()
                                                    Text("\(((orderViewModel.totalItem()) + ((orderViewModel.totalItem() * 0.15))), specifier: "%.2f")")
                                                    Text("SAR".localized)
                                                    
                                                }.padding(.top)
                                                
                                                
                                            }
                                            
                                            Spacer()
                                                .frame(height: 80)
                                            
                                            
                                            
                                            VStack {
                                                
                                                Button(action: {
                                                    self.didTapFirst = true
                                                    self.didTapSecond = false
                                                }) {
                                                    CustomButton(didTapFirst: $didTapFirst, didTapSecond: $didTapSecond, buttonName: "Credit Card", imageInTap: "CriditCard", defaultImage: "CriditCard2")
                                                }
                                                
                                                Button(action: {
                                                    self.didTapFirst = false
                                                    self.didTapSecond = true
                                                    self.showingAlert.toggle()
                                                    self.total = ""
                                                    self.receivedAmount = ""
                                                    self.leftAmount = ""
                                                }) {
                                                    
                                                    HStack{
                                                        Image(didTapSecond ? "Cash" : "Cash2")
                                                            .resizable()
                                                            .frame(width: 41.0, height: 41.0)
                                                            .offset(x:-60)
                                                        
                                                        Text("Cash")
                                                            .font(.headline)
                                                            .foregroundColor(Color("Checkout"))
                                                            .padding(.leading, -30)
                                                    }
                                                }
                                                .frame(width: 203, height: 10)
                                                .padding(.all, 20)
                                                .background(Color("ButtonColor"))
                                                .cornerRadius(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                        .strokeBorder(didTapSecond ? Color("Checkout") :  Color("ButtonColor"), lineWidth: 1)
                                                )
                                                
                                            }
                                            
                                            Spacer()
                                                .frame(height: 30)
                                            
                                            
                                            Button(action: {
                                                
                                                
                                                
                                                for item in orderViewModel.orderItems{
                                                    orderViewModel.newOrderItem(productId: item.productId, quantity: Int(item.quantity))
                                                    itemQuantityTotalEachOreder = itemQuantityTotalEachOreder + Int(item.quantity)
                                                }
                                                
                                                orderViewModel.newOrder(total: ((orderViewModel.totalItem()) + (orderViewModel.totalItem() * 0.15)), orderType: 1, paymentMethod: didTapSecond ? 0 : 1 , itemQuantityTotal: itemQuantityTotalEachOreder)
                                                
                                                
                                                orderViewModel.newInvoice(receivedAmount: Double(receivedAmount) ?? 0.0, leftAmount: Double(leftAmount) ?? 0.0, deservedAmount: Double(leftAmount) ?? 0.0, subTotal: ((orderViewModel.totalItem()) + ( orderViewModel.totalItem() * 0.15)), tax: 0.15)
                                                
                                                PrintManager.shared.printTicket(" Alhukaire الحكير", cartItems: orderViewModel.orderItems)
                                                
                                            }) {
                                                Text(checkout)
                                                    .font(.headline)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(Color.white)
                                            }
                                            
                                            .frame(width: 203, height: 10, alignment: .center)
                                            .padding(.all, 20)
                                            .background(Color("Checkout"))
                                            .cornerRadius(10)
                                            
                                        }
                                        .padding(.bottom)
                                        .padding()
                                        .frame(width: 300, height: 500) //700
                                        .background(Color.white)
                                    .cornerRadius(10)
                                    
                               
                                  
                                    VStack{
                                    if showCam {
                                        scannerView()
                                            .padding()
                                            .frame(width: 300, height: 150, alignment: .center)
                                    }
                                    }
                                        .frame(width: 300, height: 190) //700
                                        .background(Color.white)
                                        .cornerRadius(10)
                                    
                                    
                                    }
                                    
                                }.padding([.leading, .trailing], 10)
                                   
                            }
                        }
                        
                        if $showingAlert.wrappedValue {
                            Color.black.opacity(0.4)
                                .edgesIgnoringSafeArea(.vertical)
                            
                            CustomAlert(total: $total, receivedAmount: $receivedAmount, leftAmount: $leftAmount, showingAlert: $showingAlert)
                                .opacity(showingAlert ? 1 : 0)
                        }
                        
                        
                        
                    }
                    
                }
            }
        }
    }
}


struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .previewInterfaceOrientation(.landscapeRight)
            .environmentObject(OrderViewModel())
    }
}

struct RowViewForCheckout: View {
    
    @StateObject var item: OrderItem
    @ObservedObject var example2 = OrderViewModel()
    
    var body: some View {
        
        
        HStack {
            Text(item.productId)
                .frame(width: UIScreen.main.bounds.width * 0.10, height: 40)
            Text("\(item.itemNameAR)")
                .frame(width: UIScreen.main.bounds.width * 0.15, height: 40)
            Text("\(item.itemNameEng)")
                .frame(width: UIScreen.main.bounds.width * 0.14, height: 30)
            Text("\(Int(item.quantity))")
                .frame(width: UIScreen.main.bounds.width * 0.07, height: 30)
            Text("\(item.priceForEachItem, specifier: "%.2f")")
                .frame(width: UIScreen.main.bounds.width * 0.05, height: 30)
        }
    }
}
