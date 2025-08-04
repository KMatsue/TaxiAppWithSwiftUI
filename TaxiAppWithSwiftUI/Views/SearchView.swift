//
//  SearchView.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/07/14.
//

import SwiftUI
import MapKit

struct SearchView: View {
    
    @ObservedObject var searchViewModel : SearchViewModel = SearchViewModel()
    @Environment(\.dismiss)var dismiss
    @State private var searchText = ""
    let center: CLLocationCoordinate2D?
    
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                Divider()
                // Input Field
                inputField
                
                Divider()
                
                // Results
                searchResults
            }
            .navigationTitle("目的地を検索")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("キャンセル") {
                        dismiss()
                    }
                    .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    SearchView(center: .init(latitude: 35.45218, longitude: 139.6324))
}

extension SearchView {
    private var inputField: some View {
        TextField("場所を入力...", text: $searchText)
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .clipShape(Capsule())
            .padding()
            .onSubmit {
                guard !searchText.isEmpty, let center else { return }
                Task {
                    await searchViewModel.searchPlace(searchText: searchText, center: center, meters: 1000)
                }
                
            }
    }
    
    private var searchResults: some View {
        ScrollView{
            VStack(spacing:16){
                Text("検索結果")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment:.leading)
                
                ForEach(searchViewModel.searchResult, id: \.self){ mapItem in
                    searchResultRow(mapItem:mapItem)
                }
                
                
            }
            .padding()
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
    
    private func searchResultRow(mapItem: MKMapItem) -> some View {
        NavigationLink {
            DestinationView(placemark: mapItem.placemark)
        } label: {
            HStack(spacing: 12){
                // Icon
                Image(systemName: "mappin.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.main)
                // Text
                VStack(alignment: .leading){
                    Text(mapItem.name ?? "")
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                    Text(searchViewModel.getAddressStrint(placemark: mapItem.placemark))
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                //Icon
                Image(systemName: "chevron.right")
                    .foregroundStyle(.main)
            }
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        
        
    }
    
//    private var searchResultRow: some View {
//        NavigationLink {
//            DestinationView()
//        } label: {
//            HStack(spacing: 12){
//                // Icon
//                Image(systemName: "mappin.circle.fill")
//                    .resizable()
//                    .frame(width: 24, height: 24)
//                    .foregroundStyle(.main)
//                // Text
//                VStack(alignment: .leading){
//                    Text("横浜スタジアム")
//                        .fontWeight(.bold)
//                        .foregroundStyle(.black)
//                    Text("神奈川県横浜市中区横浜公園")
//                        .font(.caption)
//                        .foregroundStyle(.gray)
//                }
//                
//                Spacer()
//                
//                //Icon
//                Image(systemName: "chevron.right")
//                    .foregroundStyle(.main)
//            }
//            .padding()
//            .background(.white)
//            .clipShape(RoundedRectangle(cornerRadius: 14))
//        }
//        
//        
//    }
}
