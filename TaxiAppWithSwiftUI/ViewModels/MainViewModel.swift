//
//  MainViewModel.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/07/21.
//

import Foundation
import CoreLocation

enum UserState{
    case setRidePoint
    case searchLocation
}

class MainViewModel: ObservableObject {
    var userState: UserState = .setRidePoint
    
    @Published var ridePointAddress = ""
    var ridePointCoordinate: CLLocationCoordinate2D?
    
    @Published var destinationAddress = ""
    var destinationCoordinates: CLLocationCoordinate2D?
    
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
}
