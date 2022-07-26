
//
//import SwiftUI
//
//struct OrderView: View {
//    let checkout: LocalizedStringKey = "Checkout"
//    let totaltext: LocalizedStringKey = "Total"
//    let price: LocalizedStringKey = "Price"
//    @State var SearchText: String = ""
//    @State var total: String = ""
//    @State var receivedAmount: String = ""
//    @State var leftAmount: String = ""
//    @State var showPopUp: Bool = false
//    @State private var didTapFirst:Bool = false
//    @State private var didTapSecond:Bool = false
//    @StateObject var orderViewModel = OrderViewModel()
//    @State private var isEditing = false
//    @State var itemQuantityTotalEachOreder = 0
//    @State var scanError: String = ""
//    @State var showCam: Bool = false
//    @State var showingAlert: Bool = false
//    @State var presented = false
//
//    func scannedCode(_ code: String){
//        print("code: \(code)")
//    }
//
//    func scanErrorMessage(_ message: String){
//        print("error: \(message)")
//    }
//
//    func scannerView() -> some View {
//
//        return QRScannerView(scannedCode: $SearchText.didSet(execute: { scannedCode in
//
//
//            orderViewModel.fictchItem(ItemId: scannedCode)
//
//
//        }), scanError: $scanError.didSet(execute: { errorMessage in
//
//            self.scanErrorMessage(errorMessage)
//
//        }))
//
//    }
//
//    init(){
//        UITableView.appearance().backgroundColor = .white
//    }
//    var body: some View {
//        ZStack {
//            Color(red: 0.949, green: 0.949, blue: 0.971 )
//                .ignoresSafeArea()
//            ScrollView(.vertical, showsIndicators: false){
//                VStack{
//                    VStack(alignment: .center) {
//                        VStack {
//                            OrderSearchView(SearchText: $SearchText, orderViewModel: orderViewModel, showCam: $showCam, presented: $presented)
//
//
//                        }.padding(.bottom, 7.0)
//
//                    }
//                    HStack {
//                        VStack{
//                            ZStack {
//
//                                RoundedRectangle(cornerRadius: 10)
//                                    .fill(Color.white)
//
//                                HStack{
//                                    VStack{
//                                        VStack {
//                                            HStack {
//                                                HStack {
//
//                                                    Text("Product Code")
//                                                        .font(.headline)
//                                                        .fontWeight(.bold)
//                                                        .frame(width: UIScreen.main.bounds.width * 0.11, height: UIScreen.main.bounds.width * 0.02)
//                                                    Text("Arabic Name")
//                                                        .font(.headline)
//                                                        .fontWeight(.bold)
//
//                                                        .frame(width: UIScreen.main.bounds.width * 0.13, height:UIScreen.main.bounds.width * 0.02)
//                                                    Text("English Name")
//                                                        .font(.headline)
//                                                        .fontWeight(.bold)
//                                                        .frame(width: UIScreen.main.bounds.width * 0.13, height: UIScreen.main.bounds.width * 0.02)
//                                                    HStack {
//
//                                                        Text("Quantity")
//                                                            .font(.headline)
//                                                            .fontWeight(.bold)
//
//                                                    } .frame(width: UIScreen.main.bounds.width * 0.09, height: UIScreen.main.bounds.width * 0.02)
//                                                    HStack {
//                                                        Text(price)
//                                                            .font(.headline)
//                                                            .fontWeight(.bold)
//
//                                                    } .frame(width: UIScreen.main.bounds.width * 0.06, height:  UIScreen.main.bounds.width * 0.02)
//
//                                                }
//
//                                            } .padding([.bottom, .top], 18)
//
//                                            Divider()
//                                        }
//
//
//                                        List {
//                                            ForEach(self.orderViewModel.orderItems.filter({"\($0.productId)".contains(SearchText) || SearchText.isEmpty}), id: \.productId) { i in
//
//                                                RowViewForCheckout(item: i)
//
//
//                                            }.listRowBackground(Color(red: 0.958, green: 0.958, blue: 0.958))
//                                        }
//
//                                        Spacer()
//                                    }
//
//                                }
//
//                            }
//
//                        }.frame(width: UIScreen.main.bounds.width * 0.62, height: UIScreen.main.bounds.height * 0.89 ,alignment: .center)
//                            .preferredColorScheme(.light)
//                        VStack{
//
//                            VStack{
//                                ZStack {
//
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .fill(Color.white)
//
//                                    HStack{
//
//                                        //add total rectagnle
//
//                                        //try spacing between vstacks and hstacks
//
//                                        VStack(alignment: .center){
//                                            //                               Spacer()
//                                            //                               Spacer()
//                                            //                               Spacer()
//                                            //                               Spacer()
//
//                                            VStack(alignment: .leading) {
//
//
//                                                //  .frame(width: UIScreen.main.bounds.width * 0.05, height:  UIScreen.main.bounds.height * 0.02)
//
////                                                Text(totaltext)
////                                                    .font(.headline)
////                                                    .fontWeight(.bold)
////                                                    .padding(.leading, 5)
////                                                    .padding(.top, 1)
////                                                    .padding(.bottom, 70)
////                                                //           .offset(x: 10, y: -30)
////                                                    .frame(width: UIScreen.main.bounds.width * 0.07,    height:  UIScreen.main.bounds.height * 0.02)
//
//                                                // Spacer()
//                                                Text(totaltext)
//                                                    .font(.headline)
//                                                    .fontWeight(.bold)
//
//                                                Spacer()
//                                                Spacer()
//                                                Spacer()
//                                                //                                   Divider()
//                                                //                                    //   .padding(.bottom, 23)
//                                                ////                                      // .frame(width: UIScreen.main.bounds.width * 0.24,
//                                                ////                                              height:  UIScreen.main.bounds.height * 0.01)
//                                                //                                    .frame(width: UIScreen.main.bounds.width * 0.24,
//                                                //                                           height:  UIScreen.main.bounds.height * 0.01)
//                                                //
//
//                                                HStack{
//                                                    Text("Sub Total")
//                                                        .fontWeight(.semibold)
//
//                                                        .frame(width: UIScreen.main.bounds.width * 0.08, height: UIScreen.main.bounds.height * 0.05)
//
//
//
//                                                    Spacer()
//                                                    Text("\((orderViewModel.totalItem()), specifier: "%.2f")")
//
//                                                        .frame(width: UIScreen.main.bounds.width * 0.05, height:  UIScreen.main.bounds.height * 0.05)
//
//                                                    Text("SAR".localized)
//
//                                                        .frame(width: UIScreen.main.bounds.width * 0.05, height:  UIScreen.main.bounds.height * 0.05)
//
//
//                                                }
//                                                HStack{
//                                                    Text("Tax 15%")
//                                                        .fontWeight(.semibold)
//
//                                                        .frame(width: UIScreen.main.bounds.width * 0.07, height: UIScreen.main.bounds.height * 0.05)
//
//                                                    Spacer()
//                                                    Text("\((orderViewModel.totalItem() * 0.15), specifier: "%.2f")")
//
//                                                        .frame(width: UIScreen.main.bounds.width * 0.05, height:  UIScreen.main.bounds.height * 0.05)
//                                                    Text("SAR".localized)
//
//                                                        .frame(width: UIScreen.main.bounds.width * 0.05, height:  UIScreen.main.bounds.height * 0.05)
//
//                                                }
//                                                HStack{
//                                                    Text(totaltext)
//                                                        .fontWeight(.semibold)
//
//                                                        .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.05)
//                                                    Spacer()
//                                                    Text("\(((orderViewModel.totalItem()) + ((orderViewModel.totalItem() * 0.15))), specifier: "%.2f")")
//
//                                                        .frame(width: UIScreen.main.bounds.width * 0.05, height:  UIScreen.main.bounds.height * 0.05)
//                                                    Text("SAR".localized)
//
//                                                        .frame(width: UIScreen.main.bounds.width * 0.05, height:  UIScreen.main.bounds.height * 0.05)
//
//                                                }
//
//                                            }
//
//
//                                            //add buttons
//                                            VStack(alignment: .center){
//
//
//                                                Spacer()
//                                                Spacer()
//                                                Spacer()
//                                                Spacer()
//                                                Spacer()
//
//
//                                                VStack{
//
//                                                    Button(action: {
//                                                        self.didTapFirst = true
//                                                        self.didTapSecond = false
//                                                    }) {
//                                                        CustomButton(didTapFirst: $didTapFirst, didTapSecond: $didTapSecond, buttonName: "Credit Card", imageInTap: "CriditCard", defaultImage: "CriditCard2")
//                                                    }
//
//
//                                                    Button(action: {
//                                                        withAnimation {
//                                                            self.didTapFirst = false
//                                                            self.didTapSecond = true
//                                                            self.showingAlert.toggle()
//                                                            self.total = ""
//                                                            self.receivedAmount = ""
//                                                            self.leftAmount = ""
//
//                                                        }
//
//                                                    }) {
//
//                                                        HStack{
//                                                            Image(didTapSecond ? "Cash" : "Cash2")
//                                                                .resizable()
//                                                                .frame(width: 41.0, height: 41.0)
//                                                                .offset(x:-60)
//
//                                                            Text("Cash")
//                                                                .font(.headline)
//                                                                .foregroundColor(Color("Checkout"))
//                                                                .padding(.leading, -30)
//                                                        }
//                                                    }
//                                                    .frame(width: UIScreen.main.bounds.width * 0.18,
//                                                           height:  UIScreen.main.bounds.height * 0.01,
//                                                           alignment: .center)
//                                                    .padding(.all, 20)
//                                                    .background(Color("ButtonColor"))
//                                                    .cornerRadius(10)
//                                                    .overlay(
//                                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
//                                                            .strokeBorder(didTapSecond ? Color("Checkout") :  Color("ButtonColor"), lineWidth: 1)
//                                                    )
//
//                                                    Spacer()
//                                                    Spacer()
//                                                    Spacer()
//                                                    Spacer()
//                                                    Spacer()
//
//
//                                                    Button(action: {
//
//
//
//                                                        for item in orderViewModel.orderItems{
//                                                            orderViewModel.newOrderItem(productId: item.productId, quantity: Int(item.quantity))
//                                                            itemQuantityTotalEachOreder = itemQuantityTotalEachOreder + Int(item.quantity)
//                                                        }
//
//                                                        orderViewModel.newOrder(total: ((orderViewModel.totalItem()) + (orderViewModel.totalItem() * 0.15)), orderType: 1, paymentMethod: didTapSecond ? 0 : 1 , itemQuantityTotal: itemQuantityTotalEachOreder)
//
//
//                                                        orderViewModel.newInvoice(receivedAmount: Double(receivedAmount) ?? 0.0, leftAmount: Double(leftAmount) ?? 0.0, deservedAmount: Double(leftAmount) ?? 0.0, subTotal: ((orderViewModel.totalItem()) + ( orderViewModel.totalItem() * 0.15)), tax: 0.15)
//
//
//
//                                                        PrintManager.shared.printTicket(" Alhukaire الحكير", cartItems: orderViewModel.orderItems)
//
//                                                    }) {
//                                                        Text(checkout)
//                                                            .font(.headline)
//                                                            .fontWeight(.semibold)
//                                                            .foregroundColor(Color.white)
//                                                    }
//
//                                                    .frame(width: UIScreen.main.bounds.width * 0.18, height:  UIScreen.main.bounds.height * 0.01, alignment: .center)
//                                                    .padding(.all, 20)
//                                                    .background(Color("Checkout"))
//                                                    .cornerRadius(10)
//
//                                                }
//
//                                                Spacer()
//                                                Spacer()
//                                                Spacer()
//                                                Spacer()
//                                            }
//
//                                        }.frame(width: UIScreen.main.bounds.width * 0.23, height:  UIScreen.main.bounds.height * 0.40)
//                                    }
//
//                                }
//                                //end of new frame
//                            }.frame(width: UIScreen.main.bounds.width * 0.24, height: UIScreen.main.bounds.height * 0.58 ,alignment: .center)
//                                .padding(.trailing, 9)
//                            VStack{
//                                ZStack {
//
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .fill(Color.white)
//
//                                    HStack{
//
//                                        //add cam rectagnle
//
//                                        CameraView(showCam: $showCam, SearchText: $SearchText, orderViewModel: orderViewModel)
//
//                                    }
//
//                                }
//
//                            }.frame(width: UIScreen.main.bounds.width * 0.23, height: UIScreen.main.bounds.height * 0.30 ,alignment: .center)
//                                .padding(.trailing, 9)
//
//                        }.preferredColorScheme(.light)
//
//                    }
//
//                }
//                .padding(.leading, 13)
//            }
////
////            .ignoresSafeArea(.keyboard, edges: .bottom)
////
////
////            if $showingAlert.wrappedValue {
////                Color.black.opacity(0.4)
////                    .edgesIgnoringSafeArea(.vertical)
////
////                CustomAlert(total: $total, receivedAmount: $receivedAmount, leftAmount: $leftAmount, showingAlert: $showingAlert)
////                    .opacity(showingAlert ? 1 : 0)
////            }
////
////        }
////        .sheet(isPresented: $presented) {
////            PrinterVC()
////        }
////    }
////}
//
//
//struct OrderView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderView()
//
//            .environmentObject(OrderViewModel())
//
//
//    }
//}
//
//
//struct RowViewForCheckout: View {
//
//    @StateObject var item: OrderItem
//
//    var body: some View {
//
//
//        HStack {
//            Text(item.productId)
//                .frame(width: UIScreen.main.bounds.width * 0.11, height: 40)
//            Text("\(item.itemNameAR)")
//                .frame(width: UIScreen.main.bounds.width * 0.15, height: 40)
//            Text("\(item.itemNameEng)")
//                .frame(width: UIScreen.main.bounds.width * 0.13, height: 30)
//            Text("\(Int(item.quantity))")
//                .frame(width: UIScreen.main.bounds.width * 0.09, height: 30)
//            Text("\(item.priceForEachItem, specifier: "%.2f")")
//                .frame(width: UIScreen.main.bounds.width * 0.05, height: 30)
//        }
//    }
//}




