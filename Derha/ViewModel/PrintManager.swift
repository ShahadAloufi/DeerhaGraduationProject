//
//  PrintManager.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 24/11/1443 AH.
//

import Foundation
import Printer
import UIKit
import SwiftUI

class PrintManager {
    
    static let shared = PrintManager()
    
    let bluetoothPrinterManager = BluetoothPrinterManager()
    var printerSize: PrinterSize = .printer57mm
    @StateObject var invoiceViewModel = InvoiceViewModel()

    

    func printBlank(){
        var ticket = Ticket()
        ticket.add(block: .blank)
        if PrintManager.shared.bluetoothPrinterManager.canPrint {
            PrintManager.shared.bluetoothPrinterManager.print(ticket)
        }
    }
    
    func printTicket(_ storeName: String, cartItems: [OrderItem], code: String){
        
        var ticket = Ticket()
        ticket.add(block: .title(storeName))
        ticket.add(block: .blank)
        ticket.add(block: .astriks)
        ticket.add(block: .textKV(key: "Items", val: "Price"))
        ticket.add(block: .dashs)

        var sum = 0.0
        for item in cartItems {
            let itemPrice = item.priceForEachItem
            ticket.add(block: .text3Items(item1: item.itemNameEng, item2: String(item.quantity), item3: String(itemPrice)))
            sum += itemPrice
        }

        ticket.add(block: .equals)
        ticket.add(block: .textKV(key: "Total", val: "\(sum) S"))
        ticket.add(block: .dashs)
        
        ticket.add(block: .blank)
//        let qrInfo = "\(storeName) 1234567 \(Date().description) 123.12 17.4"
//        let base64Info = qrInfo.data(using: .utf8)?.base64EncodedString() ?? "N/A"
        guard let qr = QRManager.generateQRCode(from: code) else { return }
        guard let centeredQR = qr.alignmentImageIn(width: PrintManager.shared.printerSize.getPoints(), alignment: .center) else { return }
        ticket.add(block: .image(centeredQR))
        
        ticket.add(block: .blank)
        ticket.add(block: .text("Thank You...", alignment: .center))
        ticket.add(block: .blank)

        ticket.feedLinesOnHead = 1
        ticket.feedLinesOnTail = 3
        
        if PrintManager.shared.bluetoothPrinterManager.canPrint {
            PrintManager.shared.bluetoothPrinterManager.print(ticket)
        }
    }
    
    
    func QRcode(storeName: String) -> UIImage {
        let newUIImage = UIImage(systemName: "")
        let qrInfo = "\(storeName) 1234567 \(Date().description) 123.12 17.4"
        let base64Info = qrInfo.data(using: .utf8)?.base64EncodedString() ?? "N/A"
        guard let qr = QRManager.generateQRCode(from: base64Info)
        else {
            return newUIImage!
        }
        guard let centeredQR = qr.alignmentImageIn(width: PrintManager.shared.printerSize.getPoints(), alignment: .center)
        else {
            return newUIImage!
        }
        
        return centeredQR
    }
    
}

struct PrinterVC: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> BluetoothPrinterSelectTableViewController {
        let vc = BluetoothPrinterSelectTableViewController()
        vc.sectionTitle = "Choose Bluetooth Printer"
        vc.printerManager = PrintManager.shared.bluetoothPrinterManager
        return vc
    }
    
    func updateUIViewController(_ uiViewController: BluetoothPrinterSelectTableViewController, context: Context) {
        
    }
}
