//
//  TableView.swift
//  Derha
//
//  Created by shahadmufleh on 14/07/2022.
//

import SwiftUI
import Firebase
struct TableNewProductView: View {
    @State var SearchText: String = ""
    @ObservedObject var viewModel = ProductsViewModel()
    @StateObject var authViewModel = AuthViewModel()
        @State var editMode: EditMode = .active
        @State var isEditing = true
        var body: some View {
            ZStack {
                ZStack{
                 RoundedRectangle(cornerRadius: 10)
                     .fill(Color.white)
                 VStack{
                     VStack {
                         HStack {
                             



                             Text("Product Code".localized)
                                         .font(.headline)
                                         .fontWeight(.bold)
                                         .frame(width: UIScreen.main.bounds.width * 0.10, height: 30)
                                         .padding(.horizontal)
                             Text("English Name".localized)
                                         .font(.headline)
                                         .fontWeight(.bold)
                                         .frame(width: UIScreen.main.bounds.width * 0.10, height: 30)
                             Text("Arabic Name".localized)
                                         .font(.headline)
                                         .fontWeight(.bold)
                                         .frame(width: UIScreen.main.bounds.width * 0.10, height: 30)

                             Text("Unit".localized)
                                             .font(.headline)
                                             .fontWeight(.bold)
                                             .frame(width: UIScreen.main.bounds.width * 0.07, height: 30)


                             Text("Price".localized)
                                             .font(.headline)
                                             .fontWeight(.bold)
                                             .frame(width: UIScreen.main.bounds.width * 0.07, height: 30)
          
                                        

                                     
                                     
                                     
                             Text("Quantity".localized)
                                         .font(.headline)
                                         .fontWeight(.bold)
                                         .frame(width: UIScreen.main.bounds.width * 0.07, height: 30)
                                     
                                     
                             Text("Expiration Date".localized)
                                         .font(.headline)
                                         .fontWeight(.bold)
                                         .frame(width: UIScreen.main.bounds.width * 0.10, height: 30)
                                     
                                     
                             Text("Catergory".localized)
                                         .font(.headline)
                                         .fontWeight(.bold)
                                         .frame(width: UIScreen.main.bounds.width * 0.12, height: 30)
                                     


                  
                               
                             
                             
                             
                         }.padding(.top)
                     }
                   
                     
                     
                     List{
                       
                         ForEach(Array(zip(viewModel.product.indices.reversed().prefix(3), viewModel.product.filter({"\($0.barcodeNumber)".contains(SearchText) || SearchText.isEmpty}))), id: \.1) { index, i in
                         
                         
                    
                             HStack {
                                 HStack {
                                     
                                     
                                     Text(i.barcodeNumber)
                                         .foregroundColor(.primary)
                                         .frame(width: UIScreen.main.bounds.width * 0.11, height: 30)
                                     
                                     Text(i.englishProductName)
             
                                         .foregroundColor(.primary)
                                         .frame(width: UIScreen.main.bounds.width * 0.10, height: 30)
                                     Text(i.arabicProductName)
                                         .foregroundColor(.primary)
                                         .frame(width: UIScreen.main.bounds.width * 0.10, height: 30)
                                     
                                     Text(i.unit)
                                         .foregroundColor(.primary)
                                         .frame(width: UIScreen.main.bounds.width * 0.07, height: 30)
                                     Text("\(i.price, specifier: "%.2f")")
                                         .foregroundColor(.primary)
                                         .frame(width: UIScreen.main.bounds.width * 0.07, height: 30)
                                     
                                     
                                     Text("\(Int((i.qy)))")
                                         .foregroundColor(.primary)
                                         .frame(width: UIScreen.main.bounds.width * 0.07, height: 30)

                                 
                                 
                       
                                     Text(i.expdate)
                                  
                                    
                                       
                                 
                                
                                 .foregroundColor(.primary)
                                 .frame(width: UIScreen.main.bounds.width * 0.10, height: 30)
                                
                                 
                                 
                                 
                                 Text(i.ProductCategory)
                                     .foregroundColor(.primary)
                                     .frame(width: UIScreen.main.bounds.width * 0.13, height: 30)
                             }}
                             
                             .listRowBackground((index % 2 == 0) ? Color(red: 0.958, green: 0.958, blue: 0.958) : Color(.white) )
                         
                             
                                 .listRowBackground((index % 2 == 0) ? Color(red: 0.958, green: 0.958, blue: 0.958) : Color(.white) )
                         
                         }   .onDelete(perform:{ indexSet in
                             
                             _ = indexSet.map {
                         let id = viewModel.product[$0].barcodeNumber
                                
                                
                                 self.delete(id: id )
                                
                             }
                            
                             viewModel.product.remove(atOffsets: indexSet)
                           
                         })
                         
                         
                     }.environment(\.editMode, $editMode)
                     
                     .onAppear(perform: {
                      

                         
                         let userID = authViewModel.getCurrentUser()
                                             
                                               print("userID \(userID)")
                                               viewModel.subscribe(uid: userID)
                     })
                     
                     
                     .listStyle(.plain)


                        
                     
                     
                 } .frame(width: UIScreen.main.bounds.width * 0.84, height: UIScreen.main.bounds.height * 0.33 ,alignment: .center)
                 
                 
                 
                }.padding([.leading, .trailing], 16)
                    .padding(.top, 5)
                
                
                if viewModel.product.count == 0{
                   
                    Color(  red: 0.949, green: 0.949, blue: 0.971 )
                    .ignoresSafeArea()
                }
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
   
                
            

    }


    struct TableNewProductView_Previews: PreviewProvider {
        @State static var SearchText: String = ""
        static var previews: some View {
            StockView()
                .previewInterfaceOrientation(.landscapeLeft)
                .preferredColorScheme(.light)
             
        }
    }
