//
//  OnBoardCollectionViewCell.swift
//  MyGames
//
//  Created by Will Felix on 17/07/20.
//  Copyright © 2020 Douglas Frari. All rights reserved.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    var page: Page = Page(animation: "", title: "", description: "")
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func build(page: Page) {
        self.imageView.image = UIImage(named: page.animation)
        self.titleLabel.text = page.title
        self.textView.text = page.description
    }
}
