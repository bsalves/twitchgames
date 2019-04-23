//
//  GameDetailViewController.swift
//  Twitch Games
//
//  Created by Bruno Alves on 22/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import UIKit
import AlamofireImage

class GameDetailViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var viewers: UILabel!
    @IBOutlet weak var channels: UILabel!
    @IBOutlet weak var cover: UIImageView!
    
    // MARK: Properties
    
    var game: GameModel!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Private methods
    
    private func setup() {
        self.title = self.game?.gameName
        self.navigationController?.title = game.gameName
        
        if let imageUrl = URL(string: game.imageUrl) {
            self.cover.af_setImage(withURL: imageUrl)
        }
    }
}
