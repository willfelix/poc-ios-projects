//
//  OnBoardingViewController.swift
//  NinjaTodo
//
//  Created by Will Felix on 30/06/20.
//  Copyright © 2020 Will Felix. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let items: [Page] = [
        Page(animation: "animation1",
             title: "Welcome to the Ninja Todo",
             description: "Here you will get organized with creation of lists"),
                         
        Page(animation: "animation2",
             title: "Todo List",
             description: "Create all necessary tasks that you could need"),
                         
        Page(animation: "animation3",
             title: "Focus",
             description: "Gain focus and a ligther life")
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
    
    @IBAction func onPageChanges(_ sender: Any) {
        let pc = sender as! UIPageControl
        
        // scrolling the collectionView to the selected page
        collectionView.scrollToItem(at: IndexPath(item: pc.currentPage, section: 0),
                                    at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func onSkipButtonPressed(_ sender: Any) {
        // move the user to the other view controller
        print("Move to other view controller")
        
//        self.navigationController?.presentViewController(
//            setViewController,
//            animated: false,
//            completion: nil
//        )
    }
}
