//
//  PreviewLayoutComponentModifier.swift
//  Cashier
//
//  Created by Rahaf Alhubeis on 14/11/1443 AH.
//

import Foundation
import SwiftUI

struct PreviewLayoutComponentModifier: ViewModifier {
    
    let name: String
    
    func body(content: Content) -> some View {
        
        content
            .previewLayout(.sizeThatFits)
            .previewDisplayName(name)
            .padding()
    }
}

extension View {
    
    func preview(with name: String) -> some View {
        self.modifier(PreviewLayoutComponentModifier(name: name))
    }
}
