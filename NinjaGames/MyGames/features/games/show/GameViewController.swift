//
//  GameViewController.swift
//  MyGames
//
//  Created by Will Felix on 16/07/20.
//  Copyright © 2020 Will Felix. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbConsole: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var ivCover: UIImageView!
    
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        lbTitle.text = game?.title
        lbConsole.text = game?.console?.name
        if let releaseDate = game?.releaseDate {
            let formatter = DateFormatter()
            // forçando usar o formato de data do Brasil
            // Note: procure fazer da forma de obter automaticamente do sistema
            formatter.dateStyle = .long
            formatter.locale = Locale(identifier: "pt-BR")
            lbReleaseDate.text = "Lançamento: " + formatter.string(from: releaseDate)
        }
       
        if let image = game?.cover as? UIImage {
            ivCover.image = image
        } else {
            ivCover.image = UIImage(named: "noCoverFull")
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddEditViewController
        vc.game = game
    }

}
