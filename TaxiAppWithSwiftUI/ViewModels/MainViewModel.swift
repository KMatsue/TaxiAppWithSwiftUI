//
//  MainViewModel.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/07/21.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

enum UserState{
    case setRidePoint
    case searchLocation
    case setDestination
    case confirming
}

class MainViewModel: ObservableObject {
    var userState: UserState = .setRidePoint{
        didSet {
            print("DEBUG: UserState changed to \(userState)")
        }
    }
    
    @Published var showSearchView: Bool = false
    
    @Published var ridePointAddress: String?
    var ridePointCoordinate: CLLocationCoordinate2D?
    
    @Published var destinationAddress: String?
    var destinationCoordinates: CLLocationCoordinate2D?
    
    @Published var mainCamera: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var route: MKRoute?
    
    //    init () {
    //        Task {
    //            await getLocationAddress(latitude: 35.45218, longitude: 139.63241)
    //        }
    //    }
    //
    
    @MainActor
    func setRideLocation(coordinates: CLLocationCoordinate2D) async {
        
        ridePointCoordinate = coordinates
        ridePointAddress = await coordinates.getLocationAddress()
    }
    
    @MainActor
    func setDestination(coordinates: CLLocationCoordinate2D) async {
        
        destinationCoordinates = coordinates
        destinationAddress = await coordinates.getLocationAddress()
    }
    
    //    func getLocationAddress(coordinates: CLLocationCoordinate2D) async -> String{
    //
    //        let geocoder = CLGeocoder()
    //        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
    //        //
    //        //        ridePointCoordinate = location.coordinate
    //
    //        do {
    //            let placemarks = try await geocoder.reverseGeocodeLocation(location)
    //            //            for placemark in placemarks {
    //            //                print("placemark: \(placemark)")
    //            guard let placemark = placemarks.first else { return ""}
    //            return MKPlacemark(placemark: placemark).addressString
    //
    //        } catch {
    //            print("位置情報の処理に失敗しました：\(error.localizedDescription)")
    //            return ""
    //        }
    //    }
    
    @MainActor
    func fetchRoute() async {
        guard let ridePointCoordinate , let destinationCoordinates else {return}
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: .init(coordinate: ridePointCoordinate))
        request.destination =  MKMapItem(placemark: .init(coordinate: destinationCoordinates))
        do {
            let directions = try await MKDirections(request: request).calculate()
            route = directions.routes.first
            changeCameraPosition()
        }catch {
            print("ルートの生成に失敗しました：\(error.localizedDescription)")
        }
    }
    
    private func changeCameraPosition(){
        switch userState {
        case .confirming:
            guard var rect = route?.polyline.boundingMapRect else {return}
            
            let paddingWidth = rect.size.width * 0.2
            let paddingHeight = rect.size.height * 0.2
            rect.size.width += paddingWidth
            rect.size.height += paddingHeight
            rect.origin.x -= paddingWidth / 2
            rect.origin.y -= paddingHeight / 2
            
            mainCamera = .rect(rect)
        default:
            mainCamera = .userLocation(fallback: .automatic)
        }
    }
    
    func reset(){
        userState = .setRidePoint
        ridePointAddress = ""
        ridePointCoordinate = nil
        destinationAddress = ""
        destinationCoordinates = nil
        route = nil
        
        changeCameraPosition()

    }
    
}
