//
//  PrinterSize.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 24/11/1443 AH.
//

import Foundation

enum PrinterSize {
    case printer57mm
    case printer80mm
    
    func getPoints() -> Double {
        switch self{
        case .printer57mm:
            return 384
        case .printer80mm:
            return 576
        }
    }
    
    func getCharCount() -> Int {
        return Int(getPoints()) / 12
    }
}


class Configurations {
    static let shared = Configurations()
    var printerSize: PrinterSize = .printer80mm
    
}
