//
//  ListView.swift
//  finalTables
//
//  Created by shahadmufleh on 13/06/2022.
//

import SwiftUI
import FirebaseFirestore
import Firebase
struct ListView: View {
    @ObservedObject var example = ProductsViewModel()
    @State private var selectedMovie: String? = nil
    @Binding var SearchText: String
    @State var showingPopover = false
    @Environment(\.editMode) var editMode
  
    var body: some View {
        VStack{
            VStack {
                HStack {
                    
                        HStack {

                            Text("Product Code")
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(width: UIScreen.main.bounds.width * 0.13, height: 40)
                            Text("Product Name")
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(width: UIScreen.main.bounds.width * 0.13, height: 40)
                            Text("Price")
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(width: UIScreen.main.bounds.width * 0.13, height: 40)
                            HStack {

                                Text("Quantity")
                                    .font(.headline)
                                    .fontWeight(.bold)


                                        Button {
                                            updateFilterByDescendingOrder()
                                        

                                        } label: {
                                            Image("column-sort-unspecified")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .foregroundColor(Color.black)

                                    }



                            } .frame(width: UIScreen.main.bounds.width * 0.13, height: 30)
                            HStack {
                                Text("Category")
                                    .font(.headline)
                                    .fontWeight(.bold)




                            } .frame(width: UIScreen.main.bounds.width * 0.13, height: 40)




                            HStack {
                                Text("Expiration Date")
                                    .font(.headline)
                                    .fontWeight(.bold)


                                Button {

                                    updateFilterByAscendingOrderToDate()
                                } label: {
                                    Image("column-sort-unspecified")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(Color.black)

                                }

                            } .frame(width: UIScreen.main.bounds.width * 0.13, height: 30)





                        }
                      
                    
                    
                    
                }.padding(.top)
            }
          
            
            
            List{
              
                ForEach(Array(zip(example.product.indices, example.product.filter({"\($0.barcodeNumber)".contains(SearchText) || SearchText.isEmpty}))), id: \.1) { index, i in
                
                
                    RowView(product: i)
                    
                    
                        .listRowBackground((index % 2 == 0) ? Color(red: 0.958, green: 0.958, blue: 0.958) : Color(.white) )
                
                }   .onDelete(perform:{ indexSet in
                    
                    _ = indexSet.map {
                let id = example.product[$0].barcodeNumber
                       
                       
                        self.delete(id: id )
                       
                    }
                   
                    example.product.remove(atOffsets: indexSet)
                  
                })
                
                
            }.onAppear(perform: {
             
                example.subscribe()
                
              
            })
            
            
            .listStyle(SidebarListStyle())

              
        }
    }
    
    func delete(id: String) {
        DispatchQueue.main.async {
        let db = Firestore.firestore()
        
        db.collection("Product").whereField("barcodeNumber", isEqualTo: id).getDocuments { (snap , err )
            
            in
            if err != nil{
                print("Error")
                return
            }
            for document in snap!.documents{
         
                    
                document.reference.delete()
                
            }
            
           
            
            
        }
        
        
     }
        
    }
    
    func updateFilterByAscendingOrder() {
        example.product = example.product.sorted(by: { $0.qy > $1.qy})

     }

    func updateFilterByDescendingOrder() {
        example.product = example.product.sorted(by: { $0.qy < $1.qy })
     }
    func updateFilterByAscendingOrderToDate() {
        let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            example.product = example.product
              .map { return ($0, dateFormatter.date(from: $0.expdate) ?? Date() ) }
              .sorted { $1.1 > $0.1}
              .map(\.0)

        

      
     }
    

    
    
}


struct RowView: View {
    @Environment(\.editMode) var editMode
    @State var showingFull = false
    @Environment(\.presentationMode) var presentationMode
    let product: Product
  
    @ObservedObject var productViewModel = ProductsViewModel()
    
   
    var body: some View {
        HStack {
            HStack {
                Text(product.barcodeNumber)
                    .foregroundColor(.primary)
                    .frame(width: UIScreen.main.bounds.width * 0.13, height: 30)
                Text(product.englishProductName)
                    .foregroundColor(.primary)
                
                    .frame(width: UIScreen.main.bounds.width * 0.15, height: 30)
                
                HStack {
                    Text("\(product.price, specifier: "%.2f")")
                    Text("SAR".localized)
                        .foregroundColor(.primary)
                }
               
            
                    .frame(width: UIScreen.main.bounds.width * 0.11, height: 30)
                
            }
            HStack {
                HStack {
                    
                   
                    if Int((product.qy)) > product.remainingQuantityAlert  && (product.qy) < 159 {
                        Text("\(product.qy, specifier: "%.0f")")
                            .padding(3)
                            .foregroundColor(.primary)
                        Image("yellow")
                    }else if (product.qy) > 160 {
                        Text("\(product.qy, specifier: "%.0f")")
                            .padding(3)
                            .foregroundColor(.primary)
                        Image("green")
                        
                    }else if Int((product.qy)) == product.remainingQuantityAlert {
                        Text("\(product.qy, specifier: "%.0f")")
                            .padding(3)
                            .foregroundColor(.primary)
                        Image("red")
                    }
                    
                    
                    
                    
                }
                .frame(width: UIScreen.main.bounds.width * 0.13, height: 30)
               
                
                Text(product.ProductCategory.localized)
                    .foregroundColor(.primary)
                    .frame(width: UIScreen.main.bounds.width * 0.14, height: 30)
            }
            
            HStack {
                Text(product.expdate)
                    .foregroundColor(.primary)
                
                if editMode?.wrappedValue.isEditing == true {
                    
                    
                    Button {
                   
                        
                    } label: {
                        Image(systemName: "info.circle").foregroundColor(Color(red: 0.463, green: 0.483, blue: 1.034))
                    }.onTapGesture {
                       
                        self.showingFull = true
                    }.sheet(isPresented: $showingFull){
                       
                    
                        EditProductInfoPage(viewModel: ProdctViewModel(product: product))
                        
                    }
                    
                    
                }
            }.frame(width: UIScreen.main.bounds.width * 0.10, height: 30)
            
            
        }.onAppear {
            productViewModel.notificationQy(product)
           
        }
    }
    
    
    
    
}
