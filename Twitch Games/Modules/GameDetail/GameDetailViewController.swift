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
    
    var viewModel: GameDetailViewModel!
    var game: GameModel!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateViewModel()
        setup()
    }
    
    // MARK: Private methods
    
    private func setup() {
        
        self.title = self.viewModel.gameName
        self.navigationController?.title = self.viewModel.gameName
        
        self.viewers.text = self.viewModel.viewers
        self.channels.text = self.viewModel.channels
        
        if let imageUrl = URL(string: self.viewModel.cover) {
            self.cover.af_setImage(withURL: imageUrl)
        }
    }
    
    private func initiateViewModel() {
        self.viewModel = GameDetailViewModel(game: self.game)
    }
}
