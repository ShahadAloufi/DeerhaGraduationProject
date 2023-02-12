//
//  AddView.swift
//  Derha
//
//  Created by Shorouq Alyami on 21/07/2022.
//


import SwiftUI

struct AddView: View {
    @State var isOptional: Bool = true
    @State private var showThankYou = false
    @State var isCorrect: Bool = false
    @State var isEnNameEmpty: Bool = false
    @State var isArNameEmpty: Bool = false
    @State var isCategoryEmpty: Bool = false
    @State var isBarcodeEmpty: Bool = false
    @State var isUnitEmpty: Bool = false
    @State var isDiscriptionEmpty: Bool = false
    @State var isDateEmpty: Bool = false
    @State var isQutEmpty: Bool = false
    @State var isRemainEmpty: Bool = false
    @State var isPriceEmpty: Bool = false
    @ObservedObject var viewModel = ProdctViewModel()
    @Binding var isEditing: Bool
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var expdate  = Date()
    @State private var Categories = ["Dairy".localized,"Vegetables".localized ,"Fruits".localized, "Beverages".localized, "Desserts".localized, "Canned Goods".localized, "Meat".localized, "Fish & Seafood".localized, "Deli".localized, "Condiments & Spices".localized, "Snacks".localized, " Bread & Bakery".localized, " Pasta, Rice & Cereal".localized,  "Frozen Foods".localized, "Personal Care".localized, "Health Care".localized, "Household & Cleaning Supplies".localized, "Baby Items".localized, "Pet Care".localized]
    
    @State private var unit = ["Kg".localized, "ml".localized, "l".localized, "Peice".localized]
    @ObservedObject var batchViewModel = BatchViewModel()
    @State var scanError: String = ""
    @State var showCam: Bool = false
    @EnvironmentObject var loginPopUpCheck: LoginPopUpCheck
    @EnvironmentObject var cashBoxOpen: CashBoxOpen

    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
            
            VStack {
                HStack{
                    CustomTextField(isCorrect: $isArNameEmpty, text: $viewModel.product.arabicProductName, placeHolder: "Ex: حليب",titel: Text("Product Name In Arabic")) .padding(.trailing, 70)
                    Spacer()
                    CustomTextField(isCorrect: $isEnNameEmpty, text: $viewModel.product.englishProductName, placeHolder: "Ex: Milk", titel: Text("Product Name In English")) .padding(.leading, 70)
                } .padding() .padding(.horizontal, 65)
                
                HStack{
                    CustomTextField(isCorrect: $isCategoryEmpty, text:$viewModel.product.ProductCategory, placeHolder: "Ex: Drinks".localized, titel: Text("Product Category" ))
                        .keyboardType(.default)
                    
                        .overlay(
                            HStack {
                                Menu {
                                    Picker(selection: $viewModel.product.ProductCategory) {
                                        ForEach(Categories, id: \.self) {
                                            Text($0)
                                        }
                                    } label: {}
                                } label: {
                                    HStack{
                                        Image("picker1")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 14, height: 20)
                                    }.frame(width: 170, height: 90)
                                }
                            } .frame(width: UIScreen.main.bounds.width * 0.4, height: 50, alignment: .trailing)
                                .padding(.top, 37)
                                .padding(.trailing)
                        )
                        .padding(.trailing, 70)
                    Spacer()
                    CustomTextFields(isCorrect: $isCorrect, text: $viewModel.product.productDiscription, placeHolder: "Ex: Powder milk", titel: Text("Product Description"))
                        .padding(.leading, 70)
                } .padding() .padding(.horizontal, 65)
                
