//
//  SearchViewModel.swift
//  TaxiAppWithSwiftUI
//
//  Created by make on 2025/08/01.
//

import Foundation
import MapKit

class SearchViewModel: ObservableObject {
    
    @Published var searchResult: [MKMapItem] = []
    
//    init (){
//        Task {
//            await searchPlace(searchText: "arena", center: CLLocationCoordinate2D(latitude: 35.45218, longitude: 139.63241), meters: 1000)
//        }
//    }
    
    @MainActor
    func searchPlace(searchText: String, center: CLLocationCoordinate2D, meters: CLLocationDistance)async{
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = MKCoordinateRegion(center: center, latitudinalMeters: meters, longitudinalMeters: meters)
        do{
            let result = try await MKLocalSearch(request: request).start()
            searchResult = result.mapItems
            print("検索結果\(result.mapItems)")
        }catch {
            print("施設検索に失敗しました：\(error).localizedDescription")
        }
    }
    
    func getAddressStrint(placemark: MKPlacemark)-> String {
        let administrativeArea = placemark.administrativeArea ?? ""
        let locality = placemark.locality ?? ""
        let subLocality = placemark.subLocality ?? ""
        let thoroughfare = placemark.thoroughfare ?? ""
        let subThoroughfare = placemark.subThoroughfare ?? ""
        
        return "\(administrativeArea)\(locality)\(subLocality)\(thoroughfare)\(subThoroughfare)"
    }
}
