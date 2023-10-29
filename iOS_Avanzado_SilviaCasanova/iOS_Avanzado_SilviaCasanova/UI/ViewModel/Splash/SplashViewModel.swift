//
//  SplashViewModel.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 28/10/23.
//

import Foundation

class SplashViewModel: SplashViewControllerDelegate {
    var loginViewModel: LoginViewModel = LoginViewModel()
    
    
    var viewState: ((SplashViewState) -> Void)?
    
    func onViewAppear() {
        viewState?(.loading(true))
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
            self.isTokenSaved() ?  self.viewState?(.navigateToHome): self.viewState?(.navigateToLogin)
                    }
        }
        func isTokenSaved() -> Bool {
            SecureDataProvider.shared.getToken()?.isEmpty == false
        }
    }

