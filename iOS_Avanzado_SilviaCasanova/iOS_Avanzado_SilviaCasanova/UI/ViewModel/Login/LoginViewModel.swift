//
//  LoginViewModel.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 28/10/23.
//

import Foundation

final class LoginViewModel: LoginViewControllerDelegate {
    var heroesViewModel: HeroesViewModel = HeroesViewModel()
    
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
                    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
                        self?.viewState?(.loading(_isloading: false))
                        self?.viewState?(.navigateToHome)
                        self?.onLoginResponse()
                    }
                    
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
    
   private func onLoginResponse() {
        defer { viewState?(.loading(_isloading: false)) }

        // Parsear resultado que vendrá en notification.userInfo
       guard let token = SecureDataProvider.shared.getToken(),
              token.isEmpty else {
            return
        }

        SecureDataProvider.shared.save(token: token)
        viewState?(.navigateToHome)
    }
}
    

