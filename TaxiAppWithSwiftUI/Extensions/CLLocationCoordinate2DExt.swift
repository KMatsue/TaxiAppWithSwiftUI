//
//  CLLocationCoordinate2DExt.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/08/11.
//

import Foundation
import CoreLocation
import MapKit


extension CLLocationCoordinate2D {
    func getLocationAddress() async -> String{
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: self.latitude, longitude: self.longitude)

        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            
            guard let placemark = placemarks.first else { return ""}
            return MKPlacemark(placemark: placemark).addressString
            
        } catch {
            print("位置情報の処理に失敗しました：\(error.localizedDescription)")
            return ""
        }
    }
}
