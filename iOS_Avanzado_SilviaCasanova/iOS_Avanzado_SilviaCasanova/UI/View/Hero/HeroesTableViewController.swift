//
//  HeroesTableViewController.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 28/10/23.
//

import UIKit

protocol HeroesTableViewControllerDelegate {
    func  fetchHeroesList()
    var viewState: ((HeroesViewState) -> Void)? { get set}
    
}

enum HeroesViewState {
  
    case navigateToDetail
    case reloadData
}
class HeroesTableViewController: UITableViewController {
    
    var viewModel = HeroesViewModel()
    var heroes: [Hero] = []
    @IBOutlet weak var tabBar: UITabBar!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        title = "Héroes"
        super.viewDidLoad()
        viewModel.fetchHeroesList()
        tableView.register(
            UINib(nibName: "Cell", bundle: nil),
            forCellReuseIdentifier: Cell.identifier
        )
        setObservers()
        tableView.reloadData()
        tabBar.delegate = self
       
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
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        Cell.estimatedHeight
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.heroesCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) { // para presentar la
            let hero = viewModel.heroBy(index: indexPath.row)
            let detailViewController = DetailViewController()
            detailViewController.hero = hero
            navigationController?.show(detailViewController, sender: nil)
            tableView.deselectRow(at: indexPath, animated: true)
            
            
        }
}
            
extension HeroesTableViewController: UITabBarDelegate {
      func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
          if item.tag == 1 {
              let token = SecureDataProvider.shared.getToken()!
              let splashViewController = SplashViewController()
              navigationController?.setViewControllers([splashViewController], animated: true)
              SecureDataProvider.shared.deleteToken(token: token)
              CoreDataManager.shared.deleteAll()
          } else if item.tag == 2 {
              let mapViewController = MapViewController()
              mapViewController.heroes = viewModel.heroes
              navigationController?.pushViewController(mapViewController, animated: true)
          }
      }
  }
