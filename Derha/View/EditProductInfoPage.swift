//
//  ProductsView.swift
//  finalTables
//
//  Created by shahadmufleh on 17/06/2022.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct EditProductInfoPage: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = ProdctViewModel()
    @StateObject var batchViewModel = BatchViewModel()
    @State var addCount = 0
    let batchText: LocalizedStringKey = "Batch"
    let forText: LocalizedStringKey = "For"
   
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    Color(red: 0.949, green: 0.949, blue: 0.971 )
                        .ignoresSafeArea()
                    
                    
                    ZStack {
                        
                        
                        VStack {
                            
                            
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 9)
                                    .fill(Color.white)
                                    .frame(width: 650, height: 580)
                                VStack {
                                    
                                    
                                    
                                    HStack {
                                        
                                        VStack(alignment: .leading) {
                                            Text("Product Name In Arabic")
                                            
                                            TextField("Product Name In Arabic", text: $viewModel.product.arabicProductName).padding()
                                            
                                                .frame(width: 289, height: 42.0)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                            
                                            
                                        }
                                        .padding(.horizontal)
                                        VStack(alignment: .leading) {
                                            Text("Product Name In English")
                                            
                                            TextField("Product Name In English", text: $viewModel.product.englishProductName)
                                                .padding()
                                                .frame(width: 289, height: 42.0)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                        }
                                        
                                    } .padding(.horizontal, 17.0)
                                    
                                        .padding()
                                    HStack {
                                        
                                        VStack(alignment: .leading) {
                                            
                                            Text("Barcode Number")
                                            
                                            TextField("Barcode Number", text: $viewModel.product.barcodeNumber)
                                                .padding()
                                                .frame(width: 289, height: 42.0)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                            
                                        }
                                        .padding(.horizontal)
                                        VStack(alignment: .leading) {
                                            Text("Quantity")
                                            
                                            
                                            TextField("Quantity", value: $viewModel.product.qy,  formatter: NumberFormatter())
                                                .padding()
                                                .frame(width: 289, height: 42.0)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                        }
                                        
                                        
                                    }.padding(.horizontal, 17.0)
                                        .padding()
                                    HStack {
                                        
                                        
                                        VStack(alignment: .leading) {
                                            Text("Unit")
                                            
                                            
                                            TextField("Unit", text: $viewModel.product.unit)
                                                .padding()
                                                .frame(width: 289, height: 42.0)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                            
                                            
                                        }
                                        .padding(.horizontal)
                                        VStack(alignment: .leading) {
                                            
                                            Text("Alert me when remaining quantity is")
                                            
                                            
                                            
                                            TextField("Alert me when remaining quantity is", value: $viewModel.product.remainingQuantityAlert,  formatter: NumberFormatter())
                                                .padding()
                                                .frame(width: 289, height: 42.0)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                        }
                                        
                                        
                                    } .padding(.horizontal, 17.0)
                                    
                                    
                                        .padding()
                                    
                                    HStack {
                                        
                                        
                                        
                                        VStack(alignment: .leading) {
                                            Text("Expiration Date")
                                            
                                            
                                            
                                            
                                            TextField("Expiration Date", text: $viewModel.product.expdate)
                                                .padding()
                                                .frame(width: 289, height: 42.0)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                            
                                        }
                                        .padding(.horizontal)
                                        
                                        VStack(alignment: .leading) {
                                            Text("Price")
                                            
                                            
                                            TextField("Price", value: $viewModel.product.price,  formatter: NumberFormatter())
                                                .padding()
                                                .frame(width: 289, height: 42.0)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                        }
                                        
                                        
                                    } .padding(.horizontal, 17.0)
                                        .padding()
                                    
                                    
                                    VStack {
                                        
                                        
                                        
                                        Button(action: {
                                            self.emptyBatcheArray()
                                            addCount += 1
                                        }) {
                                            HStack {
                                                
                                                Text("Add Batch".localized)
                                                    .font(.title3)
                                                    .bold()
                                                Image("AddButton")
                                            }
                                        }
                                        .padding()
                                        .foregroundColor(Color(red: 0.463, green: 0.483, blue: 1.034))
                                        
                                        .frame(width: 150.72, height: 40)
                                        .background(RoundedRectangle(cornerRadius: 6).stroke(Color(red: 0.463, green: 0.483, blue: 1.034), lineWidth: 2))
                                        
                                        VStack {
                                            Text("You can add batches to this product".localized)
                                                .foregroundColor(Color.gray)
                                            
                                        }.frame(width: 280, height: 27)
                                         .padding(.leading, 90)
                                         .padding(8)
                                        
                                    }.padding(.trailing, 430)
                                }
                            }
                   
                            VStack {
                                ForEach(Array(zip(1..., $batchViewModel.batches)), id: \.1.id) { index, batch in
                               
                                    Section(header: Text("Batch \(index) For \(viewModel.product.englishProductName)".localized)
                                        .padding(.trailing, 500).foregroundColor(.secondary).font(.title3)){


                                  BatchView(batche: batch)


                          }

                                
                                }
                }
                            
                        }.padding()
                    }
                }
            }
            .navigationBarTitle(Text("Product Info".localized), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                print("Dismissing sheet view...")
                viewModel.handleDoneTapped()
                
                
                
                let index = batchViewModel.batches.count - addCount
                batchViewModel.updateNewArray(index: index)
                
                
                for batche in batchViewModel.newBatchesArray{
                  
                    batchViewModel.newBatch(product: viewModel.product, batche: batche)
                    batchViewModel.updateBatche(productToUpdate: viewModel.product, batche: batche)
                }
                
                presentationMode.wrappedValue.dismiss()
                
                
                
            }
                                                 
                                                ) {
                Text("Done".localized).bold().foregroundColor(Color(red: 0.463, green: 0.483, blue: 1.034))
                
            }) .background(
                Color(red: 0.949, green: 0.949, blue: 0.971 )
                    .ignoresSafeArea()
            )
            .navigationBarItems(leading: Button(action: {
                
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel".localized).bold().foregroundColor(Color(red: 0.463, green: 0.483, blue: 1.034))
                
            }) .background(
                Color(red: 0.949, green: 0.949, blue: 0.971 )
                    .ignoresSafeArea()
            )
        }
        .onAppear(perform: {
            batchViewModel.fetchBatcheByID(productCode: viewModel.product.barcodeNumber)
        })

    }
    
    
    func emptyBatcheArray() {
        batchViewModel.batches.append(Batche(id: UUID().uuidString ,batchName: "Batch", expirationDate: batchViewModel.batche.expirationDate, quantity: 0.0))
        batchViewModel.updateFilterByAscendingOrderToDate()
    }
    


    struct BatchView: View {
        let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 2), count: 2)
        @Binding var batche: Batche
