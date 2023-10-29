//
//  iOS_Avanzado_SilviaCasanovaTests.swift
//  iOS_Avanzado_SilviaCasanovaTests
//
//  Created by Silvia Casanova Martinez on 27/10/23.
//

import XCTest
@testable import iOS_Avanzado_SilviaCasanova

final class iOS_Avanzado_SilviaCasanovaTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Test de la función save(token:)
     func testSaveToken() {
         
         let secureDataProvider = SecureDataProvider.shared
         let tokenToSave = "TestToken"
         secureDataProvider.save(token: tokenToSave)
         let retrievedToken = secureDataProvider.getToken()
         XCTAssertEqual(retrievedToken, tokenToSave)
     }
    
    // Test de la función getToken()
     func testGetToken() {
         
         let secureDataProvider = SecureDataProvider.shared
         let tokenToSave = "TestToken"
         secureDataProvider.save(token: tokenToSave)
         let retrievedToken = secureDataProvider.getToken()
         XCTAssertEqual(retrievedToken, tokenToSave)
     }
    // Test de la funcion DeleteToken()
    func testDeleteToken() {
        
         let secureDataProvider = SecureDataProvider.shared
         let tokenToSave = "myAccessToken"
         secureDataProvider.save(token: tokenToSave)
         secureDataProvider.deleteToken(token: tokenToSave)
         XCTAssertNil(secureDataProvider.getToken())
     }
 }
    


