//
//  Printer+Extensions.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 24/11/1443 AH.
//

import UIKit
import Printer

extension Block {
    //return Dividing(provider: Character("-"), printDensity: 576, fontDensity: 12)//was 384 changed to 576

    static var equals: Block {
        let repeatStr = String(repeating: "=", count: PrintManager.shared.printerSize.getCharCount())// 576/12 (12 is the font points) 48 fo 80mm ,,, 32 for 57mm
        return .plainText(repeatStr)
    }
    
    static var astriks: Block {
        let repeatStr = String(repeating: "*", count: PrintManager.shared.printerSize.getCharCount())// 48 fo 80mm ,,, 32 for 57mm
        return .plainText(repeatStr)
    }
    
    static var dashs: Block {
        let repeatStr = String(repeating: "-", count: PrintManager.shared.printerSize.getCharCount())// 48 fo 80mm ,,, 32 for 57mm
        return .plainText(repeatStr)
    }
    
    // image
    static func qrImage(_ text: String, attributes: TicketImage.PredefinedAttribute...) -> Block {
        guard let qr = QRManager.generateQRCode(from: text) else { return .blank }
        let widthConverted = round(qr.size.width / 8) * 8
        guard let resizedImg = qr.resizeImage(widthConverted) else { return .blank }
        return Block(TicketImage(resizedImg, attributes: attributes))
    }
    
    static func text(_ text: String, alignment: NSTextAlignment) -> Block {
        
        if alignment == .left {
            print(text)
            return Block(Text(text))
        }
        
        var num = (Int(PrintManager.shared.printerSize.getPoints()) / 12) - text.count
                
        
        if alignment == .center {
            num = num / 2
        }
        
        var contents = stride(from: 0, to: num, by: 1).map { _ in " " }
        
        contents.append(text)
        
        let string = contents.joined()
        
        print(string)
        
        return Block(Text(string))
    }
    
    static func textKV(key: String, val: String, attributes: [Attribute]? = nil) -> Block {
        
        var num = Int(PrintManager.shared.printerSize.getPoints()) / 12

        let string = key + val
        
        for _ in string {
            num -= 1
        }
        
        var contents = stride(from: 0, to: num, by: 1).map { _ in " " }
        
        contents.insert(key, at: 0)
        contents.append(val)
        
        return Block(Text(contents.joined(), attributes: attributes))
    }
    
    static func textHeader(item1: String, item2: String, item3: String, attributes: [Attribute]? = nil) -> Block {
        
        var num = Int(PrintManager.shared.printerSize.getPoints()) / 12

        let string = item1 + item2 + item3
        
        num -= string.count
        num /= 2
        
        let blank = (stride(from: 0, to: num, by: 1).map { _ in " " }).joined()
        
        let totalText = item1 + blank + item2 + blank + item3
        
        return Block(Text(totalText, attributes: attributes))
    }
    
    //count item        price
    static func text3Items(item1: String, item2: String, item3: String, attributes: [Attribute]? = nil) -> Block {
        
        var num = Int(PrintManager.shared.printerSize.getPoints()) / 12

        let string = item1 + item2 + item3
        
        num -= string.count
        num -= 1//space after count
        
        let blank = (stride(from: 0, to: num, by: 1).map { _ in " " }).joined()
        
        let totalText = item2 + " " + item1 + blank + item3
        
        return Block(Text(totalText, attributes: attributes))
    }

}
