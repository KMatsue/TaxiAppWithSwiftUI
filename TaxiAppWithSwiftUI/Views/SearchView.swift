//
//  SearchView.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/07/14.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""
    
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
        TextField("場所を入力...", text: $searchText)
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .clipShape(Capsule())
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
                    searchResultRow
                }
                
                
            }
            .padding()
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
    
    private var searchResultRow: some View {
        HStack(spacing: 12){
            // Icon
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(.black)
            // Text
            VStack(alignment: .leading){
                Text("横浜スタジアム")
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                Text("神奈川県横浜市中区横浜公園")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            //Icon
            Image(systemName: "chevron.right")
                .foregroundStyle(.black)
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        
    }
}
