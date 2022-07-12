//
//  TabView.swift
//  Derha
//
//  Created by Areej Albaqami on 23/11/1443 AH.
//

import SwiftUI
struct TabView: View {
    var body: some View {
   
        VStack {
        GeometryReader { geometry in
            ZStack (alignment: .leading){
                        Home()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
          }
                   
       }
           
    }
}


struct Home: View{
 
    @State var selectedTab = "Checkout"
  
    var body: some View{

                
                VStack{
                HStack(spacing: 0){
                    SideBar(selectedTab: $selectedTab)
                    switch(selectedTab){
                    case "Checkout":
                        OrderView()
                    case "Online Order":
                        onlineOrders()
                    case "Stock":
                        StockView()
                    case "Add Product":
                        AddNewProduct()
                        
                    default: OrderView()
                    }
                    
                    
                }
                    
               
            }
                
           
}
}






struct SideBar: View{
    
    @Binding var selectedTab: String
    
    var body: some View{
        
      
                
        ScrollView  {
            VStack {
                ZStack {
                     VStack(alignment: .center){
                                InsideTabBarItems(selectedTab: $selectedTab)
                                 
                            }.ignoresSafeArea(.keyboard)
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.11, maxHeight: .infinity,  alignment: .center)
                            
                        .background(Color.white)
                }
            }
        }

       
    }
}




struct InsideTabBarItems: View{

    @Binding var selectedTab: String
  
    var body: some View{
    
                VStack{
                Image("Untitled design-4 (1)")
                    .resizable()
                    
                    .frame(width: 130, height: 130)
                    .padding(.horizontal)
                Spacer()

                VStack(alignment: .center, spacing: 60){

                   
                    TabBarButton(image:("Checkout") , title: "Checkout", selectedTab: $selectedTab)
                    TabBarButton(image:("OnlineOrders"), title: "Online Order", selectedTab: $selectedTab)
                    TabBarButton(image: ("Stock"), title: "Stock", selectedTab: $selectedTab)
                    TabBarButton(image: ("Add"), title: "Add Product", selectedTab: $selectedTab)
                    

                }

                Spacer()

                VStack{
                    Image("worker")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 65, height: 65)
                        .padding(.horizontal)
                        .padding(.top, 45)
                        .padding(.bottom, 5)

                    HStack{
                    Text("Sami")
                        .font(.system(size: 15))
                        .foregroundColor(Color(red: 0.047, green: 0.0, blue: 0.0))
                        .bold()

                        Image(systemName: "chevron.down")
                            .resizable()
                            .frame(width: 8, height: 4)
                    }
                    
                } .padding()
                       
                    
                }
                
           
    }
}





struct TabBarButton: View{

    
    var image: String
    var title: String
    let layer = CAGradientLayer()

   
    @Binding var selectedTab: String

    var body: some View{

    
                Button(action: {
                    withAnimation(.easeInOut){selectedTab = title}
                    
                },
                       label: {
                    HStack(spacing: 0){
                        Spacer()
                    VStack(spacing: 6){

                        Image(image)
                            .font(.system(size: 25))
                            .foregroundColor(selectedTab == title ? Color("Color-3") : .init(UIColor(red: 0.367, green: 0.381, blue: 0.863, alpha: 1)))

                        Text(title.localized)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(selectedTab == title ? Color("Color-3") : .init(UIColor(red: 0.367, green: 0.381, blue: 0.863, alpha: 1)))
                          
                    }
                 
                        Spacer()

                        if selectedTab == title{

                            HStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 4, height: 80)
                                
                                .foregroundColor(Color("Color-3"))
                            
                             
                            }
                          
                        }
                }
                
                })
           

    }
}
