//
//  GamesTableViewController.swift
//  MyGames
//
//  Created by Will Felix on 16/07/20.
//  Copyright © 2020 Will Felix. All rights reserved.
//

import UIKit
import CoreData

class GamesTableViewController: UITableViewController {

    lazy var label: UILabel? = {
        let label = UILabel()
        label.text = "Você não tem jogos cadastrados"
        label.textAlignment = .center
        return label
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchTextField.backgroundColor = .white
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        return searchController
    }()
    
    var fetchedResultController: NSFetchedResultsController<Game>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
        
        loadGames()
        
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(refreshTable),
                         name: NSNotification.Name(rawValue: "refresh"),
                         object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func refreshTable(notification: NSNotification) {
        
        self.tableView.reloadData()
        
    }
    
    @IBAction func addGame(_ sender: UIBarButtonItem) {

        let controller = AddEditViewController()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        
        Auth.signout()
        
    }
    
    func loadGames(filtering: String = "") {
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if filtering.isEmpty == false {
            let predicate = NSPredicate(format: "title contains [c] %@", filtering)
            fetchRequest.predicate = predicate
        }
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        
        do {
            try fetchedResultController.performFetch()
        } catch  {
            print(error.localizedDescription)
        }
    }
    
}

extension GamesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultController?.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? label : nil
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "game_table_cell", for: indexPath) as! GameTableViewCell
        guard let game = fetchedResultController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        
        cell.prepare(with: game)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = GameViewController()
        if let games = fetchedResultController.fetchedObjects {
            controller.game = games[tableView.indexPathForSelectedRow!.row]
        }
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            guard let game = fetchedResultController.fetchedObjects?[indexPath.row] else {
                print("Nao foi possivel obter o Game da linha selecionada para deletar")
                return
            }
            
            context.delete(game)
            
            do {
                try context.save()
                // efeito visual deletar poderia ser feito aqui, porem, faremos somente se o banco de dados
                // reagir informando que ocorreu uma mudanca (NSFetchedResultsControllerDelegate)
            } catch  {
                print(error.localizedDescription)
            }
        }
    }
    
}

extension GamesTableViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            if let indexPath = indexPath {
                // Delete the row from the data source
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        default:
            tableView.reloadData()
        }
    }
    
}

extension GamesTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        print("UPDATE SEARCH RESULTS")
    }
   
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadGames()
        tableView.reloadData()
    }
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadGames(filtering: searchBar.text!)
        tableView.reloadData()
    }
}
