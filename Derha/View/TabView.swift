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


struct Home: View {
    
    @State var selectedTab = "Cashbox"
    
    
    var body: some View{
        
        
        VStack{
            
            HStack(spacing: 0){
            
                SideBar(selectedTab: $selectedTab)
                switch(selectedTab){
                    
                case "Checkout":
                    CheckOutView()
                case "Stock":
                    StockView()
                case "Invoice":
                    InvoiceView()
                case "Add Product":
                    AddNewProduct()
                case "Cashbox":
                    CashBoxView()
              
                    
                default: CheckOutView()
                }
            }
        } .background(Color.white)
    }
}


struct SideBar: View{
    
    @Binding var selectedTab: String
   

    
    var body: some View{
       
        ScrollView(.vertical, showsIndicators: false)  {
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
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
    }
}



struct InsideTabBarItems: View {
    
    @Binding var selectedTab: String
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var showingAlert: Bool = false
    @EnvironmentObject var loginPopUpCheck: LoginPopUpCheck
    

    var body: some View{
        
        VStack{
            Image("LOGO1")
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.06, height: UIScreen.main.bounds.height * 0.08)
                .padding(30)
                //.padding(.horizontal)
            Spacer()
            
            VStack(alignment: .center, spacing: 60){
                
                
                TabBarButton(image:("Checkout") , title: "Checkout", selectedTab: $selectedTab)
                    .frame(height: UIScreen.main.bounds.height * 0.07)
                TabBarButton(image:("Invoice"), title: "Invoice", selectedTab: $selectedTab)
                    .frame(height: UIScreen.main.bounds.height * 0.07)
                TabBarButton(image: ("cashbox"), title: "Cashbox", selectedTab: $selectedTab)
                    .frame(height: UIScreen.main.bounds.height * 0.07)
              
               
               
                TabBarButton(image: ("Stock"), title: "Stock", selectedTab: $selectedTab)
                    .frame(height: UIScreen.main.bounds.height * 0.07)

              
                
                TabBarButton(image: ("Add"), title: "Add Product", selectedTab: $selectedTab)
                    .frame(height: UIScreen.main.bounds.height * 0.07)
                
                
            }
            
            Spacer()
            
            VStack{
                
                if authViewModel.signedIn {
                    
                    Image("blank-profile-picture-973460_640-modified")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.06, height: UIScreen.main.bounds.height * 0.07)
                        .padding(.trailing, 14)
                        .padding(.top, 45)
                    
                    
                    HStack{
                        HStack {
                            HStack {
                                Menu {
                                    Button("Sign Out", role: .destructive){
                                        authViewModel.logout()
                                    }
                                    
                                    
                                    
                                    Button("Delete Account", role: .destructive){
                                        
                                        authViewModel.deleteUser()
                                    }
                                } label: {
                                    
                                    HStack{
                                        Text("Sami")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 0.047, green: 0.0, blue: 0.0))
                                            .bold()
                                        Image(systemName: "chevron.down")
                                            .resizable()
                                            .font(Font.title.weight(.bold))
                                            .foregroundColor(.init(UIColor(red: 0.367, green: 0.381, blue: 0.863, alpha: 1)))
                                        
                                            .frame(width: 17, height: 9)
                                        
                                    }.frame(width: 130, height: 60)
                                }
                            }
                        }
                    }.onAppear(perform: {
                        loginPopUpCheck.showingLoginAlert = false
                    })
                }
                
                else {
                    VStack {
                        
                        Button {
                            loginPopUpCheck.showingLoginAlert.toggle()
                            
                        } label: {
                        
                            VStack{
                                Image("MdLogin")
                                    .font(.system(size: 25))
                                    .frame(width: 17, height: 20)
                                
                                Text("Login")
                                    .font(.subheadline)
                                    .foregroundColor(.init(UIColor(red: 0.367, green: 0.381, blue: 0.863, alpha: 1)))
                                    .bold()
                            }
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.25)

                }
            } .padding()
        }
        .onAppear {
            authViewModel.signedIn = authViewModel.isSignedIn
        }
    }
}



struct TabBarButton: View {
    
    
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
                            .frame(width: 4, height: UIScreen.main.bounds.height * 0.10)
                            .foregroundColor(Color("Color-3"))
                    }
                }
            }
        })
    }
}
