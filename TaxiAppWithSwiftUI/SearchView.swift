//
//  SearchView.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/07/14.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        VStack(spacing:0){
            // Input Field
            inputField
            
            Divider()
            
            // Results
            searchResults
        }
    }
}

#Preview {
    SearchView()
}

extension SearchView {
    private var inputField: some View {
        Capsule()
            .frame(width: 300, height: 70)
            .padding()
    }
    
    private var searchResults: some View {
        ScrollView{
            VStack(spacing:16){
                Text("検索結果")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment:.leading)
                
                ForEach(0..<10){index in
                    RoundedRectangle(cornerRadius: 18)
                        .frame(height: 70)
                }
           
                
            }
            .padding()
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
}
