//
//  MainView.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/07/13.
//

import SwiftUI

struct MainView: View {
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
    MainView()
}

extension MainView{
    
    private var map: some View {
        Color.gray
    }
    
    private var information: some View {
        VStack(alignment: .leading) {
            // Starting Point
            HStack(spacing:12){
                Circle()
                    .frame(width: 30,height: 30)
                VStack(alignment: .leading){
                    HStack{
                        Text("乗車地")
                            .font(.subheadline)
                        Text("地図を動かして地点を調整")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    Text("横浜市西区みなとみらい1-1")
                        .font(.headline)
                }
                Spacer()
            }
            .padding(.vertical)
            // Destination
            HStack(spacing:12){
                Circle()
                    .frame(width: 30,height: 30)
                VStack(alignment: .leading){
                 
               
                            Text("目的地")
                                .font(.subheadline)
                            Text("地図を動かして地点を調整")
                        .font(.headline)
                               
                        
                }
                Spacer()
            }
            .foregroundStyle(.secondary)
            .padding()
            .background(Color(uiColor: .systemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 18))
            
            Spacer()
            // Button
            Capsule()
                .frame(height: 60)
            
            
        }.padding(.horizontal)
            .frame(height: 240)
    }
}

