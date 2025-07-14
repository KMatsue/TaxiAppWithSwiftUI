//
//  DestinationView.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/07/14.
//

import SwiftUI

struct DestinationView: View {
    var body: some View {
        VStack {
            // Map Area
            map
            // Information Area
            information
        }
    }
}

#Preview {
    DestinationView()
}

extension DestinationView {
    private var map: some View {
        Color.gray
    }
    
    private var information: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Caption
            VStack(alignment: .leading){
                Text("この場所でよろしいですか？")
                    .font(.title3.bold())
                Text("地図を動かして地点を調整")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                // Destination
                HStack(spacing:12){
                    Circle()
                        .frame(width: 30,height: 30)
                    VStack(alignment: .leading){
                        
                        Text("目的地")
                            .font(.subheadline)
                        Text("指定してください")
                            .font(.headline)
                    }
                    Spacer()
                }
                .foregroundStyle(.secondary)
                .padding()
                .background(Color(uiColor: .systemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            
            
            // Button
            Capsule()
                .frame(height: 60)
            
        }.padding(.horizontal)
            .padding(.top,14)
    }
}
