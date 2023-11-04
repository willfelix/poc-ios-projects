//
//  ConsolesTableViewController.swift
//  MyGames
//
//  Created by Will Felix on 16/07/20.
//  Copyright © 2020 Will Felix. All rights reserved.
//

import UIKit

class ConsolesTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadConsoles()
    }
    
    func loadConsoles() {
        ConsolesManager.shared.loadConsoles(with: context)
        tableView.reloadData()
    }

    func showAlert(with console: Console?) {
        let title = console == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title + " plataforma", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Nome da plataforma"
            
            if let name = console?.name {
                textField.text = name
            }
        })
        
        alert.addAction(UIAlertAction(title: title, style: .default, handler: {(action) in
            let console = console ?? Console(context: self.context)
            console.name = alert.textFields?.first?.text
            do {
                try self.context.save()
                self.loadConsoles()
            } catch {
                print(error.localizedDescription)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.view.tintColor = UIColor(named: "second")
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addConsole(_ sender: UIBarButtonItem) {
        showAlert(with: nil)
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        Auth.signout()
    }
}

extension ConsolesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ConsolesManager.shared.consoles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "console_table_cell", for: indexPath)
        let console = ConsolesManager.shared.consoles[indexPath.row]
        cell.textLabel?.text = console.name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let console = ConsolesManager.shared.consoles[indexPath.row]
        showAlert(with: console)
        
        tableView.deselectRow(at: indexPath, animated: false)
     }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        ConsolesManager.shared.deleteConsole(index: indexPath.row, context: context)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
}
