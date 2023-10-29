//
//  LoginViewController.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 28/10/23.
//

import UIKit
protocol LoginViewControllerDelegate {
    func fetchLogin(with email: String?, password: String?)
    var viewState: ((LoginViewState) -> Void)? { get set}
}
enum LoginViewState {
    case loading(_isloading: Bool)
    case navigateToHome
    
}
class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var loadingView: UIView!
    var viewModel = LoginViewModel()
        override func viewDidLoad() {
        super.viewDidLoad()
        setObservers()

        // Do any additional setup after loading the view.
    }
  
    @IBAction func onLoginPressed(_ sender: Any) {
        viewModel.fetchLogin(
            with: emailTextfield.text ,
            password: passwordTextfield.text)
    }
    
    private func navigateToHome() {
   
        let heroesTableViewController = HeroesTableViewController()
        navigationController?.pushViewController(heroesTableViewController, animated: true)
        
    }
    func setObservers() {
        viewModel.viewState = { [weak self] state in
                    DispatchQueue.main.async {
                        switch state {
                            case .loading(let isLoading):
                            self?.loadingView.isHidden  = !isLoading

                        case .navigateToHome:
                            self?.navigateToHome()
                        }
                    }
                }
    }
 

}
