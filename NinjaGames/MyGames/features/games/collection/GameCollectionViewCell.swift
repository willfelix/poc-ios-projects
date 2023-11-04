//
//  GameCollectionViewCell.swift
//  MyGames
//
//  Created by Will Felix on 18/07/20.
//  Copyright © 2020 Douglas Frari. All rights reserved.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var consoleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func build(with game: Game) {
        self.titleLbl.text = game.title ?? ""
        self.consoleLbl.text = game.console?.name ?? ""
        if let image = game.cover as? UIImage {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "noCover")
        }
    }

}
