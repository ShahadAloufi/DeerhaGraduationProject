//
//  QRManager.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 24/11/1443 AH.
//

import UIKit
import AVFoundation

class QRManager: NSObject {
    
    class func generateQRCode(from string: String,
                              foregroundColor: UIColor = .black,
                              backgroundColor: UIColor = .clear) -> UIImage? {
        
        
        let data = string.data(using: .utf8)
        
        // Generate the code image with CIFilter
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        filter.setValue(data, forKey: "inputMessage")
        
        let transform = CGAffineTransform(scaleX: 6, y: 6)//15 or check scal
        guard let output = filter.outputImage?.transformed(by: transform) else { return nil }
        
        // Change the color using CIFilter
        let colorParameters = [
            "inputColor0": CIColor(color: foregroundColor),
            "inputColor1": CIColor(color: backgroundColor)
        ]
        
        let colored = output.applyingFilter("CIFalseColor", parameters: colorParameters)
        
        let context = CIContext()
        guard let cgImage = context.createCGImage(colored, from: output.extent) else { return nil }
        return UIImage(cgImage: cgImage)

    }
    
}
