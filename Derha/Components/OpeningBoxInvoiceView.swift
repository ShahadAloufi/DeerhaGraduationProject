//
//  SelectedBoxInvoiceView.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 03/07/1444 AH.
//

import SwiftUI


struct OpeningBoxInvoiceView: View {
    
    
    @ObservedObject var storeViewModel = StoreViewModel()
    @Binding var presented: Bool
    let cashBox: CashBox
    
    
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
                    
                    Text("\(storeViewModel.store.storeName)")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .padding(1)
                    
                }
                
            }
            
            VStack {
                
                
                
                InvoiceData(englishText:  Text("Opt. No: \(cashBox.optNum)"), arabicText: Text("رقم الحركة : \(cashBox.optNum)"))
                
                InvoiceData(englishText:  Text("Opt. Ty: Open"), arabicText: Text("نوع الحركة : فتح"))
                
                
                
                InvoiceData(englishText:  Text("Date: \((String(cashBox.openTime.prefix(10)) as String))"), arabicText: Text("التاريخ: \(String(cashBox.openTime.prefix(10)) as String)"))
                
                
                
                InvoiceData(englishText:  Text("Time: \(cashBox.openTime.components(separatedBy: " ").last!)"), arabicText: Text("الوقت: \(cashBox.openTime.components(separatedBy: " ").last!) "))
                
                
                
                
                VStack(alignment: .leading){
                    
                    cashBoxText(total: Text("\((cashBox.openingCash),specifier: "%.2f")"), titel: Text("Previous Balance"))
                  
                    
                }.padding(.trailing)
                
                Divider()
                
                Text("Cash distributions on the currency denomination:")
                    .bold()
                Group {
                Text("Paper currency")
                    .bold()
                    .underline()
                
                CurrencyRow(dict: cashBox.openingFiatCash)
                }
                
                Group {
                Text("coins")
                    .bold()
                    .underline()
                
                CurrencyRow(dict: cashBox.openingCoins)
                    
                }
            }
        }
    }
}
        
  
struct closingBoxInvoiceView: View {

    @ObservedObject var storeViewModel = StoreViewModel()
    @Binding var presented: Bool
    let cashBox: CashBox
    
    
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
                    
                    Text("\(storeViewModel.store.storeName)")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .padding(1)
                    
                }
                
            }
            
            VStack {
                
                InvoiceData(englishText:  Text("Opt. No: 1234567"), arabicText: Text("رقم الحركة : ١٢٣٤٥٦٧"))
                
                InvoiceData(englishText:  Text("Opt. Ty: Close"), arabicText: Text("نوع الحركة : اغلاق"))
                
                InvoiceData(englishText:  Text("Date: \((String(cashBox.closeTime.prefix(10)) as String))"), arabicText: Text("التاريخ: \(String(cashBox.closeTime.prefix(10)) as String)"))
                
                InvoiceData(englishText:  Text("Time: \(cashBox.closeTime.components(separatedBy: " ").last!)"), arabicText: Text("الوقت: \(cashBox.closeTime.components(separatedBy: " ").last!) "))
                
                
                
                VStack(alignment: .leading){
                    

                    cashBoxText(total: Text("\((cashBox.totalNetCash),specifier: "%.2f")"), titel: Text("Total Net Cash"))
                    
                    cashBoxText(total: Text("\((cashBox.totalNetCreditCard),specifier: "%.2f")"), titel: Text("Total Net Credit Card"))
                    
                    cashBoxText(total: Text("\((cashBox.totalSales),specifier: "%.2f")"), titel: Text("Total Net Sales"))
                    
                    cashBoxText(total: Text("\((cashBox.totalSales),specifier: "%.2f")"), titel: Text("Total Sales"))
                    
                }.padding(.trailing)
                
                Divider()
                
                Text("Cash distributions on the currency denomination:")
                    .bold()
                
                Group {
                Text("Paper currency")
                    .bold()
                    .underline()
                
                CurrencyRow(dict: cashBox.closingFiatCash)
                }
                
                Group {
                Text("coins")
                    .bold()
                    .underline()
                
                 CurrencyRow(dict: cashBox.closingCoins)
                }
            }
        }
    }
}



struct CurrencyRow: View {
    
    let dict: [Double:Int]

    var body: some View {
        
        let keys = dict.map{$0.key}
        let values = dict.map {$0.value}
        
        VStack{
            
            HStack(alignment: .center){
                Text("Currency denomination".localized)
                    .bold()
                    .font(.system(size: 15))
                    .frame(width: UIScreen.main.bounds.width * 0.08, height: 40, alignment: .leading)
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
            
            
           ForEach(keys.indices, id: \.self) { i in
            
                HStack{
                    Text("\((keys[i]),specifier: "%.2f") s")
                        .font(.system(size: 12))
                        .frame(width: UIScreen.main.bounds.width * 0.09, height: 10)
                    
                    Text("\((values[i]),specifier: "%.2f")")
                        .font(.system(size: 12))
                        .frame(width: UIScreen.main.bounds.width * 0.09, height: 10)
                    
                    Text("\((keys[i] * Double(values[i])),specifier: "%.2f")")
                        .font(.system(size: 12))
                        .frame(width: UIScreen.main.bounds.width * 0.09, height: 10)
                    
                }
            }
        }
    }
    
    
    func totalAmount(keys: String, values: String) -> Int {
        
        let doubleKey = Int(keys)!
        let doubleValues = Int(values)!
        
        //
        return doubleKey * doubleValues
    }
}
