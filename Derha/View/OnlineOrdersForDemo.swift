////
////  onlineOrders.swift
////  Derha
////
////  Created by Shorouq Alyami on 02/06/2022.
////
//
//import SwiftUI
//import Firebase
//
//struct onlineOrdersF: View {
//
//    let backgroundColor : Color = Color(red: 246/255, green: 246/255, blue: 246/255)
//    let lightPurple : UIColor = UIColor(Color(red: 119/255, green: 123/255, blue: 255/255).opacity(0.3))
//    let ourOrange: Color = Color(red: 254/255, green: 154/255, blue: 138/255)
//    let purple: Color = Color(red: 119/255, green: 123/255, blue: 255/255)
//    @State private var selectedIndex = 0
//
//
//    init(){
//        UISegmentedControl.appearance().selectedSegmentTintColor = lightPurple
////        UISegmentedControl.appearance().backgroundColor = .white
//        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
//    }
//
//
//    var body: some View {
//        ZStack{
////            VStack{
//
////            }
//            backgroundColor
//                .ignoresSafeArea()
//           // SearchView()
//
//            VStack{
//
//            HStack(alignment: .bottom, spacing: 15){
//            RoundedRectangle(cornerRadius: 6.0)
//                .frame(width: 500, height: 650)
//                .foregroundColor(.white)
//                .overlay(){
//                    VStack(alignment: .leading, spacing: 20){
//                    Text("26 May 2022 Thursday | 17:30")
//                        .foregroundColor(.black)
//                        .font(.title2)
//                        .bold()
//
//                        Picker("Favorite Color", selection: $selectedIndex, content: {
//                                       Text("Pendeing").tag(0)
//                                       Text("Accepted").tag(1)
//                                       Text("Caceled").tag(2)
//                                       Text("Completed").tag(3)
//
//                        })
//                        .pickerStyle(SegmentedPickerStyle()) // <1>
//
//                        switch(selectedIndex){
//                        case 0:
//                            SegmentContent(segmentName: "Pending")
//                        case 1:
//                            SegmentContent(segmentName: "Accepted")
//                        case 2:
//                            SegmentContent(segmentName: "Canceled")
//                        case 3:
//                            SegmentContent(segmentName: "Completed")
//                        default: Text("nothing")
//                        }
//                    } .padding()
//                }
//
//            RoundedRectangle(cornerRadius: 6.0)
//                .frame(width: 483, height: 650)
//                .foregroundColor(.white)
//                .overlay(){
//                    VStack(alignment: .leading, spacing: 20){
//                    Text("Order #240")
//                        .foregroundColor(.black)
//                        .font(.title2)
//                        .bold()
//                        .padding(.leading, 12)
//
//
//                        HStack{
//                            Text("Items")
//                                .bold()
//                                .font(.system(size: 20))
//                                .padding(.trailing, 200)
//                                .padding(.leading, 40)
//                            Text("Qty")
//                                .bold()
//                                .font(.system(size: 20))
//                            Spacer()
//                            Text("Price")
//                                .bold()
//                                .font(.system(size: 20))
//
//
//                        }
//
//
//                       // OrderItems()
//                        Spacer()
//                        VStack(alignment: .leading, spacing: 10){
//                        Text("If item is out of Stock:")
//                            .bold()
//                            .font(.system(size: 18))
//                            HStack{
//                                Image(systemName: "circle.fill")
//                                    .foregroundColor(purple)
//                        Text("Don’t replace and remove from cart")
//                            .font(.system(size: 16))
//                            }
//                        } .padding(.leading, 25)
//                        HStack(alignment: .center){
//                        Button(action: {}) {
//
//                            RoundedRectangle(cornerRadius: 8)
//                                .strokeBorder(ourOrange, lineWidth: 1)
//                                .frame(width: 205, height: 35)
//                                .padding()
//                                .overlay(){
//                                Text("Reject")
//                                    .bold()
//                                    .font(.system(size: 18))
//                                    .foregroundColor(ourOrange)
//                                }
//
//                        }
//                            Spacer()
//
//                            Button(action: {}) {
//
//                                    RoundedRectangle(cornerRadius: 8)
//                                    .foregroundColor(  Color(red: 119/255, green: 123/255, blue: 255/255))
//
//                                        .frame(width: 205, height: 35)
//                                        .padding()
//                                        .overlay(){
//                                    Text("Accept")
//                                        .bold()
//                                        .font(.system(size: 18))
//                                        .foregroundColor(.white)
//                                }
//                            }
//
//                        }
//
//                    } .padding()
//                }
//
//            }
//            .padding()
//            .padding(.top, 50)
//                Spacer()
//                }
//        }
//    }
//}
////
////struct onlineOrders_Previews: PreviewProvider {
////    static var previews: some View {
////        onlineOrders()
////.previewInterfaceOrientation(.landscapeLeft)
////    }
////}
//
//struct SegmentContent: View{
//
//    let ourPurple : Color = Color(UIColor(red: 119/255, green: 123/255, blue: 255/255, alpha: 41))
//    @State private var selectedOrder: onlineOrderModel?
//    var segmentName: String
//
//    let onlineOrders = [
//       onlineOrderModel(orderNumber: "Order #240", numberOfItems: "Number of items 4", time: "17:05", total: "200 SAR"),
//       onlineOrderModel(orderNumber: "Order #241", numberOfItems: "Number of items 7", time: "19:05", total: "100 SAR"),
//       onlineOrderModel(orderNumber: "Order #242", numberOfItems: "Number of items 77", time: "18:05", total: "2000 SAR"),
//       onlineOrderModel(orderNumber: "Order #243", numberOfItems: "Number of items 10", time: "01:05", total: "20 SAR"),
//       onlineOrderModel(orderNumber: "Order #244", numberOfItems: "Number of items 9", time: "20:05", total: "210 SAR")
//    ]
//
//    var body: some View{
//        List{
//            ForEach(onlineOrders) { order in
//
//                HStack{
//                    VStack(alignment: .leading, spacing: 20){
//                        Text(order.orderNumber)
//                            .bold()
//                            .font(.system(size: 18))
//                            .foregroundColor(.black)
//
//                        Text(order.numberOfItems)
//                            .bold()
//                            .font(.system(size: 16))
//                            .foregroundColor(.black)
//                    }
//
//                    Spacer()
//
//                    VStack(alignment: .trailing, spacing: 20){
//                        Text(order.time)
//                            .font(.system(size: 16))
//                            .foregroundColor(.black)
//
//                        Text(order.total)
//                            .bold()
//                            .font(.system(size: 16))
//                            .foregroundColor(.black)
//                    }
//                }
//                .listRowBackground(selectedOrder == order ?
//                                   ourPurple.opacity(0.3)
//                .clipShape(RoundedRectangle(cornerRadius: 10)) :
//                                    Color(UIColor.systemGroupedBackground).opacity(0.3)
//                .clipShape(RoundedRectangle(cornerRadius: 0)))
//                .onTapGesture {
//                    selectedOrder = order
//                    print(order.id)
//                }
//            }
//        }
//
//        .listStyle(PlainListStyle())
//
//    }
//}
//struct onlineOrderModel: Identifiable{
//    var id: String?
//
//    var orderNumber: String
//    var numberOfItems: String
//    var time: String
//    var total: String
//
//}
