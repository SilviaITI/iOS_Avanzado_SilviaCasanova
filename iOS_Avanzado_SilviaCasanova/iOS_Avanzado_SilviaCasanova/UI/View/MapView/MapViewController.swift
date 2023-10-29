//
//  MapViewController.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 29/10/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var locations:[Location] = []
    var heroes: [Hero] = []
    @IBOutlet weak var heroesMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fectchLocations()
        // Do any additional setup after loading the view.
    }
    
    
    func fectchLocations() {
        ApiProvider.shared.getLocations { result in
            switch result {
            case let .success(locations):
                self.locations = locations
                
                DispatchQueue.main.async {
                    print("se han cargado los heroes")
                }
                
            case let .failure(error):
                print("Error: \(error)")
            }
            print("\(self.locations)")
        }
        
    }
  
}