                HStack{
                    ZStack(alignment: .bottom){
                        CustomTextField(isCorrect: $isBarcodeEmpty, text: $viewModel.product.barcodeNumber, placeHolder: "Ex: 123456789023", titel: Text("Barcode Number")).onChange(of: viewModel.product.barcodeNumber) { newValue in
                            if showCam == true{
                                showCam.toggle()
                            }
                        }
                        HStack{
                            Spacer()
                            Button{
                                showCam.toggle()
                            }
                        label:{
                            Image("barcodeButton")
                                .resizable()
                                .frame(width: 47, height: 31)
                                .foregroundColor(Color("Color-3"))
                            
                        }
                        } .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.04) .padding(.bottom, 7)
                    } .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.06) .padding(.trailing, 70)
                    Spacer()
                    CustomTextFieldForNumbers(isCorrect: $isQutEmpty, text: $viewModel.product.qy, placeHolder: "Ex: 20".localized, titel: Text("Quantity"))
                        .padding(.leading, 70)
                        .keyboardType(.numberPad)
                } .padding() .padding(.horizontal, 65)
                
                HStack{
                    CustomTextField(isCorrect: $isUnitEmpty, text: $viewModel.product.unit, placeHolder: "Ex: 12Kg", titel: Text("Unit"))
                        .keyboardType(.numberPad)
                        .overlay(
                            HStack {
                                Menu {
                                    Picker(selection: $viewModel.product.unit) {
                                        ForEach(unit, id: \.self) {
                                            Text($0)
                                        }
                                    } label: {}
                                } label: {
                                    HStack{
                                        Image("picker1")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 14, height: 20)
                                    }.frame(width: 170, height: 90)
                                }
                            } .frame(width: UIScreen.main.bounds.width * 0.4, height: 50, alignment: .trailing)
                                .padding(.top, 37)
                                .padding(.trailing)
                        ) .padding(.trailing, 70)
                    Spacer()
                    CustomTextFieldForNumber(isCorrect: $isRemainEmpty, text: $viewModel.product.remainingQuantityAlert, placeHolder: "Ex: 10".localized, titel: Text("Alert me when remaining quantity is"))
                        .padding(.leading, 70)
                        .keyboardType(.numberPad)
                } .padding() .padding(.horizontal, 65)
                
                HStack{
                    CustomTextFieldForDate(date: $expdate, selectedDateText: $viewModel.product.expdate, placeHolder: "Ex: 20-02-2022", titel: Text("Expiration Date"), isCorrect: $isDateEmpty)
                        .padding(.trailing, 70)
                    Spacer()
                    CustomTextFieldForNumbers(isCorrect: $isPriceEmpty, text: $viewModel.product.price, placeHolder: "Ex: 40 SAR".localized, titel: Text("Price"))
                        .padding(.leading, 70)
                        .keyboardType(.numberPad)
                } .padding() .padding(.horizontal, 65)
                
                HStack{
                    Spacer()
                    Button {
                        ClearTextFields()
                    }
                label:{
                    ClearButton(title:"Clear".localized)
                }
                    Button{
                        
                        if authViewModel.signedIn {
                            
                            if cashBoxOpen.isCashBoxOpen {
                            
                            if !viewModel.product.barcodeNumber .isEmpty &&
                                !viewModel.product.arabicProductName .isEmpty &&
                                !viewModel.product.unit .isEmpty &&
                                !viewModel.product.ProductCategory .isEmpty  &&
                                !viewModel.product.englishProductName .isEmpty  &&
                                !viewModel.product.expdate .isEmpty &&
                                !viewModel.product.price .isZero &&
                                viewModel.product.remainingQuantityAlert != 0 &&
                                viewModel.product.qy != 0
                            {
                                // send dats
                                let userID = authViewModel.getCurrentUser()
                                print("user.id \(userID)")
                                viewModel.product.uid = userID
                                
                                batchViewModel.emptyBatcheArray(expirationDate: viewModel.product.expdate, quantity: viewModel.product.qy)
                                batchViewModel.newBatch(product: viewModel.product, batche: batchViewModel.batches[0])
                                viewModel.product.batches.append(batchViewModel.batches[0].id)
                                viewModel.handleDoneTapped()
                                print("dajyg dh anmr ")
                                // clear textfiels
                                ClearTextFields()
                                // show confirmation
                                showThankYou = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    self.showThankYou = false
                                }
                                //
                                isBarcodeEmpty  = false
                                isArNameEmpty   = false
                                isUnitEmpty     = false
                                isCategoryEmpty = false
                                isEnNameEmpty   = false
                                isDateEmpty     = false
                                isQutEmpty      = false
                                isRemainEmpty   = false
                                isPriceEmpty    = false
                            }
                            
                            else {
                                if viewModel.product.barcodeNumber .isEmpty{
                                    isBarcodeEmpty  = true} else { isBarcodeEmpty   = false}
                                if viewModel.product.arabicProductName .isEmpty{
                                    isArNameEmpty   = true} else {  isArNameEmpty   = false}
                                if viewModel.product.unit .isEmpty{
                                    isUnitEmpty     = true} else {isUnitEmpty       = false}
                                if viewModel.product.ProductCategory .isEmpty {
                                    isCategoryEmpty = true} else {isCategoryEmpty   = false}
                                if viewModel.product.englishProductName .isEmpty{
                                    isEnNameEmpty   = true} else {isEnNameEmpty     = false}
                                if viewModel.product.expdate .isEmpty {
                                    isDateEmpty     = true} else {   isDateEmpty    = false}
                                if viewModel.product.price .isZero {
                                    isPriceEmpty      = true} else {  isPriceEmpty  = false}
                                if viewModel.product.remainingQuantityAlert == 0{
                                    isRemainEmpty   = true} else { isRemainEmpty    = false}
                                if  viewModel.product.qy == 0{
                                    isQutEmpty    = true} else { isQutEmpty         = false}
                                
                                return
                            }
                            
                            //Here is else
                            
                            }
                            else {
                                
                                cashBoxOpen.showingCashBoxAlert.toggle()

                            }
                            
                        }
                        else {
                            loginPopUpCheck.showingLoginAlert.toggle()
                     
                        }
                    }
                    
                label:{
                    AddButton(title:"Add".localized)
                }
                .padding()
                } .padding(.top) .padding(.horizontal, 50)
            }.frame(width: UIScreen.main.bounds.width * 0.84, height: UIScreen.main.bounds.height * 0.83 ,alignment: .center)  .padding()
                .padding(.top, 18)
            
            
            
            // confirmaton view
            
            if showThankYou {
                VStack {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 70)
                        .foregroundColor(Color(red: 0.463, green: 0.483, blue: 1.034))
                    Text("Successfully Added".localized)
                        .font(.title2)
                        .foregroundColor(Color(red: 0.463, green: 0.483, blue: 1.034))
                    
                }
                .frame(width: 320, height: 300)
                .background( .ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20) )
            }
            
            
            Spacer()
            HStack(alignment: .center){
                // Show Cam
                if showCam {
                    scannerView()
                        .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.25 ,alignment: .center)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(20)
                        .padding(.bottom, 200)
                        .overlay(
                            VStack{
                                Button { showCam.toggle() }
                            label: {
                                Text("Close")  .foregroundColor(Color(red: 0.463, green: 0.483, blue: 1.034))
                                
                                    .frame(width: UIScreen.main.bounds.width * 0.07, height: UIScreen.main.bounds.height * 0.04 ,alignment: .center)
                                    .background(Color(.white))
                                    .cornerRadius(9)
                            }
                         }
                        )
                }
            }
            
        }
        
        .padding([.leading, .trailing], 16)
        
    }
    
    // MARK: Clear TextFiles Func
    func ClearTextFields() {
        viewModel.product.price = 0.0
        viewModel.product.remainingQuantityAlert = 0
        viewModel.product.englishProductName = ""
        viewModel.product.arabicProductName = ""
        viewModel.product.unit = ""
        viewModel.product.expdate = ""
        viewModel.product.qy = 0.0
        viewModel.product.ProductCategory = ""
        viewModel.product.productDiscription = ""
        viewModel.product.barcodeNumber = ""
    }
    
    func scannerView() -> some View {
        return QRScannerView(scannedCode: $viewModel.product.barcodeNumber.didSet(execute: { scannedCode in
            self.scannedCode(scannedCode)
        }), scanError: $scanError.didSet(execute: { errorMessage in
            self.scanErrorMessage(errorMessage)
        }))
    }
    
    
    func scanErrorMessage(_ message: String){
        print("error: \(message)")
    }
    
    func scannedCode(_ code: String){
        print("code: \(code)")
    }
}


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(isEditing: .constant(false))
    }
}
