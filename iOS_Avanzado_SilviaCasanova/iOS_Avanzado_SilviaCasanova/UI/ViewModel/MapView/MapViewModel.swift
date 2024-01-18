////
////  MapViewModel.swift
////  iOS_Avanzado_SilviaCasanova
////
////  Created by Silvia Casanova Martinez on 2/11/23.
////

import Foundation
import MapKit
class MapViewModel {
    var heroLocations: [Location] = []
    var heroes:[Hero] = []
    var anotations = [LocationsAnotations(coordinate: CLLocationCoordinate2D(), title: "", info: "")]
    
    func fectchLocations() -> [Location] {
        for hero in heroes {
            
            DispatchQueue.global().async {
                guard let token = SecureDataProvider.shared.getToken() else {
                    return
                }
                ApiProvider.shared.getLocations(
                    by: hero.id,
                    token: token
                ) { [weak self] anotations in
                    print("\(String(describing: self?.heroLocations))")
                    self?.heroLocations.append(contentsOf: anotations)
                }
                
                
            }
        }
        return heroLocations
    }
    
}
