//
//  ApiProvider.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 28/10/23.
//

import Foundation

    
    final class ApiProvider {
        
        var secureDataProvider = SecureDataProvider()
        enum ApiProviderError: Error {
            case unknown
            case malformedUrl
            case decodingFailed
            case encodingFailed
            case noData
            case statusCode(code: Int?)
            case noToken
        }
        enum Path {
            static let login = "/api/auth/login"
            static let heroes = "/api/heros/all"
            static let heroLocations = "/api/heros/locations"
        }
        
        // MARK: - Properties
        static let shared = ApiProvider()
        private var baseComponents: URLComponents {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "dragonball.keepcoding.education"
            return components
        }
        
        private var token: String? {
            get {
                if let token = secureDataProvider.getToken() {
                    return token
                }
                return nil
            }
            set {
                if let token = newValue {
                    secureDataProvider.save(token: token)
                }
            }
        }
       
        
        private let session: URLSession
        
        init(session: URLSession = .shared) {
            self.session = session
        }
        
        // https://dragonball.keepcoding.education/api/auth/login
        // MARK: - Public Methods
        // Funcion login : Function that takes user and password as parameters, makes a call to the service, and receives a token
        func login(
            user: String,
            password: String,
            completion: @escaping (Result<String, ApiProviderError>) -> Void
        ) {
            var components = baseComponents
            components.path = Path.login
            
            guard let url = components.url else {
                completion(.failure(.malformedUrl))
                return
            }
            
            // user:password
            let loginString = String(format: "%@:%@", user, password)
            print("\(loginString)")
            guard let loginData = loginString.data(using: .utf8) else {
                completion(.failure(.decodingFailed))
                return
            }
            let base64LoginString = loginData.base64EncodedString()
            print("🚀 \(base64LoginString)")
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            print("\(request)")
            let task = session.dataTask(with: request) { [weak self] data, response, error in
                guard error == nil else {
                    completion(.failure(.unknown))
                    return
                }
                
                guard let data else {
                    completion(.failure(.noData))
                    return
                }
                
                let urlResponse = response as? HTTPURLResponse
                let statusCode = urlResponse?.statusCode
                
                guard statusCode == 200 else {
                    completion(.failure(.statusCode(code: statusCode)))
                    print("❌ \(statusCode)")
                    return
                }
                print("✅ \(data)")
                guard let token = String(data: data, encoding: .utf8) else {
                    completion(.failure(.decodingFailed))
                    return
                }
                
                completion(.success(token))
                self?.token = token
            }
            print("respuesta token \(request)")
            
            task.resume()
        }
        
        // Function getHeroes: function that send for parameter a token, makes a call to the service and receive list of heroes
        func getHeroes(
            completion: @escaping (Result<[Hero], ApiProviderError>) -> Void
        ) {
            var components = baseComponents
            components.path = Path.heroes
            
            guard let url = components.url else {
                completion(.failure(.malformedUrl))
                return
            }
            
            guard let token else {
                completion(.failure(.noToken))
                return
            }
            
            var urlComponents = URLComponents()
            urlComponents.queryItems = [URLQueryItem(name: "name", value: "")]
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = urlComponents.query?.data(using: .utf8)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            createTask(
                for: request,
                using: [Hero].self,
                completion: completion
            )
            print("respuesta heroes \(request)")

        }
        func getLocation(
            completion: @escaping (Result<[Location], ApiProviderError>) -> Void
        ) {
            var components = baseComponents
            components.path = Path.heroLocations
            
            guard let url = components.url else {
                completion(.failure(.malformedUrl))
                return
            }
            
            guard let token else {
                completion(.failure(.noToken))
                return
            }
            
            var urlComponents = URLComponents()
            urlComponents.queryItems = [URLQueryItem(name: "name", value: "")]
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = urlComponents.query?.data(using: .utf8)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            createTask(
                for: request,
                using: [Location].self,
                completion: completion
            )
            print("respuesta location \(request)")
        }

        // Function that requests a response from a URL with a type "T" item
        func createTask<T: Decodable>(
            for request: URLRequest,
            using type: T.Type,
            completion: @escaping (Result<T, ApiProviderError>) -> Void
        ) {
            let task = session.dataTask(with: request) { data, response, error in
                let result: Result<T, ApiProviderError>
                
                defer {
                    completion(result)
                }

                guard error == nil else {
                    result = .failure(.unknown)
                    return
                }
                
                guard let data else {
                    result = .failure(.noData)
                    return
                }
                
                guard let resource = try? JSONDecoder().decode(type, from: data) else {
                    result = .failure(.decodingFailed)
                    return
                }
                
                result = .success(resource)
            }
            
            task.resume()
        }
    }

