//
//  BasicButton.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/07/20.
//

import SwiftUI

struct BasicButton: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding()
            .background(.main)
            .clipShape(Capsule())
    }
}
