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
    @State var batchCount = 0
    let batchText: LocalizedStringKey = "Batch"
    let forText: LocalizedStringKey = "For"
    var saveButton: some View {
        Button(action: { viewModel.handleDoneTapped()
            
            viewModel.handleDoneTapped()
            
            
            
            let index = batchViewModel.batches.count - addCount
                        print("--------------------- Save Action ----------------------")
                        print("index \(index)")
                        print("batchViewModel.batches.count \(batchViewModel.batches.count)")
                        print("addCount \(addCount)")
                        
                        if addCount > 0 {
                            print(addCount)
                            print("addCount > 0 \(addCount > 0)")
                            batchViewModel.updateNewArray(index: index)
                            
                            
                            for batche in batchViewModel.newBatchesArray{
                                
                                batchViewModel.newBatch(product: viewModel.product, batche: batche)
                                batchViewModel.updateBatche(productToUpdate: viewModel.product, batche: batche)
                                
                            }
                        }
            
            presentationMode.wrappedValue.dismiss()
            
            
            
            
            
            
        }) {
            Text("Save").bold().accentColor(Color(red: 0.463, green: 0.483, blue: 1.034))
        }
        .disabled(!viewModel.modified)
      }
    var buttonColor: Color {
            return viewModel.modified ? .accentColor : .gray
        }
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    Color(red: 0.949, green: 0.949, blue: 0.971 )
                        .ignoresSafeArea()

                    
                    VStack {
                        
                        
                        VStack {
                            
                            
                            VStack{
                        
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 9)
                                    .fill(Color.white)
//
                                   // .frame(width: UIScreen.main.bounds.width * 0.54, height: UIScreen.main.bounds.height * 0.70, alignment: .center)
                                VStack(alignment: .center, spacing: 40) {
                                    
                                    
                                    
                                    HStack(alignment: .center, spacing: 20) {
                                        
                                        VStack(alignment: .leading, spacing: 20) {
                                            Text("Product Name In Arabic")
                                            
                                            TextField("Product Name In Arabic", text: $viewModel.product.arabicProductName).padding()
                                            
                                                .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.height * 0.05)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                            
                                            
                                        }.padding(.top, 18)
                                       
                                        VStack(alignment: .leading, spacing: 20) {
                                            Text("Product Name In English")
                                            
                                            TextField("Product Name In English", text: $viewModel.product.englishProductName)
                                                .padding()
                                                .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.height * 0.05)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                        }.padding(.top, 18)
                                        
                                    }
                                    HStack(alignment: .center, spacing: 20) {
                                        
                                        VStack(alignment: .leading, spacing: 20) {
                                            
                                            Text("Barcode Number")
                                            
                                            TextField("Barcode Number", text: $viewModel.product.barcodeNumber)
                                                .padding()
                                                .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.height * 0.05)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                            
                                        }
                                       
                                        VStack(alignment: .leading, spacing: 20) {
                                            Text("Quantity")
                                            
                                            
                                            TextField("Quantity", value: $viewModel.product.qy,  formatter: NumberFormatter())
                                                .padding()
                                                .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.height * 0.05)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                        }
                                        
                                        
                                    }
                                    HStack(alignment: .center, spacing: 20) {
                                        
                                        
                                        VStack(alignment: .leading, spacing: 20) {
                                            Text("Unit")
                                            
                                            
                                            TextField("Unit", text: $viewModel.product.unit)
                                                .padding()
                                                .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.height * 0.05)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                            
                                            
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 20) {
                                            
                                            Text("Alert me when remaining quantity is")
                                            
                                            
                                            
                                            TextField("Alert me when remaining quantity is", value: $viewModel.product.remainingQuantityAlert,  formatter: NumberFormatter())
                                                .padding()
                                                .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.height * 0.05)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                        }
                                        
                                        
                                    }
                                    
                                    HStack(alignment: .center, spacing: 20) {
                                        
                                        
                                        
                                        VStack(alignment: .leading, spacing: 20) {
                                            Text("Expiration Date")
                                            
                                            
                                            
                                            
                                            TextField("Expiration Date", text: $viewModel.product.expdate)
                                                .padding()
                                                .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.height * 0.05)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                            
                                        }
                                      
                                        
                                        VStack(alignment: .leading, spacing: 20){
                                            Text("Price")
                                            
                                            
                                            TextField("Price", value: $viewModel.product.price,  formatter: NumberFormatter())
                                                .padding()
                                                .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.height * 0.05)
                                                .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                                .cornerRadius(11)
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    VStack {
                                        
                                        
                                        
                                       
                                        
                                        VStack(alignment: .leading) {
                                            
                                            Button(action: {
                                                self.emptyBatcheArray()
                                                addCount += 1
                                                    viewModel.modified = true
                                            }) {
                                                HStack {
                                                    HStack{
                                                        Text("Add Batch".localized)
                                                            .foregroundColor(Color(red: 0.463, green: 0.483, blue: 1.034))
                                                                .bold()
                                                        Image("AddButton")

                                                    }
                                                    .frame(width: UIScreen.main.bounds.width * 0.11, height: UIScreen.main.bounds.height * 0.04)
                                                    .background(RoundedRectangle(cornerRadius: 6).stroke(Color(red: 0.463, green: 0.483, blue: 1.034), lineWidth: 2))
                                                       
//
                                                }
                                            }
                                           
//
                                            
                                            Text("You can add batches to this product".localized)
                                                .foregroundColor(Color.gray)
                                            
                                        }
                                        .frame(width: 430, height: 77)
                                        
                                         .padding(.leading, 90)
                                         .padding(8)
                                        
                                      
                                        
                                    }
                                    .padding(.trailing, 430)
                                    
                                    
                                    
                                    
                                    
                                }
                               
                            }
                            
                        }
                   
                            VStack {
                                ForEach(Array(zip(1..., $batchViewModel.batches)), id: \.1.id) { index, batch in
                               
                            Section(header: Text("Batch \(index) For \(viewModel.product.englishProductName)".localized)
                                .frame(width: UIScreen.main.bounds.width * 0.48, height: UIScreen.main.bounds.height * 0.04, alignment: .leading)
                                    .foregroundColor(.secondary).font(.title3)){


                                  BatchView(batche: batch)
                                            .onDelete (perform: {
                                                                                                
                                                                                                print("the index is \(index)") //2
                                                                                                
                                                                                                print("batchViewModel.batches.count \(batchViewModel.batches.count)")//2
                                                                                                print("batchCount \(batchCount)") //1
                                                                                                
                                                                                                if batchViewModel.batches.count > batchCount {
                                                                                                    print("batchViewModel.batches.count > batchCount is \(batchViewModel.batches.count > batchCount)") //true
                                                                                                    if index > batchCount { //2 > 1
                                                                                                        
                                                                                                        let dif = batchViewModel.batches.count - batchCount //2
                                                                                                        print("addCount is \(addCount)") //1
                                                                                                        print("dif is \(dif)") //1
                                                                                                        addCount = addCount - 1 //0
                                                                                                        print("The addCount is \(addCount)")
                                                                                                    }
                                                                                                }
                                                                                                batchViewModel.deleteBatch(product: viewModel.product, batche: batchViewModel.batches[index-1])
                                                                                                
                                                                                                
                                                                                                let totalQy = batchViewModel.totalQy()
                                                                                                batchViewModel.updateQy(productToUpdate: viewModel.product, newValue: totalQy)
                                                                                                batchViewModel.removeBatcheFromProduct(productToUpdate: viewModel.product, batche: batchViewModel.batches[index-1])
                                                                                                viewModel.modified = true
                                                                                                batchViewModel.modified = true
                                                                                                
                                                                                                print("batchViewModel.batches.count \(batchViewModel.batches.count)")
                                                                                                print("viewModel.product.batches.count \(viewModel.product.batches.count)")
                                                                                               
                                                                                                batchViewModel.batches.remove(at: index-1)
                                                                                                
                                                                                                print("------------------------------------------------------------------")
                                                                                                
                                                                                                
                                                                                                print("batchViewModel.batches.count \(batchViewModel.batches.count)")
                                                                                                print("viewModel.product.batches.count \(viewModel.product.batches.count)")
                                                                                                
                                                                                          
                                                                                                
                                                                                                print("The batchViewModel.batches is \(batchViewModel.batches.count)")
                                                                                               
                                                                                                
                                                                                            })

                          }

                                
                                }
                } .padding([.leading, .trailing], 25)
                            
                        }
                           
                    }.preferredColorScheme(.light)
                    
                    
                }
            }
            .navigationBarTitle(Text("Product Info".localized), displayMode: .inline)
            .navigationBarItems(

                    trailing: saveButton
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
            batchCount = viewModel.product.batches.count
        })

    }
    
    
    func emptyBatcheArray() {
        batchViewModel.batches.append(Batche(id: UUID().uuidString ,batchName: "Batch", expirationDate: batchViewModel.batche.expirationDate, quantity: 0.0))
        //batchViewModel.updateFilterByAscendingOrderToDate()
    }
    


    struct BatchView: View {
        @Binding var batche: Batche
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
                   // .padding([.leading, .trailing], 25)
                VStack(alignment: .leading){
//                HStack {
//                    ContainerRelativeShape()
//
//                          .foregroundColor(Color(red: 0.463, green: 0.483, blue: 1.034))
//                          .frame(width: UIScreen.main.bounds.width * 0.0050, height: UIScreen.main.bounds.height * 0.15, alignment: .leading)
//                          .cornerRadius(1)
//
//                } .padding(.trailing, 420)
//                        .padding(.leading, 13)
                }
               
                .frame(width: UIScreen.main.bounds.width * 0.48, height: UIScreen.main.bounds.height * 0.16, alignment: .leading)
                  
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
    } .padding([.leading, .trailing], 25)
                .padding(.bottom)
        }
    
    
    
    
}


}
struct EditProductInfoPage_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(barcodeNumber: "", arabicProductName: "", englishProductName: "", qy: 0.0, remainingQuantityAlert: 0, price: 0.3, unit: "", expdate: "", ProductCategory: "", productDiscription: "", batches: [""], uid: "")
        
        let productViewModel = ProdctViewModel(product: product)
        
        return EditProductInfoPage(viewModel: productViewModel)
    }
}
