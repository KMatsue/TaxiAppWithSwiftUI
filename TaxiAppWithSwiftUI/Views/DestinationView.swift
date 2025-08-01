//
//  DestinationView.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/07/14.
//

import SwiftUI

struct DestinationView: View {
    
    @Environment(\.dismiss)var dismiss
    
    var body: some View {
        VStack {
            // Map Area
            map
            // Information Area
            information
        }
        .navigationTitle("地点を確認・調整")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button{
                   dismiss()
                } label:{
                    Image(systemName: "chevron.left")
                        .font(.headline)
                }
                .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    NavigationStack{
        DestinationView()
    }
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
            }
            // Destination
            Destination()
            // Button
            Button {
                print("ボタンが押されました")
            } label: {
                Text("ここに行く")
                    .modifier(BasicButton())
            }

        }.padding(.horizontal)
            .padding(.top,14)
    }
}
