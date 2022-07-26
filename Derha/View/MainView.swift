//
//  MainView.swift
//  Derha
//
//  Created by shahadmufleh on 13/07/2022.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            
            if authViewModel.signedIn{
                
                TabView()
            }else{
                LogInView()
            }
        }
        .onAppear {
            authViewModel.signedIn = authViewModel.isSignedIn
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
