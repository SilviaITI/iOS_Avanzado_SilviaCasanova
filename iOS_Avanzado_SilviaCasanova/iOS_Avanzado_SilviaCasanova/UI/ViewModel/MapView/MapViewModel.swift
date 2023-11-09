////
////  MapViewModel.swift
////  iOS_Avanzado_SilviaCasanova
////
////  Created by Silvia Casanova Martinez on 2/11/23.
////
//
//import Foundation
//
//class MapViewModel: MapViewControllerDelegate {
//   
//    var viewState: ((MapViewState) -> Void)?
//    var heroes: [Hero]
//    init(viewState: ( (MapViewState) -> Void)? = nil, heroes: [Hero]) {
//        self.viewState = viewState
//        self.heroes = heroes
//    }
//    
//    func fectchLocations() {
//        for hero in heroes {
//            
//            DispatchQueue.global().async {
//                // defer { self.viewState?(.loading(false)) }
//                guard let token = SecureDataProvider.shared.getToken() else {
//                    return
//                }
//                ApiProvider.shared.getLocations(
//                    by: hero.id,
//                    token: token
//                ) { [weak self] heroLocations in
//                    self?.updateViews(locations: heroLocations)
//                    print("\(heroLocations)")
//                }
//                
//                
//            }
//        }
//    }
//    }

