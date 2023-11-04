//
//  LoginContainerViewController.swift
//  MyGames
//
//  Created by Will Felix on 17/07/20.
//  Copyright © 2020 Douglas Frari. All rights reserved.
//

import UIKit

protocol LoginContainerViewControllerDelegate {
    func onLogin(_ username: String)
}

class LoginContainerViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    private lazy var portraitViewController: UIViewController? = {
        return UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "login")
    }()
    
    private lazy var landscapeViewController: UIViewController? = {
        return UIStoryboard(name: "LoginLandscape", bundle: nil).instantiateInitialViewController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        deviceOrientationDidChange()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.deviceOrientationDidChange()
    }
    
    private func deviceOrientationDidChange() {
        let orientation = UIDevice.current.orientation
        if orientation.isLandscape {
            addChildController(child: landscapeViewController)
        } else {
            addChildController(child: portraitViewController)
        }
    }
    
    func addChildController(child: UIViewController?) {
        guard let child = child else {
            return
        }
        
        child.view.translatesAutoresizingMaskIntoConstraints = false
        
        (child as! LoginViewController).delegate = self
        
        containerView.addSubview(child.view)
        
        configureChildConstraints(child: child.view)
    }
    
    
    func configureChildConstraints(child: UIView?) {
        child?.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        child?.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        child?.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        child?.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }

}

extension LoginContainerViewController: LoginContainerViewControllerDelegate {
    
    func onLogin(_ username: String) {
        Auth.signin( name: username.uppercased() )

        navigationController?.pushViewController(
            UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!,
            animated: true
        )
    }
    
}
