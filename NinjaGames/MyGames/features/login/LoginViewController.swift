//
//  LoginViewController.swift
//  MyGames
//
//  Created by Will Felix on 17/07/20.
//  Copyright © 2020 Douglas Frari. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var delegate: LoginContainerViewControllerDelegate?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textFieldLandscape: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onPressReturn(_ sender: UITextField) {
        sender.resignFirstResponder()
        signin(sender.text)
    }
    
    @IBAction func login(_ sender: UIButton) {
        signin(textField.text)
    }
    
    @IBAction func onPressReturnLandscape(_ sender: UITextField) {
        sender.resignFirstResponder()
        signin(sender.text)
    }
    
    @IBAction func loginLandscape(_ sender: UIButton) {
        signin(textFieldLandscape.text)
    }
}

extension LoginViewController {
    
    private func signin(_ username: String?) {
        guard let username = username else {
            showAlert()
            return
        }
        
        if "ninja" != username.lowercased() {
            
            showAlert()
            return
        }
        
        self.delegate?.onLogin(username)
        
    }
    
    private func showAlert() {
        let alertController = UIAlertController(
            title: "Login",
            message: "Username does not exist!",
            preferredStyle: .alert
        )
        
        let button = UIAlertAction(
            title: "Try Again",
            style: .cancel
        )
        
        alertController.addAction(button)
        
        present(alertController,
                animated: true)
    }
    
}
