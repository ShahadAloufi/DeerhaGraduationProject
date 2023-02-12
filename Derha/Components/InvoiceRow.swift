//
//  InvoiceRow.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 04/06/1444 AH.
//

import SwiftUI

struct InvoiceRow: View {
    @ObservedObject var invoiceViewModel = InvoiceViewModel()
    let invoice: Invoice
    
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 20){
                Text("Invoice number #\(invoice.id)".localized)
                    .bold()
                    .font(.system(size: 18))
                    .foregroundColor(.black)
                
                HStack {
                    Text("Grand total".localized)
                  //  Text("Grand total \((invoice.total), specifier: "%.2f")")
                    
                    
                        .bold()
                        .font(.system(size: 15))
                    .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 20){
                Text(invoice.time.prefix(10))
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                
                Text(invoiceViewModel.isToday(dateString: invoiceViewModel.dateOrTime(date: invoice.time, type: "date")))
                    .font(.system(size: 15))
                    .foregroundColor(.black)
            }
        }
        .padding([.top, .bottom], 10)
    }
}



struct InvoiceData: View {
    
    let englishText: Text
    let arabicText :Text
    
    var body: some View {

        HStack{
        englishText
            .font(.system(size: 15))
            .foregroundColor(.black)
            .padding(1)
        
        arabicText
            .font(.system(size: 15))
            .foregroundColor(.black)
            .padding(1)
        }
    }
}


struct CashBoxRow: View {
  
    let cashBox: CashBox
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 20){
                Text("Opt. number #\(cashBox.optNum)")
                    .bold()
                    .font(.system(size: 18))
                    .foregroundColor(.black)
                
                Text("Total \((cashBox.totalSales), specifier: "%.2f")")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(.black)
            }
            
            Spacer()
            
//            VStack(alignment: .trailing, spacing: 20){
//                Text(cashBox.openTime.prefix(10))
//                    .font(.system(size: 15))
//                    .foregroundColor(.black)
//
//                Text(cashBox.closeTime.prefix(10))
//                    .font(.system(size: 15))
//                    .foregroundColor(.black)
//            }
        }
        .padding([.top, .bottom], 10)
    }
}
