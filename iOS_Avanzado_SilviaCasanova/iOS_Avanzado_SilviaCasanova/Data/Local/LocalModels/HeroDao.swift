//
//  HeroDao.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 29/10/23.
//

import Foundation
import CoreData

import Kingfisher

@objc(HeroDao)
class HeroDao: NSManagedObject {
    
    static let entityNameHero = "HeroDao"
    
    @NSManaged var descriptionHero: String?
    @NSManaged var favorite: Bool
    @NSManaged var name: String?
    @NSManaged var photo: String?
    @NSManaged var id: String
    
    convenience init(hero: Hero, context: NSManagedObjectContext) {
        self.init( context: context)
        
        id = hero.id
        if let name = hero.name {
            self.name = name
        }
        if let descriptionHero = hero.description {
            self.descriptionHero = descriptionHero
        }
        if let photo = hero.photo {
            self.photo = photo.absoluteString
        }
        if let favorite = hero.favorite {
            self.favorite = favorite
        }
        
    }
}
