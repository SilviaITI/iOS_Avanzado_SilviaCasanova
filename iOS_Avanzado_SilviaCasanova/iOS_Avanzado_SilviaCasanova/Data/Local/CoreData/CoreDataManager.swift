//
//  CoreDataManager.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 29/10/23.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private var moc: NSManagedObjectContext? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }


    func saveHero(hero: Hero) {
        guard let moc = moc,
              let heroEntity = NSEntityDescription.entity(forEntityName: HeroDao.entityNameHero, in: moc) else {
            return
        }
        
        let newHero = HeroDao(entity: heroEntity, insertInto: moc)
        // Configura las propiedades de 'newHero' con los datos del héroe que quieras guardar
        do {
            try moc.save()
            print("Se han guardado los héroes")
        } catch {
            print("Error al guardar los héroes")
        }
        
        
    }
    func loadHero() -> [HeroDao] {
        guard let moc = moc else {
            return []
        }

        let fetchRequest: NSFetchRequest<HeroDao> = NSFetchRequest(entityName: HeroDao.entityNameHero)

        do {
            let heroes = try moc.fetch(fetchRequest)
            print("Heroes: \(heroes)")
            return heroes
        } catch {
            print("Error al cargar los héroes: \(error)")
            return []
        }
    }

    func deleteAll() {
        let fetchHero = NSFetchRequest<HeroDao>(entityName: HeroDao.entityNameHero)
        guard let moc,
              let heroes = try? moc.fetch(fetchHero) else { return }

        heroes.forEach { moc.delete($0) }
        try? moc.save()
    }

}
