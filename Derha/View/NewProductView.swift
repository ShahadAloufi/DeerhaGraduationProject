//
//  AddNewProductView.swift
//  AJ
//
//  Created by Areej Albaqami on 09/11/1443 AH.
//

import SwiftUI

struct NewProductView: View {
  @ObservedObject var viewModel = ProdctViewModel()
  @State var expdate  = Date()
  @State private var Categories = ["Dairy".localized,"Vegetables".localized ,"Fruits".localized, "Beverages".localized, "Desserts".localized, "Canned Goods".localized, "Meat".localized, "Fish & Seafood".localized, "Deli".localized, "Condiments & Spices".localized, "Snacks".localized, " Bread & Bakery".localized, " Pasta, Rice & Cereal".localized,  "Frozen Foods".localized, "Personal Care".localized, "Health Care".localized, "Household & Cleaning Supplies".localized, "Baby Items".localized, "Pet Care".localized]
    @ObservedObject var batchViewModel = BatchViewModel()


    var body: some View {
  
        ScrollView {
            VStack {
                ZStack {
              

                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                    HStack{
                        VStack(spacing:34){


                            CustomTextField(text: $viewModel.product.arabicProductName, titel: Text("Product Name In Arabic"))

                            
                         
                            CustomTextField(text:$viewModel.product.ProductCategory, titel: Text("Product Category" ))
                               .keyboardType(.default)
                            
                               .overlay(
                                   HStack {
                                       Menu {
                                           Picker(selection: $viewModel.product.ProductCategory) {
                                               ForEach(Categories, id: \.self) {
                                                   Text($0)
                                               }
                                           } label: {}
                                       } label: {
                                           Image("picker1")
                                               
                                               
                                       }
                                     
                                   } .padding(.leading, 319.0)
                                   
                                    .padding(.top, 30.0)
                               
                               )
                                       
                     
                            CustomTextField(text: $viewModel.product.barcodeNumber, titel: Text("Barcode Number"))
                             .overlay(
                                Button{
                               
                                }
                            label:{
                                Image("barcodeButton")
                                    .resizable()
                                    .frame(width: 47, height: 31)
                                    .foregroundColor(Color("Color-3"))

                                    .padding(.leading, 280.0)
                                
                                    .padding(.top, 31.0)
                            })


                             .keyboardType(.numberPad)
                            CustomTextField(text: $viewModel.product.unit, titel: Text("Unit"))
                            CustomTextFieldForDate(date: $expdate, selectedDateText: $viewModel.product.expdate, titel: Text("Expiration Date"))
         

                     }
                        ZStack{
                        
                        VStack(spacing:34){
                            CustomTextField(text: $viewModel.product.englishProductName, titel: Text("Product Name In English"))
                            CustomTextField(text: $viewModel.product.productDiscription, titel: Text("Product Description"))
                         
                            CustomTextFieldForNumbers(text: $viewModel.product.qy, titel: Text("Quantity"))
                           
                                .keyboardType(.numberPad)
                          
                            CustomTextFieldForNumber(text: $viewModel.product.remainingQuantityAlert, titel: Text("Alert me when remaining quantity is"))
                            
                                .keyboardType(.numberPad)
                            CustomTextFieldForNumbers(text: $viewModel.product.price, titel: Text("Price"))

                                .keyboardType(.numberPad)

                        }
                            VStack{
                            HStack(spacing:24){
                             
                         Button {
                             viewModel.product.price = 0.0
                             viewModel.product.remainingQuantityAlert = 0
                             viewModel.product.englishProductName = ""
                             viewModel.product.arabicProductName = ""
                             viewModel.product.unit = ""
                             viewModel.product.expdate = ""
                             viewModel.product.qy = 0.0
                             viewModel.product.ProductCategory = ""
                             viewModel.product.productDiscription = ""
                             viewModel.product.price = 0.0
                         }
                     label:{
                         ClearButton(title:"Clear".localized)

                     }

                     Button{ 
                         
                         batchViewModel.emptyBatcheArray(expirationDate: viewModel.product.expdate, quantity: viewModel.product.qy)
                         batchViewModel.newBatch(product: viewModel.product, batche: batchViewModel.batches[0])
                         viewModel.product.batches.append(batchViewModel.batches[0].id)
                         viewModel.handleDoneTapped()
    
                     }
                 label:{
                     
                     AddButton(title:"Add".localized)
                     
                 }
                             }
                             .padding(.top, 600.0)
                             .padding(.leading, 44.0)
                            }.padding(.top, 30)
                        }
                    }
                    .padding([.leading, .bottom, .trailing])
                }
                .frame(width: 1020, height: 700)
            }
        }
    }
}
