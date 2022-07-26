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
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        
        VStack{
                VStack {
                    ZStack {
                        Color(  red: 0.949, green: 0.949, blue: 0.971 )
                            .ignoresSafeArea()
                        ScrollView {
                            VStack {
                                Image("Untitled design-4 (1)")
                                    .resizable()
                                    .frame(width: 210, height: 210)
                               
                                TextField(" Username", text: $username)
                                   .padding()
                                   
                                   .frame(width: 460, height: 65.0)
                                   .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                   .opacity(0.9)
                                  .cornerRadius(11)
                                   
                                SecureInputView(" Password".localized, text: $password)
                                   .padding()
                                   .frame(width: 460, height: 65.0)
                                   .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
                                  .cornerRadius(11)
                                  .padding(13)
                                  .padding(.bottom, 30)
                                
                               
                                
                                
                                Button {
                                    isLoading = true
                                    authViewModel.loginAction(user: username, pass: password) 
                                    
                                    
                                } label: {
                                    Text("Sign In").foregroundColor(.white)
                                        .frame(width: 460, height: 65.0)
                                        .background(Color(red: 0.463, green: 0.483, blue: 1.034))
                                        .cornerRadius(12)
                                      
                                        
                                    
                                }

                                
                                HStack {
                                    Text("Don't have an account?").foregroundColor(.secondary)
                                    
                                    
                                    Button {

                                                                            
                                                                            let url = NSURL(string: "mailto:mailto:ineffableteam2@gmail.com")
                                                                                        UIApplication.shared.open(url! as URL)

                                                                            
                                                                        } label: {
                                                                            Text("Contact us to create one".localized)
                                                                                            .foregroundColor(.init(UIColor(red: 0.463, green: 0.483, blue: 1.034, alpha: 1)))
                                                                            
                                                                        }

                              
                                    
                                    
                                }.padding()
                   
                                if isLoading{
                                  
                                
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .init(UIColor(red: 0.463, green: 0.483, blue: 1.034, alpha: 1))))
                                    .scaleEffect(1)
                                
                              
                                              
                                 
                                }
                                    
                            }.padding()
                        }
                    }
                }
               
        }

    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }.padding(.trailing, 32)

            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }
    }
}