//        @StateObject var batchViewModel = BatchViewModel()
        @State var expdate2  = Date()
          private var selectedDate: Binding<Date> {
            Binding<Date>(get: { self.expdate2}, set : {
                self.expdate2 = $0
                self.setDateString()
            })
          }

         private func setDateString() {
             let dateFormatter = DateFormatter()
             dateFormatter.locale = Locale(identifier: "en_US_POSIX")
             dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
             dateFormatter.dateFormat = "yyyy-MM-dd"
             self.batche.expirationDate = dateFormatter.string(from: self.expdate2)
           }

        var body: some View {
            
            HStack {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 650, height: 182.0)
                
                  ContainerRelativeShape()

                      .foregroundColor(Color(red: 0.463, green: 0.483, blue: 1.034))
                      .frame(width: 6, height: 180.0)
                      .cornerRadius(12)
                      .padding(.trailing, 642)
                  
                VStack {



                    HStack {

                      
                        CustomTextFieldForDatesBatches(selectedDateText: $batche.expirationDate, titel: Text("Expiration Date"))
                        
                        
                            .overlay(
                                HStack{


                                    DatePicker("", selection: selectedDate, in: Date()...
                                ,displayedComponents: .date)

                                }.padding(.top, 35)
                            )
                            
                            .onChange(of: batche.expirationDate, perform: { newValue in
                                    batche.expirationDate = newValue
                             
                            }
                            )
                            
                        
                            .padding()
                        
                        
                        
                            CustomTextFieldForNumbersBatches(text: $batche.quantity, titel: Text("َQuantity"))
                                
                            
                            
                            
                            .onChange(of: batche.quantity, perform: { newValue in
                                    batche.quantity = newValue
                               }
                            )
                        
                }


            }
          
        }
    }
        }
    
    
    
    
}


}
struct EditProductInfoPage_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(barcodeNumber: "", arabicProductName: "", englishProductName: "", qy: 0.0, remainingQuantityAlert: 0, price: 0.3, unit: "", expdate: "", ProductCategory: "", productDiscription: "", batches: [""])
        
        let productViewModel = ProdctViewModel(product: product)
        
        return EditProductInfoPage(viewModel: productViewModel)
    }
}
