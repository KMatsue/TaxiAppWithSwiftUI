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
    
    @StateObject var mainViewModel = MainViewModel()
    
    
    //    @State private var cameraPosison: MapCameraPosition = .region(
    //        MKCoordinateRegion(
    //            center: .init(latitude: 35.45218, longitude: 139.63241),
    //            latitudinalMeters: 1000,
    //            longitudinalMeters: 1000
    //        )
    //    )
    
    
    var body: some View {
        VStack {
            // Map Area
            map
            // Information Area
            information
        }
        .sheet(isPresented: $mainViewModel.showSearchView) {
            if mainViewModel.userState != .confirming {
                mainViewModel.userState = .setRidePoint
            }
        } content: {
            SearchView()
                .environmentObject(mainViewModel)
        }
    }
}

#Preview {
    MainView()
}

extension MainView{
    
    private var map: some View {
        Map(position: $mainViewModel.mainCamera) {
            
            // ユーザーの現在地
            UserAnnotation()
            
            // 乗車地と目的地
            if let ridePoint = mainViewModel.ridePointCoordinate,
               let destination = mainViewModel.destinationCoordinates {
                Marker("乗車地", coordinate: ridePoint).tint(.blue)
                Marker("目的地", coordinate: destination).tint(.blue)
            }
            
            
            // 乗車地から目的地のルート
            if let polyline = mainViewModel.route?.polyline {
                MapPolyline(polyline)
                    .stroke(.blue, lineWidth: 7)
            }
        }
        .overlay {
            if mainViewModel.userState == .setRidePoint{
                CenterPin()
            }
        }
        .onAppear {
            CLLocationManager().requestWhenInUseAuthorization()
        }
        .onMapCameraChange(frequency: .onEnd) { context in
            //                print("DEBUG: \(context)")
            if mainViewModel.userState == .setRidePoint {
                Task {
                    await mainViewModel.setRideLocation(coordinates: context.camera.centerCoordinate)
                }
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
                    Text(mainViewModel.ridePointAddress ?? "")
                        .font(.headline)
                }
                Spacer()
            }
            .padding(.vertical)
            // Destination
            Destination(address: mainViewModel.destinationAddress)
                .threeTriangles(x: 8, y: -16)
            
            Spacer()
            // Button
            if mainViewModel.userState == .confirming{
                HStack(spacing: 16){
                    Button{
                        mainViewModel.reset()
                    } label: {
                        Text("キャンセル")
                            .modifier(BasicButton(isPrimary: false))
                    }
                    
                    Button{
                        
                    } label: {
                        Text("タクシーを呼ぶ")
                            .modifier(BasicButton())
                    }
                }
            }else{
                Button{
                    mainViewModel.userState = .searchLocation
                    //                print("押されました")
                    mainViewModel.showSearchView.toggle()
                }label: {
                    Text("目的地を指定する")
                        .modifier(BasicButton())
                }
            }
            
            
            
        }.padding(.horizontal)
            .frame(height: Constants.informationAreaHeight)
    }
}

