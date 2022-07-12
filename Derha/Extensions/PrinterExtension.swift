//
//  PrinterExtension.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 24/11/1443 AH.
//

import UIKit

extension UIImage {
    
    func resizeImage(_ newWidth: CGFloat) -> UIImage? {
        
        let image = self
        guard newWidth != 0 else { return nil }
        guard image.size.width != 0 && image.size.height != 0 else { return nil }
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
        
    }
    
    func alignmentImageIn(width: CGFloat, alignment: NSTextAlignment) -> UIImage? {
        // Create a context of the starting image size and set it as the current one
        UIGraphicsBeginImageContext(CGSize(width: width, height: self.size.height))
        
        // Draw the starting image in the current context as background
        if alignment == .center {
            self.draw(at: CGPoint(x: (width/2) - (self.size.width/2), y: 0))
        }else if alignment == .left {
            self.draw(at: CGPoint(x: 0, y: 0))
        }else if alignment == .right {
            self.draw(at: CGPoint(x: width - self.size.width, y: 0))
        }
            
        // Save the context as a new UIImage
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Return modified image
        return myImage
    }
    
}

