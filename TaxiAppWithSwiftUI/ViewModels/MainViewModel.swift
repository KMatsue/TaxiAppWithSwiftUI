//
//  MainViewModel.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/07/21.
//

import Foundation
import CoreLocation
import MapKit

enum UserState{
    case setRidePoint
    case searchLocation
}

class MainViewModel: ObservableObject {
    var userState: UserState = .setRidePoint
    
    @Published var showSearchView: Bool = false
    
    @Published var ridePointAddress = ""
    var ridePointCoordinate: CLLocationCoordinate2D?
    
    @Published var destinationAddress = ""
    var destinationCoordinates: CLLocationCoordinate2D?
    
    @Published var route: MKRoute?
    
    //    init () {
    //        Task {
    //            await getLocationAddress(latitude: 35.45218, longitude: 139.63241)
    //        }
    //    }
    //
    
    @MainActor
    func setRideLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        ridePointCoordinate = location.coordinate
        ridePointAddress = await getLocationAddress(location: location)
    }
    
    @MainActor
    func setDestination(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        destinationCoordinates = location.coordinate
        destinationAddress = await getLocationAddress(location: location)
    }
    
    func getLocationAddress(location: CLLocation) async -> String{
        
        let geocoder = CLGeocoder()
        //        let location = CLLocation(latitude: latitude, longitude: longitude)
        //
        //        ridePointCoordinate = location.coordinate
        
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            //            for placemark in placemarks {
            //                print("placemark: \(placemark)")
            guard let placemark = placemarks.first else { return ""}
            
            let administrativeArea = placemark.administrativeArea ?? ""
            let locality = placemark.locality ?? ""
            let subLocality = placemark.subLocality ?? ""
            let thoroughfare = placemark.thoroughfare ?? ""
            let subThoroughfare = placemark.subThoroughfare ?? ""
            
            //                print("DEBUG: \(administrativeArea)\(locality)\(subLocality)\(thoroughfare)\(subThoroughfare)")
            
            return "\(administrativeArea)\(locality)\(subLocality)\(thoroughfare)\(subThoroughfare)"
            
            //            }
            
        } catch {
            print("位置情報の処理に失敗しました：\(error.localizedDescription)")
            return ""
        }
    }
    
    @MainActor
    func fetchRoute() async {
        guard let ridePointCoordinate , let destinationCoordinates else {return}
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: .init(coordinate: ridePointCoordinate))
        request.destination =  MKMapItem(placemark: .init(coordinate: destinationCoordinates))
        do {
            let directions = try await MKDirections(request: request).calculate()
            route = directions.routes.first
        }catch {
            print("ルートの生成に失敗しました：\(error.localizedDescription)")
        }
    }
}
