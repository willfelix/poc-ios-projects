//
//  ViewController.swift
//  NinjaTodo
//
//  Created by Will Felix on 29/06/20.
//  Copyright © 2020 Will Felix. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func onEnter(_ sender: Any) {
        
        let name = nameTextField.text
        if name?.isEmpty ?? false {
            
            let alertController = UIAlertController(
                title: "Nome",
                message: "Campo obrigatório",
                preferredStyle: .alert
            )
            
            let button = UIAlertAction(
                title: "OK",
                style: .cancel
            )
            
            alertController.addAction(button)
            
            present(alertController,
                    animated: true)
            
            return
            
        }
        
        Auth.signin(name: name!)
        navigationController?.pushViewController(
            UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()!,
            animated: true
        )
        
    }
    
}
