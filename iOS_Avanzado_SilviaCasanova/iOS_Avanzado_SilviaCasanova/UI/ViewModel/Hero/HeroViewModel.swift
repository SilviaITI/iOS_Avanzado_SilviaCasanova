//
//  HeroViewModel.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 28/10/23.
//

import Foundation

class HeroesViewModel: HeroesTableViewControllerDelegate {
    var viewState: ((HeroesViewState) -> Void)?
    var heroes: [Hero] = []
    var heroesCount: Int {
        return heroes.count
    }
    
    func  fetchHeroesList() {
     
            ApiProvider.shared.getHeroes { result in
                switch result {
                case let .success(heroes):
                    self.heroes = heroes
                    DispatchQueue.main.async {
                        self.viewState?(.reloadData)
                     
                    }
                    
                case let .failure(error):
                    print("Error: \(error)")
                }
            }
        }
   
        
        func heroBy(index: Int) -> Hero? {
            if index >= 0 && index < heroesCount {
                return heroes[index]
            } else {
                return nil
            }
        }
    }
    
    

