//
//  EmptyListView.swift
//  Derha
//
//  Created by shahadmufleh on 14/07/2022.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        ZStack{
            Color(  red: 0.949, green: 0.949, blue: 0.971 )
            .ignoresSafeArea()
            VStack(alignment: .center){
                Image("Hiii")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.secondary)
                    
                    .frame(width: 170, height: 130)
                VStack{
                    Text("You still have not added any products yet".localized)
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
            }
            
               
        }
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
