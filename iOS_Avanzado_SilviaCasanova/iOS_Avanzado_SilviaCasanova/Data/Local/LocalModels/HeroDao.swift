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
    @NSManaged var favoriote: Bool
    @NSManaged var name: String?
    @NSManaged var photo: String?
    @NSManaged var id: String?
    
    convenience init(hero: Hero, context: NSManagedObjectContext) {
        self.init( context: context)
        
     id = hero.id
        name = hero.name
        descriptionHero = hero.description
        photo = hero.photo?.absoluteString
        favoriote = hero.favorite ?? false
        
    }
    
}
