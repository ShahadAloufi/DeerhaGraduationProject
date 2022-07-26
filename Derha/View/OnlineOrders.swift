//
//  Derha
//
//  Created by Shorouq Alyami on 02/06/2022.
//
//
import SwiftUI

struct onlineOrders: View {
   
   var body: some View {
       ZStack{
           Color(  red: 0.949, green: 0.949, blue: 0.971 )
           .ignoresSafeArea()
           VStack(alignment: .center){
         
               Image("order-online-icon-12")
                   .resizable()
                   .scaledToFit()
                   .foregroundColor(.secondary)
                   .padding()
                   .frame(width: 130, height: 110)
               VStack{
                   Text("You still have not received any orders yet".localized)
                       .font(.title2)
                       .foregroundColor(.secondary)
               }
           }.preferredColorScheme(.light)
       }
   }
}

struct onlineOrders_Previews: PreviewProvider {
   static var previews: some View {
       onlineOrders()
.previewInterfaceOrientation(.landscapeLeft)
   }
}
struct SearchViewForOrders: View {
    @Binding var SearchText: String
    @State private var isEditing = false
    var body: some View {
        VStack {
            HStack {
                TextField(" Search order number here".localized, text: $SearchText)
                    .padding(15)
                    .padding(.horizontal, 25)
                    .frame(width: 620, height: 40)
                
                    .background(Color(.white))
                    .cornerRadius(8)
                    .overlay(
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 15)
                            
                            
                            if isEditing{
                                Button(action: {
                                    self.SearchText = ""
                                }, label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 12)
                                })
                            }
                        }
                    ).onTapGesture {
                        self.isEditing = true
                    }
                if isEditing{
                    Button(action: {
                        self.isEditing = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        
                    }){
                        Text("Cancel")
                            .padding()
                        
                    }
                    .transition(.move(edge: .trailing))
                }
            }
        }.padding(.top, 12.0)
    }
    
    
}
struct OnlineOrderView: View {
   
    @State var searchTextFoOrder = ""
 
    var body: some View {
        
        ZStack {
            Color(red: 0.949, green: 0.949, blue: 0.971 )
            .ignoresSafeArea()
            
            VStack {
                VStack {
                    HStack {
                        SearchViewForOrders(SearchText: $searchTextFoOrder)
                           
                          
                    }.padding(.bottom, 7.0)
                    
                }
               
               
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                    
                    VStack{
                        
                        onlineOrders()
                       
                        
                        
                     
                    }
                    
                    
                    
                    
                    
                }

                
                
                
                
                
            }.padding([.leading, .trailing], 16)
              
            
            
                .ignoresSafeArea(.keyboard, edges: .bottom)
        
        }
        
        
        
    }
    
    
    
}
