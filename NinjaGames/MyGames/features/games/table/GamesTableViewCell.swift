//
//  GameTableViewCell.swift
//  MyGames
//
//  Created by Will Felix on 16/07/20.
//  Copyright © 2020 Will Felix. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbConsole: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepare(with game: Game) {
        lbTitle.text = game.title ?? ""
        lbConsole.text = game.console?.name ?? ""
        if let image = game.cover as? UIImage {
            ivCover.image = image
        } else {
            ivCover.image = UIImage(named: "noCover")
        }
    }
    
}
