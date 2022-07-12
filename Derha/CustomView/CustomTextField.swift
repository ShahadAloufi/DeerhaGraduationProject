//
//  CustomTextField.swift
//  AJ
//
//  Created by Areej Albaqami on 09/11/1443 AH.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text :String
   let titel :Text
    var body: some View {
        VStack (alignment:.leading){
           titel
           
            TextField("", text: $text)
               .padding()
               .frame(width: 360, height: 45.0)
               .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
              .cornerRadius(11)
        } .padding([.leading,.trailing],50)
    }
}
struct CustomTextFieldForNumbers: View {
    @Binding var text :Double
    var formattedLucNumber : String {
        Formatter.lucNumberFormat.string(from: NSNumber(value: text))!
        }
   let titel :Text
    var formatter = NumberFormatter()
   
    var body: some View {
        VStack (alignment:.leading){
           titel
           
            TextField("", value: $text, formatter: Formatter.lucNumberFormat)
            
               .padding()
               .frame(width: 360, height: 45.0)
               .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
              .cornerRadius(11)
        } .padding([.leading,.trailing],50)
    }
}
struct CustomTextFieldForNumber: View {
    @Binding var text :Int
    
    var formattedLucNumber : String {
        Formatter.lucNumberFormat.string(from: NSNumber(value: text))!
        }
   let titel :Text
    var body: some View {
        VStack (alignment:.leading){
           titel
           
            TextField("", value: $text,  formatter: Formatter.lucNumberFormat)
               .padding()
               .frame(width: 360, height: 45.0)
               .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
              .cornerRadius(11)
        } .padding([.leading,.trailing],50)
    }
}


struct CustomTextFieldForDate: View {
    
    @Binding var date :Date
    @State private var showPicker: Bool = false
    @Binding var selectedDateText:String

     private var selectedDate: Binding<Date> {
       Binding<Date>(get: { self.date}, set : {
           self.date = $0
           self.setDateString()
       })
     }

    private func setDateString() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.selectedDateText = dateFormatter.string(from: self.date)
      }
    
    
    
   let titel :Text
    var body: some View {
        VStack (alignment:.leading){
           
           titel
            
            
            HStack {
                TextField("", text: $selectedDateText)
                    .onAppear() {
                        self.setDateString()
                    }.overlay(
                        HStack{
                            
                           
                            DatePicker("", selection: selectedDate, in: Date()...
                        ,displayedComponents: .date)
                        
                        }
                    )
                   .padding(9)
                   .frame(width: 360, height: 45.0)
                   .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
               
                  .cornerRadius(11)
              
            }
            
             
        } .padding([.leading,.trailing],60)
    }
}

struct CustomTextFieldForDates: View {
    
    @Binding var date :Date
    @State private var showPicker: Bool = false
    @Binding var selectedDateText:String

     private var selectedDate: Binding<Date> {
       Binding<Date>(get: { self.date}, set : {
           self.date = $0
           self.setDateString()
       })
     }

    private func setDateString() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.amSymbol = ""
        self.selectedDateText = dateFormatter.string(from: self.date)
      }
    
    
    
   let titel :Text
    var body: some View {
        VStack (alignment:.leading){
           
           titel
            
            
            HStack {
                TextField("", text: $selectedDateText)
                    .onAppear() {
                        self.setDateString()
                    }.overlay(
                        HStack{
                            
                           
                            DatePicker("", selection: selectedDate, in: Date()...
                        ,displayedComponents: .date)
                        
                        }
                    )
                   .padding(9)
                   .frame(width: 289, height: 42.0)
                   .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
               
                  .cornerRadius(11)
              
            }
            
             
        } .padding([.leading,.trailing],60)
    }
}

struct CustomTextFieldForNumbersBatches: View {
    @Binding var text :Double
    var formattedLucNumber : String {
        Formatter.lucNumberFormat.string(from: NSNumber(value: text))!
        }
   let titel :Text
    var body: some View {
        VStack (alignment:.leading){
           titel
           
            TextField("", value: $text,  formatter: Formatter.lucNumberFormat ).padding()
              
               .frame(width: 289, height: 42.0)
               .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
              .cornerRadius(11)
        } 
    }
}




struct CustomTextFieldForDatesBatches: View {
    @ObservedObject var batchViewModel = BatchViewModel()
//    @Binding var date :Date
    @State private var showPicker: Bool = false
    @Binding var selectedDateText:String
//   
//     private var selectedDate: Binding<Date> {
//       Binding<Date>(get: { self.date}, set : {
//           self.date = $0
//           self.setDateString()
//       })
//     }
//
//    private func setDateString() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        self.selectedDateText = dateFormatter.string(from: self.date)
//      }

    
    
   let titel :Text
    var body: some View {
        VStack (alignment:.leading){
           
           titel
            
            
            HStack {
                TextField("", text: $selectedDateText).padding()
//                    .onAppear() {
//                        self.setDateString()
//                    }.overlay(
//                        HStack{
//
//
//                            DatePicker("", selection: selectedDate, in: Date()...
//                        ,displayedComponents: .date)
//
//                        }
//                    )
                  
                   .frame(width: 289, height: 42.0)
                   .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
               
                  .cornerRadius(11)
              
            }
            
             
        }
    }
}
