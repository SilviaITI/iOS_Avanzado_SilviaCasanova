//
//  HomeViewController.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 6/11/23.
//

import UIKit

protocol HomeTableViewControllerDelegate {

        func  fetchHeroesList()
        var viewState: ((HeroesViewState) -> Void)? { get set}
        
    }

    enum HeroesViewState {
      
        case navigateToDetail
        case reloadData
    }
class HomeViewController: UIViewController {
    
    @IBOutlet weak var logOut: UITabBarItem!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapItem: UITabBarItem!
    @IBOutlet weak var heroesTableView: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    

    
    var viewModel = HeroesViewModel()
    var heroes: [Hero] = []
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        heroesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Héroes"
        heroesTableView.dataSource = self
        heroesTableView.delegate = self
        viewModel.fetchHeroesList()
        heroesTableView.register(
            UINib(nibName: "Cell", bundle: nil),
            forCellReuseIdentifier: Cell.identifier
        )
        setObservers()
        tabBar.delegate = self
       
        heroesTableView.reloadData()
        
        
    }
    
    // MARK: - Table view data source
    func setObservers() {
        viewModel.viewState = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .reloadData:
                    self?.reloadData()
                    
                case .navigateToDetail:
                    print("navigating to detail")
                }
            }
        }
    }
    
    func reloadData() {
        heroesTableView.reloadData()
    }
}
        
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.heroesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath)
                as? Cell else {
            return UITableViewCell()
        }
        if let hero = viewModel.heroBy(index: indexPath.row) {
            cell.updateData(with: hero)
            
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        Cell.estimatedHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hero = viewModel.heroBy(index: indexPath.row)
                  let detailViewController = DetailViewController()
                  detailViewController.hero = hero
                  navigationController?.show(detailViewController, sender: nil)
                  tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
   
                
extension HomeViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == logOut {
            if  let token = SecureDataProvider.shared.getToken() {
                let splashViewController = SplashViewController()
                navigationController?.setViewControllers([splashViewController], animated: true)
                SecureDataProvider.shared.deleteToken(token: token)
                CoreDataManager.shared.deleteAll()
            }
        } else if item == mapItem {
                print("pulsado")
                let mapViewController = MapViewController()
                mapViewController.heroes = viewModel.heroes
                navigationController?.pushViewController(mapViewController, animated: true)
            }
        }
    }

