//
//  MapViewController.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 29/10/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var heroes: [Hero] = []
    @IBOutlet weak var heroesMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fectchLocations()
        
        // Do any additional setup after loading the view.
    }
    
    
    func fectchLocations() {
        for hero in heroes {
            
            DispatchQueue.global().async {
                // defer { self.viewState?(.loading(false)) }
                guard let token = SecureDataProvider.shared.getToken() else {
                    return
                }
                ApiProvider.shared.getLocations(
                    by: hero.id,
                    token: token
                ) { [weak self] heroLocations in
                    self?.updateViews(locations: heroLocations)
                    print("\(heroLocations)")
                }
                
                
            }
        }
    }
    private func updateViews( locations: [Location] ) {
        DispatchQueue.main.async {
            for hero in self.heroes {
            locations.forEach {
                self.heroesMap.addAnnotation(
                    LocationsAnotations(
                        coordinate: .init(latitude: Double($0.latitud ) ?? 0.0,
                                          longitude: Double($0.longitud ) ?? 0.0),
                        title:hero.name,
                        info: hero.id
                    )
                )
               
                       self.heroesMap.setNeedsDisplay() // Refresca el mapa
                   }
                
            }
        }

        
    }
}