//
//  CheckOutView.swift
//  Derha
//
//  Created by Shorouq Alyami on 22/07/2022.
//

import SwiftUI
import Printer

struct CheckOutView: View {
    let checkout: LocalizedStringKey = "Checkout"
    let totaltext: LocalizedStringKey = "Total"
    let price: LocalizedStringKey = "Price"
    @State var SearchText: String = ""
    @State var total: String = ""
    @State var receivedAmount: String = ""
    @State var leftAmount: String = ""
    @State var showPopUp: Bool = false
    @State private var didTapFirst:Bool = false
    @State private var didTapSecond:Bool = false
    @StateObject var orderViewModel = OrderViewModel()
    @State private var isEditing = false
    @State var itemQuantityTotalEachOreder = 0
    @State var scanError: String = ""
    @State var showCam: Bool = false
    @State var showingAlert: Bool = false
    @State var presented = false
    func scannedCode(_ code: String){
        print("code: \(code)")
    }
    
    func scanErrorMessage(_ message: String){
        print("error: \(message)")
    }
    
    func scannerView() -> some View {
        
        return QRScannerView(scannedCode: $SearchText.didSet(execute: { scannedCode in
            
           
            orderViewModel.fictchItem(ItemId: scannedCode)
            
            
        }), scanError: $scanError.didSet(execute: { errorMessage in
            
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
                                VStack( spacing: 0){
                                HStack(alignment: .center) {
                               
                                Text("Product Code")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(width: UIScreen.main.bounds.width * 0.11)
                                Text("Arabic Name")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                    .frame(width: UIScreen.main.bounds.width * 0.13)
                                Text("English Name")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(width: UIScreen.main.bounds.width * 0.13)
                                HStack {
                                    
                                    Text("Quantity")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                } .frame(width: UIScreen.main.bounds.width * 0.09)
                                HStack {
                                    Text(price)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                } .frame(width: UIScreen.main.bounds.width * 0.06)
                                
                                } .padding(.vertical)
                            
                            Divider()
                                }
                                
                                
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
                                    HStack{
                                        Text("Sub Total")
                                            .fontWeight(.semibold)
                                          
                                            .frame(width: UIScreen.main.bounds.width * 0.07, height: UIScreen.main.bounds.height * 0.05, alignment: .leading)
                                        
                                        
                                        
                                        Spacer()
                                        Text("\((orderViewModel.totalItem()), specifier: "%.2f")")
                                          
                                            .frame(width: UIScreen.main.bounds.width * 0.05, height:  UIScreen.main.bounds.height * 0.05)
                                        
                                        Text("SAR".localized)
                                          
                                            .frame(width: UIScreen.main.bounds.width * 0.03, height:  UIScreen.main.bounds.height * 0.05)
                                        
                                        
                                    }
                                    HStack{
                                        Text("Tax 15%")
                                            .fontWeight(.semibold)
                                         
                                            .frame(width: UIScreen.main.bounds.width * 0.07, height: UIScreen.main.bounds.height * 0.05, alignment: .leading)
                                        
                                        Spacer()
                                        Text("\((orderViewModel.totalItem() * 0.15), specifier: "%.2f")")
                                       
                                            .frame(width: UIScreen.main.bounds.width * 0.05, height:  UIScreen.main.bounds.height * 0.05)
                                        Text("SAR".localized)
                                     
                                            .frame(width: UIScreen.main.bounds.width * 0.03, height:  UIScreen.main.bounds.height * 0.05)
                                        
                                    }
                                    HStack{
                                        Text(totaltext)
                                            .fontWeight(.semibold)
                                        
                                            .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.05, alignment: .leading)
                                        Spacer()
                                        Text("\(((orderViewModel.totalItem()) + ((orderViewModel.totalItem() * 0.15))), specifier: "%.2f")")
                                         
                                            .frame(width: UIScreen.main.bounds.width * 0.05, height:  UIScreen.main.bounds.height * 0.05)
                                        Text("SAR".localized)
                                        
                                            .frame(width: UIScreen.main.bounds.width * 0.03, height:  UIScreen.main.bounds.height * 0.05)
                                        
                                    }
                                        }
                                        Spacer()
                                    
                                       
                                    
                                    
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
                                         .frame(width: UIScreen.main.bounds.width * 0.18, height:  UIScreen.main.bounds.height * 0.01, alignment: .center)
                                         .padding(.all, 20)
                                         .background(Color("ButtonColor"))
                                         .cornerRadius(10)
                                         .overlay(
                                             RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                 .strokeBorder(didTapSecond ? Color("Checkout") :  Color("ButtonColor"), lineWidth: 1)
                                         )
                                         .padding(.bottom, 40)
  
  
  
                                   
  
  
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
  
                                     .frame(width: UIScreen.main.bounds.width * 0.18, height:  UIScreen.main.bounds.height * 0.01, alignment: .center)
                                     .padding(.all, 20)
                                     .background(Color("Checkout"))
                                     .cornerRadius(10)
                                     
  
  
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
        } .preferredColorScheme(.light)
            if $showingAlert.wrappedValue {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.vertical)
                
                CustomAlert(total: $total, receivedAmount: $receivedAmount, leftAmount: $leftAmount, showingAlert: $showingAlert)
                    .opacity(showingAlert ? 1 : 0)
            }
            
        }
        .sheet(isPresented: $presented) {
            PrinterVC()
        }
    }
    }





struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView()
           
            .environmentObject(OrderViewModel())
           
            
    }
}



struct RowViewForCheckout: View {
    
    @StateObject var item: OrderItem
    
    var body: some View {
        
        
        HStack {
            Text(item.productId)
                .frame(width: UIScreen.main.bounds.width * 0.11, height: 40)
            Text("\(item.itemNameAR)")
                .frame(width: UIScreen.main.bounds.width * 0.15, height: 40)
            Text("\(item.itemNameEng)")
                .frame(width: UIScreen.main.bounds.width * 0.13, height: 30)
            Text("\(Int(item.quantity))")
                .frame(width: UIScreen.main.bounds.width * 0.09, height: 30)
            Text("\(item.priceForEachItem, specifier: "%.2f")")
                .frame(width: UIScreen.main.bounds.width * 0.05, height: 30)
        }
    }
}
