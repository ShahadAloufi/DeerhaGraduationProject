//
//  CustomTextField.swift
//  AJ
//
//  Created by Areej Albaqami on 09/11/1443 AH.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var isCorrect: Bool
    @Binding var text :String
    var placeHolder: String
    var warningMesssage = ""
   let titel :Text
    var body: some View {
        VStack (alignment:.leading){
            HStack{
               
                titel
                Text("*")
                    .foregroundColor(.red)
                    .font(.caption)
                    .bold()
               
               
            }
            ZStack{
                if isCorrect {
            RoundedRectangle(cornerRadius: 11)
                .stroke( Color.red, lineWidth: 1)
                .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.06)
                }
                TextField(placeHolder.localized, text: $text)
               .padding()
               .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.06)
               .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
               .cornerRadius(11)
            }
        }
        
    }
}


struct CustomTextFields: View {
    @Binding var isCorrect: Bool
    @Binding var text :String
    var placeHolder: String
    var warningMesssage = ""
   let titel :Text
    var body: some View {
        VStack (alignment:.leading){
                titel
         
            ZStack{
                if isCorrect {
            RoundedRectangle(cornerRadius: 11)
                .stroke( Color.red, lineWidth: 1)
                .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.06)
                }
                TextField(placeHolder.localized, text: $text)
               .padding()
               .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.06)
               .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
               .cornerRadius(11)
            }
        }
        
    }
}


struct CustomTextFieldForBarcode: View {
    @Binding var isCorrect: Bool
    @Binding var textValue :String
    var placeHolder: String
    var warningMesssage = ""
   let titel :Text
    var body: some View {
        VStack (alignment:.leading){
                titel
         
            ZStack{
                if isCorrect {
            RoundedRectangle(cornerRadius: 11)
                .stroke( Color.red, lineWidth: 1)
                .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.06)
                }
                TextField(placeHolder.localized, text: $textValue)
               .padding()
               .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.06)
               .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
               .cornerRadius(11)
            }
        }
        
    }
}

struct CustomTextFieldForNumbers: View {
    @Binding var isCorrect: Bool
    @Binding var text :Double
    var placeHolder: String
    var formattedLucNumber : String {
        Formatter.lucNumberFormat.string(from: NSNumber(value: text))!
        }
   let titel :Text
    var formatter = NumberFormatter()
   
   
    var body: some View {
        VStack (alignment:.leading){
            HStack{
           titel
                Text("*")
                    .foregroundColor(.red)
                    .font(.caption)
                    .bold()
            }
            ZStack{
            if isCorrect {
        RoundedRectangle(cornerRadius: 11)
            .stroke( Color.red, lineWidth: 1)
            .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.06)
            }
            TextField(placeHolder, value: $text, formatter: Formatter.lucNumberFormat)
            
               .padding()
               .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.06)
               .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
              .cornerRadius(11)
            }
        }
    }
}
struct CustomTextFieldForNumber: View {
    @Binding var isCorrect: Bool
    @Binding var text :Int
    var placeHolder: String
    
    var formattedLucNumber : String {
        Formatter.lucNumberFormat.string(from: NSNumber(value: text))!
        }
   let titel :Text
    var body: some View {
        VStack (alignment:.leading){
            HStack{
           titel
                Text("*")
                    .foregroundColor(.red)
                    .font(.caption)
                    .bold()
            }
            ZStack{
            if isCorrect {
        RoundedRectangle(cornerRadius: 11)
            .stroke( Color.red, lineWidth: 1)
            .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.06)
            }
            TextField(placeHolder, value: $text,  formatter: Formatter.lucNumberFormat)
               .padding()
               .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.06)
               .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
              .cornerRadius(11)
            }
        }
    }
}


struct CustomTextFieldForDate: View {
    
    @Binding var date :Date
    @State private var showPicker: Bool = false
    @Binding var selectedDateText:String
    var placeHolder: String

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
    @Binding var isCorrect: Bool
  
    var body: some View {
        VStack (alignment:.leading){
            HStack{
                
                titel
                Text("*")
                    .foregroundColor(.red)
                    .font(.caption)
                    .bold()
            }
            HStack {
                ZStack{
                    if isCorrect {
                RoundedRectangle(cornerRadius: 11)
                    .stroke( Color.red, lineWidth: 1)
                    .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.06)
                    }
                TextField(placeHolder, text: $selectedDateText)
                    .onAppear() {
                        self.setDateString()
                    }.overlay(
                        HStack{
                            
                           
                            DatePicker("", selection: selectedDate, in: Date()...
                        ,displayedComponents: .date)
                        
                        }
                    )
                   .padding()
                   .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.06)
                   .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
               
                  .cornerRadius(11)
            }
            }
            
             
        }

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
                        ,displayedComponents: .date).preferredColorScheme(.light)
                        
                        }.preferredColorScheme(.light)
                    )
                   .padding(9)
                   .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.06)
                   .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
               
                  .cornerRadius(11)
              
            }.preferredColorScheme(.light)
            
             
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
              
                .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.height * 0.05)
               .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
              .cornerRadius(11)
        } 
    }
}




struct CustomTextFieldForDatesBatches: View {
    @ObservedObject var batchViewModel = BatchViewModel()

    @State private var showPicker: Bool = false
    @Binding var selectedDateText:String

    
    
   let titel :Text
    var body: some View {
        VStack (alignment:.leading){
           
           titel
            
            
            HStack {
                TextField("", text: $selectedDateText).padding()

                  
                    .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.height * 0.05)
                   .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
               
                  .cornerRadius(11)
              
            }
            
             
        }
    }
}
