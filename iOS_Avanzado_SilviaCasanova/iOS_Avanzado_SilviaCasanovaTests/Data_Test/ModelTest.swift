//
//  ModelTest.swift
//  iOS_Avanzado_SilviaCasanovaTests
//
//  Created by Silvia Casanova Martinez on 9/12/23.
//

import XCTest
@testable import iOS_Avanzado_SilviaCasanova
final class MoodelTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testModelHeroes() throws {
        
        //Create hero
        let photoUrl = URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087")
        let modelHero = Hero(id: "123", name: "Hero1", description: "Esto es una descripción genérica de prueba", photo: photoUrl, favorite: false)
        
        // test properties
        XCTAssertNotNil(modelHero)
        XCTAssertEqual(modelHero.id, "123")
        XCTAssertEqual(modelHero.name, "Hero1")
        XCTAssertEqual(modelHero.description, "Esto es una descripción genérica de prueba")
        XCTAssertEqual(modelHero.photo, photoUrl)
        XCTAssertEqual(modelHero.favorite, false)
        
    }
    func testLocation() throws {
        
        // Create location
        let photoUrl = URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087")
        let hero1 = Hero(id: "124", name: "Hero1", description: "Esto es una descripción genérica de prueba", photo: photoUrl, favorite: false)
   
        // test properties
        let location = Location(id: "id", latitud: "98", longitud: "35", dateShow: "4/24/98", hero: hero1)
        
        XCTAssertNotNil(location)
        XCTAssertEqual(location.id, "id")
        XCTAssertEqual(location.latitud, "98")
        XCTAssertEqual(location.longitud, "35")
        XCTAssertEqual(location.dateShow, "4/24/98")
      
    }
    
}
