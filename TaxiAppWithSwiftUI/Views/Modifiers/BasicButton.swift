//
//  BasicButton.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/07/20.
//

import SwiftUI

struct BasicButton: ViewModifier {
    
    var isPrimary : Bool = true
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .foregroundColor(isPrimary ? .white : .primary)
            .fontWeight(.bold)
            .padding()
            .background(isPrimary ? .main : Color(uiColor: .systemFill))
            .clipShape(Capsule())
    }
}
