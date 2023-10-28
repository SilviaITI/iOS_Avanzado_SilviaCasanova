//
//  LoginViewModel.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 28/10/23.
//

import Foundation

final class LoginViewModel: LoginViewControllerDelegate {
    var viewState: ((LoginViewState) -> Void)?
    
    func fetchLogin(with email: String?, password: String?) {
        viewState?(.loading(_isloading: true))
            ApiProvider.shared.login(
                user: email ?? "",
                password: password ?? ""
            ) { [ weak self] result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        print(result)
                        self?.viewState?(.loading(_isloading: false))
                        self?.viewState?(.navigateToHome)
                        //self?.navigationController?.pushViewController(ListadoHeroesViewController(), animated: true)
                    }
                case let .failure(error):
                    print("Error: \(error)")
                    DispatchQueue.main.async {
                        self?.viewState?(.loading(_isloading: false))
                       //self?.errorLabel.isHidden = false
                    }
                }
            }
        }
    }
    
    
    

