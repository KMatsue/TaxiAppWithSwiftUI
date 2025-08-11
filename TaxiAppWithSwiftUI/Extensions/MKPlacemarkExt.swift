//
//  MKPlacemarkExt.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/08/11.
//

import Foundation
import MapKit

extension MKPlacemark {
    var addressString: String {
        let administrativeArea = self.administrativeArea ?? ""
        let locality = self.locality ?? ""
        let subLocality = self.subLocality ?? ""
        let thoroughfare = self.thoroughfare ?? ""
        let subThoroughfare = self.subThoroughfare ?? ""
        
        return "\(administrativeArea)\(locality)\(subLocality)\(thoroughfare)\(subThoroughfare)"
    }
}
