//
//  SplashViewController.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 28/10/23.
//

import UIKit

protocol SplashViewControllerDelegate {
    var viewState: ((SplashViewState) -> Void)? { get set }
    func onViewAppear()
    var loginViewModel: LoginViewModel { get set }
}
enum SplashViewState {
    case loading(_ isLoading: Bool)
    case navigateToLogin
    case navigateToHome
  
}
class SplashViewController: UIViewController {

    @IBOutlet var loadingView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onViewAppear()
        setObservers()
        
    }
    var viewModel = SplashViewModel()
    

  
    private func setObservers() {
        viewModel.viewState = { [weak self] state in
              DispatchQueue.main.async {
                  switch state {
                      case .loading(let isLoading):
                      self?.loadingView.isHidden = !isLoading
                      case .navigateToLogin:
                          self?.NavigateToLogin()
                  case .navigateToHome:
                      self?.NavigateToHome()
                  
                  }
              }
          }
      }
    private func NavigateToLogin() {
        DispatchQueue.main.async {
            let loginViewController = LoginViewController()
            self.navigationController?.setViewControllers([loginViewController], animated: true)
        }
    }
    private func NavigateToHome() {
        DispatchQueue.main.async {
            let homeViewController = HomeViewController()
            self.navigationController?.setViewControllers([homeViewController], animated: true)
        }
    }
}
