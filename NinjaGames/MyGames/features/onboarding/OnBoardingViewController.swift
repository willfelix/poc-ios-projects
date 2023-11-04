//
//  OnBoardingViewController.swift
//  MyGames
//
//  Created by Will Felix on 17/07/20.
//  Copyright © 2020 Douglas Frari. All rights reserved.
//

import UIKit

struct Page {
    let animation: String
    let title: String
    let description: String
}

class OnBoardingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let items: [Page] = [
        Page(animation: "ninja",
             title: "Welcome to the Ninja Games",
             description: "Here you will get organized with creation of lists"),
                         
        Page(animation: "zoro",
             title: "Roronoa Zoro inspires you",
             description: "Create all necessary tasks that you could need"),
                
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
   
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var skipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)

        // to make the button rounded
        self.skipButton.layer.cornerRadius = 20
        
        // set the number of pages to the number of Onboarding Screens
        self.pageControl.numberOfPages = self.items.count
        
        // register the custom CollectionViewCell and assign the delegates to the ViewController
        self.collectionView.backgroundColor = .white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(
            UINib(nibName: "OnBoardingCollectionViewCell", bundle: Bundle.main),
            forCellWithReuseIdentifier: "cell"
        )
    }
    
    @IBAction func onPageChanges(_ pc: UIPageControl) {
        // scrolling the collectionView to the selected page
        collectionView.scrollToItem(at: IndexPath(item: pc.currentPage, section: 0),
                                    at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func OnClickSkipbutton(_ sender: UIButton) {
        
        let controller = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as UIViewController?
        controller?.modalPresentationStyle = .fullScreen
        present(controller!, animated: true)
        
    }
}

extension OnBoardingViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnBoardingCollectionViewCell
        
        cell.build(page: self.items[indexPath.item])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
}
