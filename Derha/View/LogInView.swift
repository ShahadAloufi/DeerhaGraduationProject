//
//  LogInView.swift
//  Derha
//
//  Created by shahadmufleh on 12/07/2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LogInView: View {
    @State var username = ""
    @State var password = ""
    @State var isLoading = false
    @State var isUserExist: Bool = false
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        NavigationView {
            VStack{
                VStack {
                    ZStack {
                        Color(  red: 0.949, green: 0.949, blue: 0.971 )
                            .ignoresSafeArea()
                        ScrollView {
                            VStack {
                                Image("LOGO1")
                                    .resizable()
                                    .frame(width: 110, height: 110)
                             
                                
                                EmailCustomTextField(text: $username, placeHolder: "Enter your email", titel: Text("Email"))
                                    .padding()
                                
                                SecureInputView("Enter your Password".localized, text: $password)
                                    .padding()
                                
                                
                         VStack(alignment: .leading) {
                                if authViewModel.noUser {
                                    
                                      HStack {
                                        
                                    Image("x")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                        
                                    Text("Incorrect email or password")
                                            .foregroundColor(.red)
                                        
                                    }
                                    .onAppear(perform: {
                                        isLoading = false
                                    })
                                }
                            }
                                
                                Button {
                                    isLoading = true
                                    authViewModel.loginAction(user: username, pass: password)
                                    authViewModel.noUser = false
                                    
                                } label: {
                                    Text("Login")
                                        .foregroundColor(.white)
                                        .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.06)
                                        .background((username.isEmpty || password.isEmpty) ? Color.init(UIColor(red: 0.437, green: 0.452, blue: 0.946, alpha: 0.38)) : Color.init(UIColor(red: 0.437, green: 0.452, blue: 0.946, alpha: 1)))
                                        .cornerRadius(12)
                                    
                                }
                                .padding()
                                .disabled(username.isEmpty || password.isEmpty)
                                
                                
                                HStack {
                                    
                                    Button {
                                        
                                        print("testing")
                                        
                                    } label: {
                                        NavigationLink(destination: TabView()) {
                                            Text("Skip").foregroundColor(.secondary)
                                        }
                                    }
                                   
                                }.padding()
                                
                                if isLoading{
                                    
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .init(UIColor(red: 0.463, green: 0.483, blue: 1.034, alpha: 1))))
                                        .scaleEffect(1)
                                    
                                }
                            }.padding(100)
                        }
                    }
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}


struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}

