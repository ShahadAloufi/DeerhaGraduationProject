//
//  ButtonView.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 16/12/1443 AH.
//


import SwiftUI

struct ButtonView: View {
    var body: some View {
        VStack{
            showPopUp()
            
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        showPopUp()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}



extension View{
    
    
    func popUpView<Content: View>(horizontalPadding: CGFloat = 40, verticallPadding: CGFloat = 40, show: Binding<Bool>, @ViewBuilder content: @escaping()-> Content)-> some View{
        
        return self
            .overlay{
            
                if show.wrappedValue{
                    
                    GeometryReader{proxy in
                        let size = proxy.size
                        Color.primary
                            .opacity(0.16)
                            .ignoresSafeArea()
                        NavigationView{
                            content()
                        }.navigationViewStyle(StackNavigationViewStyle())
                            
                            .frame(width: size.width / 2.4  - horizontalPadding, height: size.height / 1.8 - verticallPadding , alignment: .center)
                        
                            .cornerRadius(14)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            
            }
        
    }
}



struct showPopUp: View {
    @State var showPopUp = false
  
    @State var total: String = ""
    @State var receivedAmount: String = ""
    @State var leftAmount: String = ""
    @State var showingAlert: Bool = false
    @State private var didTapSecond:Bool = false
    var body: some View {
        
        
        NavigationView {
            Button("Cash") {
                withAnimation{
                    showPopUp.toggle()
                }
            }  .frame(width: 250, height: 70)
                .foregroundColor(Color("Checkout"))
                .background(Color("ButtonColor"))
                .overlay(
                
                    Image(didTapSecond ? "Cash" : "Cash2")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.trailing, 150)
                )
                .foregroundColor(.white)
                .cornerRadius(12)
        
          
        
        }.navigationViewStyle(StackNavigationViewStyle())
            .popUpView(horizontalPadding: 40, verticallPadding: 50, show: $showPopUp) {
        
        
        VStack{
            
            TextField("Total", text: $total)
               .padding()
               
               .frame(width: 360, height: 55.0)
               .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
              
              .cornerRadius(11)
              .padding(.bottom, 20)
            TextField("Recieved Amount", text: $receivedAmount)
               .padding()
               
               .frame(width: 360, height: 55.0)
               .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
              
              .cornerRadius(11)
              .padding(.bottom, 20)
            TextField("Left", text: $leftAmount)
               .padding()
               
               .frame(width: 360, height: 55.0)
               .background(Color(red: 0.968, green: 0.973, blue: 0.981 ))
              
              .cornerRadius(11)
              .padding(.bottom, 20)
             
            Button(action: {
                withAnimation{
                    showPopUp = false
                }
           
            }) {
                Text("Add")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .padding()
            }
            
            .frame(width: 180, height: 10, alignment: .center)
            .padding(.all, 20)
            .background(Color(red: 0.597, green: 0.482, blue: 1))
            .cornerRadius(10)
        }.navigationViewStyle(StackNavigationViewStyle())
               
                .navigationBarTitleDisplayMode(.inline)
               
}
}



}
