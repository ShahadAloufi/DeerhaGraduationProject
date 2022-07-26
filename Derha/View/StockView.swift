//
//  SwiftUIView2.swift
//  finalTables
//
//  Created by shahadmufleh on 09/06/2022.
//

import SwiftUI

struct StockView: View {
    @ObservedObject var vm = ProdctViewModel()
    @State var SearchText: String = ""
 
    var body: some View {
        
        ZStack {
            Color(red: 0.949, green: 0.949, blue: 0.971 )
            .ignoresSafeArea()
            
            VStack {
                VStack {
                    HStack {
                        SearchView(SearchText: $SearchText)
                           
                          
                    }.padding(.bottom, 7.0)
                    
                }
               
               
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                    
                    VStack{
                        
                        
                        ListView(SearchText: $SearchText)
                        
                     
                    }
                    
                    
                    
                    
                    
                }

                
                
                
                
                
            }.padding([.leading, .trailing], 16)
                .preferredColorScheme(.light)
            
            
                .ignoresSafeArea(.keyboard, edges: .bottom)
        
        }
        
        
        
    }
    
    
    
}

struct StockView_Previews: PreviewProvider {
    @State var SearchText: String = ""
    static var previews: some View {
        StockView()

            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

