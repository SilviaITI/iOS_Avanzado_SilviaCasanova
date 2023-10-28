//
//  UseCaseLogin.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 28/10/23.
//

import Foundation

protocol LoginUseCaseProtocol {
    func doLogin(success: @escaping sucesssLogin, onError: @escaping errorClosure)
}
final class LoginUseCase: LoginUseCaseProtocol {
    func doLogin(success: @escaping sucesssLogin, onError: @escaping errorClosure) {
        ApiProvider.shared.login(
            user: "silvia.casanovamartinez@gmail.com", //userNameTextField.text ?? "",
            password: "Goku2021"//passwordTextField.text ?? ""
        ) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    print(result)
                    //self?.navigationController?.pushViewController(ListadoHeroesViewController(), animated: true)
                }
            case let .failure(error):
                print("Error: \(error)")
                DispatchQueue.main.async {
                    //self?.errorLabel.isHidden = false
                }
            }
            // self?.hideLoading()
        }
    }
    final class LoginUseCaseSuccess: LoginUseCaseProtocol {
        func doLogin(success: @escaping sucesssLogin, onError: @escaping errorClosure) {
            ApiProvider.shared.login(
                user: "silvia.casanovamartinez@gmail.com", //userNameTextField.text ?? "",
                password: "Goku2021"//passwordTextField.text ?? ""
            ) { [weak self] result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        print(result)
                        //self?.navigationController?.pushViewController(ListadoHeroesViewController(), animated: true)
                    }
                case let .failure(error):
                    print("Error: \(error)")
                    DispatchQueue.main.async {
                        //self?.errorLabel.isHidden = false
                    }
                }
                // self?.hideLoading()
            }
        }
    }
    
}
