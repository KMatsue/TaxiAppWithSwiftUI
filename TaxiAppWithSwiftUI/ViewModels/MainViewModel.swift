//
//  MainViewModel.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/07/21.
//

import Foundation
import CoreLocation

class MainViewModel: ObservableObject {
    @Published var strPointName = ""
    
    init () {
        Task {
            await getLocationAddress(latitude: 35.45218, longitude: 139.63241)
        }
    }
    
    @MainActor
    func getLocationAddress(latitude: CLLocationDegrees, longitude:CLLocationDegrees) async{
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            for placemark in placemarks {
                print("placemark: \(placemark)")
                guard let placemark = placemarks.first else { return }
                
                let administrativeArea = placemark.administrativeArea ?? ""
                let locality = placemark.locality ?? ""
                let subLocality = placemark.subLocality ?? ""
                let thoroughfare = placemark.thoroughfare ?? ""
                let subThoroughfare = placemark.subThoroughfare ?? ""
                
                print("Debug: \(administrativeArea)\n\(locality)\n\(subLocality)\n\(thoroughfare)\n\(subThoroughfare)")
                
                strPointName = "\(administrativeArea)\(locality)\(subLocality)\(thoroughfare)\(subThoroughfare)"
            }
        } catch {
            print("位置情報の処理に失敗しました：\(error.localizedDescription)")
        }
    }
}
