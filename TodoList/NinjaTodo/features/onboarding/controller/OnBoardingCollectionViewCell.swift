//
//  OnBoardingCollectionViewCell.swift
//  NinjaTodo
//
//  Created by Will Felix on 30/06/20.
//  Copyright © 2020 Will Felix. All rights reserved.
//

import UIKit
import Lottie

class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var animationContainer: UIView!
    
    var page: Page = Page(animation: "", title: "", description: "")
    
    // Instance of the Lottie AnimationView
    var animation = AnimationView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func build(page: Page) {
        // define the animation and the size
        animation = AnimationView(name: page.animation)
        animation.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height * 0.8)
        
        // customize the animation
        animation.animationSpeed = 1
        animation.loopMode = .loop
        animation.play()
        
        animationContainer.addSubview(animation)
        
        // set the title and description of the screen
        self.titleLabel.text = page.title
        self.descriptionTextView.text = page.description
    }

}
