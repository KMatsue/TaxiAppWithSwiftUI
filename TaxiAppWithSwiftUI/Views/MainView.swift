//
//  MainView.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/07/13.
//

import SwiftUI
import MapKit
import CoreLocation

struct MainView: View {
    
    @ObservedObject var mainViewModel = MainViewModel()
    
    @State private var showSearchView: Bool = false
//    @State private var cameraPosison: MapCameraPosition = .region(
//        MKCoordinateRegion(
//            center: .init(latitude: 35.45218, longitude: 139.63241),
//            latitudinalMeters: 1000,
//            longitudinalMeters: 1000
//        )
//    )
    
    @State private var cameraPosison: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        VStack {
            // Map Area
            map
            // Information Area
            information
        }
        .sheet(isPresented: $showSearchView){
            SearchView()
        }
    }
}

#Preview {
    MainView()
}

extension MainView{
    
    private var map: some View {
        Map(position: $cameraPosison) {
            UserAnnotation()
        }
        .overlay {
            CenterPin()
        }
        .onAppear {
            CLLocationManager().requestWhenInUseAuthorization()
        }
        .onMapCameraChange(frequency: .onEnd) { context in
//                print("DEBUG: \(context)")
            let center = context.camera.centerCoordinate
            Task {
                await mainViewModel.getLocationAddress(latitude: center.latitude, longitude: center.longitude)
            }
            
        }
    }
    
    private var information: some View {
        VStack(alignment: .leading) {
            // Starting Point
            HStack(spacing:12){
                Image(systemName: "figure.wave")
                    .imageScale(.large)
                    .foregroundStyle(.main)
                
                VStack(alignment: .leading){
                    HStack{
                        Text("乗車地")
                            .font(.subheadline)
                        Text("地図を動かして地点を調整")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    Text(mainViewModel.strPointName)
                        .font(.headline)
                }
                Spacer()
            }
            .padding(.vertical)
            // Destination
            Destination()
                .overlay(alignment: .topLeading){
                    VStack{
                        Image(systemName: "arrowtriangle.down.fill")
                        Image(systemName: "arrowtriangle.down.fill").opacity(0.66)
                        Image(systemName: "arrowtriangle.down.fill").opacity(0.33)
                    }
                    .font(.caption2)
                    .foregroundStyle(.main)
                    .offset(x: 8, y: -16)
                }
            
            Spacer()
            // Button
            Button{
                //                print("押されました")
                showSearchView.toggle()
            }label: {
                Text("目的地を指定する")
                    .modifier(BasicButton())
            }
            
            
        }.padding(.horizontal)
            .frame(height: 240)
    }
}

