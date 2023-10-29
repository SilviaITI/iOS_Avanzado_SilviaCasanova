//
//  Locations.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 29/10/23.
//

import UIKit
import MapKit

class LocationsAnotations: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var info: String
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, info: String) {
        self.coordinate = coordinate
        self.title = title
        self.info = info
    }

}
