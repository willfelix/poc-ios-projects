//
//  AddEditTaskViewController.swift
//  NinjaTodo
//
//  Created by Will Felix on 02/07/20.
//  Copyright © 2020 Will Felix. All rights reserved.
//

import UIKit

class EditTaskViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    var task: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = self.task ?? ""
        
        self.textField.placeholder = self.task ?? ""
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        let db = DB()
        db.remove(title: task!)
        db.add(title: self.textField.text!)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func onDelete(_ sender: UIButton) {
        
        let db = DB()
        db.remove(title: task!)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
