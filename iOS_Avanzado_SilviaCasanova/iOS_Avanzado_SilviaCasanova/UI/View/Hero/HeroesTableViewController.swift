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
    
    override func viewDidLoad() {
        title = "Héroes"
        super.viewDidLoad()
        viewModel.fetchHeroesList()
        tableView.register(
            UINib(nibName: "Cell", bundle: nil),
            forCellReuseIdentifier: Cell.identifier
        )
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    func setObservers() {
        viewModel.viewState = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .reloadData:
                    self?.reloadData()
                    
                case .navigateToDetail:
                    self?.navigateToDetail()
                }
            }
        }
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    func navigateToDetail() {
        
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
