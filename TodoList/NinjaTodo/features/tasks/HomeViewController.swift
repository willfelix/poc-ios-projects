//
//  HomeTableViewController.swift
//  NinjaTodo
//
//  Created by Will Felix on 02/07/20.
//  Copyright © 2020 Will Felix. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    let db = DB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.text = Auth.username()
        
        self.textField.attributedPlaceholder = NSAttributedString(string: "Enter task...",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        self.tableView.alwaysBounceVertical = false;
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    @IBAction func onAddTask(_ textField: UITextField) {
    
        textField.resignFirstResponder()  //if desired
        
        let text = textField.text ?? ""
        self.db.add(title: text)
        
        textField.text = ""
        self.tableView.reloadData()
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "task_cell", for: indexPath) as! TaskTableViewCell
        
        let tasks = self.db.tasks().map { "\($0.key)" }
        cell.title?.text = tasks[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.db.tasks().count
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let closeAction = UIContextualAction(style: .normal, title:  "Close", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                print("OK, marked as Closed")
                success(true)
            })
            closeAction.image = UIImage(systemName: "trash")
            closeAction.backgroundColor = .red
    
            return UISwipeActionsConfiguration(actions: [closeAction])
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
        
        let controller = EditTaskViewController()
        controller.task = cell.title?.text
        
        navigationController?.pushViewController(
            controller,
            animated: true
        )

    }
        
}
