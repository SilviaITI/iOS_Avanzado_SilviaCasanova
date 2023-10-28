//
//  Location.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 28/10/23.
//

import Foundation
typealias HeroLocations = [Location] 
struct Location: Codable {
    
    let id: String
    let latitud: String
    let longitud: String
    let dataShow: String
    let hero: Hero
    
}
