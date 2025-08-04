//
//  DestinationView.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/07/14.
//

import SwiftUI
import MapKit

struct DestinationView: View {
    
    let placemark: MKPlacemark
    @EnvironmentObject var mainViewModel: MainViewModel
    @Environment(\.dismiss)var dismiss
    @State private var cameraPosition: MapCameraPosition = .automatic
    
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
        DestinationView(placemark: .init(coordinate: .init(latitude: 35.45218, longitude: 139.6324)))
            .environmentObject(MainViewModel())
    }
}

extension DestinationView {
    private var map: some View {
        Map(position: $cameraPosition){
            
        }
        .onAppear(){
            cameraPosition = .camera(MapCamera(centerCoordinate: placemark.coordinate, distance: 800, pitch: 0))
        }
        .onMapCameraChange(frequency: .onEnd) { context in
            let center = context.region.center
            Task {
                await mainViewModel.setDestination(latitude: center.latitude, longitude: center.longitude)
            }
            
        }
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
            Destination(address: mainViewModel.destinationAddress)
            // Button
            Button {
                mainViewModel.showSearchView = false
                Task {
                    await mainViewModel.fetchRoute()
                    
                }
            } label: {
                Text("ここに行く")
                    .modifier(BasicButton())
            }
            
        }.padding(.horizontal)
            .padding(.top,14)
    }
}
