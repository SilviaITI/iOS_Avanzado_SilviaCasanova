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
}
enum SplashViewState {
    case loading(_ isLoading: Bool)
    case navigateToLogin
}
class SplashViewController: UIViewController {

    @IBOutlet var loadingView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onViewAppear()
        setObservers()
        
    }
    var viewModel = SplashViewModel()
    
    func NavigateToLogin() {
        DispatchQueue.main.async {
            let loginViewController = LoginViewController()
            self.navigationController?.show(loginViewController, sender: nil)
        }
    }
    private func setObservers() {
        viewModel.viewState = { [weak self] state in
              DispatchQueue.main.async {
                  switch state {
                      case .loading(let isLoading):
                      self?.loadingView.isHidden = !isLoading

                      case .navigateToLogin:
                          self?.NavigateToLogin()
                  }
              }
          }
      }
}
