//
//  NumbersFormatter.swift
//  Derha
//
//  Created by shahadmufleh on 12/07/2022.
//

import Foundation
import SwiftUI

extension Formatter {
    static let lucNumberFormat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minusSign = ""
        formatter.zeroSymbol = ""
        return formatter
    }()
    
   

}






extension Formatter {
    
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        
        
        formatter.amSymbol = ""
        
        return formatter


    }()
    
}
