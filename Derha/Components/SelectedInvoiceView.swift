//
//  SelectedInvoiceView.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 08/06/1444 AH.
//

import Foundation
import SwiftUI


struct SelectedInvoiceView: View {
    
    @ObservedObject var orderViewModel = OrderViewModel()
    @ObservedObject var storeViewModel = StoreViewModel()
    @Binding var presented: Bool
    let invoice: Invoice
    let order: Order
  //  @State var code = UIImage(imageLiteralResourceName: "")
    @State var image: UIImage? = UIImage(named: "")

    
    var body: some View {
        VStack {
            HStack {
               
             
                VStack {
                    
                    HStack {
                        Button {
                            print("barcodeButton clicked")
                            presented = true

                        } label: {
                            Image("printer")
                                .resizable()
                                .foregroundColor(Color("Color-3"))
                                .frame(width: 70, height: 55)
                    }
                        
                        Button {
                            print("barcodeButton clicked")
                            presented = true

                        } label: {
                            Image("MdZoomOutMap")
                               
                                .foregroundColor(Color("Color-3"))
                                
                        }
                    }
                    
                    Text("INVOICE")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    .padding(1)
                    
                    
                    
                    
                }
                
               
               
                
                
                
            }
            
            Text("invoice number: #\(invoice.id)".localized)
                .bold()
                .font(.system(size: 15))
                .foregroundColor(.black)
                .padding(1)
            
            Group{
                Text("\(storeViewModel.store.storeName)")
                .bold()
                .font(.system(size: 20))
                .foregroundColor(.black)
                .padding(1)
            
            Text("\(storeViewModel.store.address)")
                .font(.system(size: 15))
                .foregroundColor(.black)
                .padding(1)
            
            Text("\(storeViewModel.store.storePhoneNumber) :هاتف")
                .font(.system(size: 15))
                .foregroundColor(.black)
                .padding(1)
         
            
            Text("فاتورة الضريبة المبسطة")
                .font(.system(size: 15))
                .foregroundColor(.black)
                .padding(1)
            }
            
            HStack{
                Text("Date: \(String(invoice.time.prefix(10)) as String)")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                    .frame(width: UIScreen.main.bounds.width * 0.27, height: UIScreen.main.bounds.height * 0.06, alignment: .leading)
                
                Text("Time: \(invoice.time.components(separatedBy: " ").last!)")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                    .padding(.trailing, 10)
                    .frame(width: UIScreen.main.bounds.width * 0.10, height: UIScreen.main.bounds.height * 0.06, alignment: .trailing)
            }
            //.frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.04)
            
            Text("Tax Number :123456789900003")
                .bold()
                .font(.system(size: 15))
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.width * 0.36, height: 20, alignment: .leading)

            
            HStack(alignment: .center){
                Text("Product")
                    .bold()
                    .font(.system(size: 15))
                    .frame(width: UIScreen.main.bounds.width * 0.15, height: 40, alignment: .leading)
                    .padding(.leading, 25)


                Text("Qty")
                    .bold()
                    .font(.system(size: 15))
                    .frame(width: UIScreen.main.bounds.width * 0.09, height: 40)

                Text("Total")
                    .bold()
                    .font(.system(size: 15))
                    .frame(width: UIScreen.main.bounds.width * 0.09, height: 40)

            }.background(Color(UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)))
              .padding()
            
           
            
            Group {
                List{
                    ForEach(orderViewModel.orderItems) { i in
                        OrderItemRow(orderItem: i)
                    }
                }
                
                Divider()
                       .frame(width: 430, height: 1)
                       .overlay(.black)

                
                HStack{
                Text("Sub Total")
                    .font(.system(.headline))
                    .frame(width: UIScreen.main.bounds.width * 0.26, height: 20, alignment: .leading)
                    .padding(.leading, 25)
                    
                Text("\((order.subTotal) , specifier: "%.2f") SAR")
                        .font(.system(.headline))
                        .frame(width: UIScreen.main.bounds.width * 0.11, height: 20)
                    
                }
                
                HStack{
                Text("Tax (GST) : 15%")
                    .font(.system(.subheadline))
                    .frame(width: UIScreen.main.bounds.width * 0.25, height: 20, alignment: .leading)
                    .padding(.leading, 25)
                    
                Text("\((invoice.tax) , specifier: "%.2f") SAR")
                        .font(.system(.subheadline))
                        .frame(width: UIScreen.main.bounds.width * 0.12, height: 20)
                    
                }
                
                
                Divider()
                    .frame(width: 430, height: 1)
                    .overlay(.black)

               
                HStack{
                Text("Total")
                    .font(.system(.headline))
                    .frame(width: UIScreen.main.bounds.width * 0.26, height: 20, alignment: .leading)
                    .padding(.leading, 25)
                    
                Text("\((invoice.total) , specifier: "%.2f") SAR")
                        .font(.system(.headline))
                        .frame(width: UIScreen.main.bounds.width * 0.11, height: 20)
                }
            }
            
         
            Image(uiImage: QRcode(code: invoice.code))
                .resizable()
                .frame(width: 150, height: 100)
            
        }
        
    }
    
    
    func QRcode(code: String) -> UIImage {
        
         guard let qr = QRManager.generateQRCode(from: code) else { return UIImage(imageLiteralResourceName: "") }
         guard let centeredQR = qr.alignmentImageIn(width: PrintManager.shared.printerSize.getPoints(), alignment: .center) else { return UIImage(imageLiteralResourceName: "")  }
         
         return centeredQR
     }
    
}

struct OrderItemRow: View {
    let orderItem: OrderItem
    
    var body: some View {
        
        HStack{
            VStack{
                Text(orderItem.itemNameEng)
                    .font(.system(size: 12))
                Text(orderItem.itemNameAR)
                    .font(.system(size: 12))
            }
            .frame(width: UIScreen.main.bounds.width * 0.15, height: 10, alignment: .leading)
            .padding(.leading, 25)
            
             Text("\(Int(orderItem.quantity))")
                .font(.system(size: 12))
                .frame(width: UIScreen.main.bounds.width * 0.09, height: 10)
            
             Text("\((orderItem.priceForEachItem), specifier: "%.2f")")
                .font(.system(size: 12))
                .frame(width: UIScreen.main.bounds.width * 0.09, height: 10)
            
        }
    }
}
