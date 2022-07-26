//
//  CameraView.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 16/12/1443 AH.
//

import SwiftUI

struct CameraView: View {
    @State var scannedCode: String = ""
    @State var scanError: String = ""
    @Binding var showCam: Bool
    @Binding var SearchText: String
    @StateObject var orderViewModel = OrderViewModel()
    
    
    func scannedCode(_ code: String){
        print("code: \(code)")
    }
    
    func scanErrorMessage(_ message: String){
        print("error: \(message)")
    }
    
    func scannerView() -> some View {
       
        return QRScannerView(scannedCode: $SearchText.didSet(execute: { scannedCode in
            

          //  orderViewModel.fictchItem(ItemId: scannedCode)
            
            
        }), scanError: $scanError.didSet(execute: { errorMessage in
            
            self.scanErrorMessage(errorMessage)
            
        }))
        
        
    }
    
    var body: some View {
        VStack{
        if showCam {
            scannerView()
         
                .cornerRadius(12)
               
                .frame(width: UIScreen.main.bounds.width * 0.23, height: UIScreen.main.bounds.height * 0.33 ,alignment: .center)
        }
        }
        .frame(width: UIScreen.main.bounds.width * 0.23, height: UIScreen.main.bounds.height * 0.33 ,alignment: .center)

            .background(Color.white)
            .cornerRadius(10)
        
    }
    

}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(showCam: .constant(false), SearchText: .constant(""))
        
    }
}
