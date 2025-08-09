//
//  Destination.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/07/14.
//

import SwiftUI

struct Destination: View {
    
    var address: String?
    
    var body: some View {
        HStack(spacing:12){
            Image(systemName: "mappin.and.ellipse")
                .foregroundColor(.secondary)
            VStack(alignment: .leading){
                
                Text("目的地")
                    .font(.subheadline)
                Text(address ?? "指定してください")
                    .font(.headline)
            }
            Spacer()
        }
        .foregroundStyle(address == nil ? Color.secondary : Color.primary)
        .padding()
        .background(Color(uiColor: .systemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    Destination()
}
