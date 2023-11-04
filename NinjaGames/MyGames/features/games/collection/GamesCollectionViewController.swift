//
//  GamesCollectionViewController.swift
//  MyGames
//
//  Created by Will Felix on 18/07/20.
//  Copyright © 2020 Douglas Frari. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "game_collection_cell"

class GamesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
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
        
        self.collectionView.register(
            UINib(nibName: "GameCollectionViewCell", bundle: Bundle.main),
            forCellWithReuseIdentifier: reuseIdentifier
        )
        
        self.loadGames()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func addGame(_ sender: UIBarButtonItem) {
        
        let controller = AddEditViewController()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        Auth.signout()
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultController?.fetchedObjects?.count ?? 0

    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GameCollectionViewCell
    
        guard let game = fetchedResultController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        
        cell.build(with: game)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = GameViewController()
        if let games = fetchedResultController.fetchedObjects {
            controller.game = games[indexPath.row]
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    

}

extension GamesCollectionViewController: NSFetchedResultsControllerDelegate {
    
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

extension GamesCollectionViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        print("UPDATE SEARCH RESULTS")
    }
   
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadGames()
        collectionView.reloadData()
    }
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadGames(filtering: searchBar.text!)
        collectionView.reloadData()
    }
}

